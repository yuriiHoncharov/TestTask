//
//  MovieListPresenter.swift
//  TestTask
//
//  Created by Yurii Honcharov on 24.03.2023.
//

import Foundation
import UIKit

protocol MovieListPresenterProtocol {
    func getData() async
    func reloadData()
    func moveToMovieInfo(_ indexPath: IndexPath)
}

class MovieListPresenter: MovieListPresenterProtocol {
    // MARK: properties
    private unowned let view: MovieListTableViewControllerProtocol
    private let movieApi = MovieRequest()
    var movieUpcoming: [MovieEntity] = []
    
    private var page: Int = 0
    private var isLoading: Bool = false
    
    required init(view: MovieListTableViewControllerProtocol) {
        self.view = view
    }
    
    func moveToMovieInfo(_ indexPath: IndexPath) {
        let id = self.movieUpcoming[indexPath.row].id
        view.moveToMovieInfo(id: id)
    }
    
    func reloadData() {
        page = 0
        movieUpcoming = []
        Task {
            await getData()
        }
    }
    
    func getData() async {
        guard !isLoading else { return }
        
        page += 1
        isLoading = true
        let params = UpcomingApiEntity.Request(page: page)
        
        do {
            let upcomingMovie = try await movieApi.getAllUpcomingMovies(params: params)
            
            var upcomingMovies: [MovieEntity] = []
            
            if let error = upcomingMovie.error {
                print(error)
            } else {
                let items = upcomingMovie.results ?? []
                let movies = items.map {
                    MovieEntityMapper.mapUpcoming($0, dateUtility: DateFormatterUtility())
                }
                upcomingMovies = movies
                self.movieUpcoming.append(contentsOf: upcomingMovies)
                self.view.reloadData(with: self.movieUpcoming)
                self.isLoading = false
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
