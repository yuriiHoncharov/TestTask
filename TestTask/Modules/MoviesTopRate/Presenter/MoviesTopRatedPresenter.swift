//
//  MoviesTopRatedPresenter.swift
//  TestTask
//
//  Created by Yurii Honcharov on 04.04.2023.
//

import Foundation

protocol MoviesTopRatedPresenterProtocol {
    func getData()
    func reloadData()
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
        let vc = MoviesInfoViewController.fromStoryboard
        vc.getId = self.movieTopRate[indexPath.row].id
        print(self.movieTopRate[indexPath.row].id)
        self.view.navigationController?.pushViewController(vc, animated: true)
    }
    
    func reloadData() {
        page = 0
        movieTopRate = []
        getData()
    }
    
    func getData() {
        guard !isLoading else { return }
        
        page += 1
        isLoading = true
        let params = TopRateApiEntity.Request(language: Language.english.rawValue, page: page)
        
        movieApi.getAllTopMovies(params: params) { [weak self] response in
            guard let self else { return }
            
            DispatchQueue.main.async {
                var topMovies: [MovieEntity] = []
                switch response {
                case .success(let model):
                    if let error = model.error {
                        print(error)
                    } else {
                        let items = model.results ?? []
                        let movies = items.map {
                            MovieEntityMapper.mapTop($0, dateUtility: DateFormatterUtility())
                        }
                        topMovies = movies
                        self.movieTopRate.append(contentsOf: topMovies)
                        self.view.reloadData(with: self.movieTopRate)
                        self.isLoading = false
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
