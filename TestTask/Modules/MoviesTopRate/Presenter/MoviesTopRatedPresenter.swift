//
//  MoviesTopRatedPresenter.swift
//  TestTask
//
//  Created by Yurii Honcharov on 04.04.2023.
//

import Foundation

protocol MoviesTopRatedPresenterProtocol {
    func getData() async
    func reloadData() async
    func moveToMovieInfo(_ indexPath: IndexPath)
}

class MoviesTopRatedPresenter: MoviesTopRatedPresenterProtocol {
    // MARK: properties
    private unowned let view: MoviesTopRatedViewControllerProtocol
    private let movieApi = MovieRequest()
    var movieTopRate: [MovieEntity] = []

    private var page: Int = 0
    private var isLoading: Bool = false

    required init(view: MoviesTopRatedViewControllerProtocol) {
        self.view = view
    }

    func moveToMovieInfo(_ indexPath: IndexPath) {
        let id = self.movieTopRate[indexPath.row].id
        view.moveToMovieInfo(id: id)
    }

    func reloadData() async {
        page = 0
        movieTopRate = []
        Task {
            await getData()
        }
    }

    func getData() async {
        guard !isLoading else { return }

        page += 1
        isLoading = true
        let params = TopRateApiEntity.Request(language: Language.english.rawValue, page: page)

        do {
            let upcomingMovie = try await movieApi.getAllTopMovies(params: params)

            var upcomingMovies: [MovieEntity] = []

            if let error = upcomingMovie.error {
                print(error)
            } else {
                let items = upcomingMovie.results ?? []
                let movies = items.map {
                    MovieEntityMapper.mapTop($0, dateUtility: DateFormatterUtility())
                }
                upcomingMovies = movies
                self.movieTopRate.append(contentsOf: upcomingMovies)
                self.view.reloadData(with: self.movieTopRate)
                self.isLoading = false
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
