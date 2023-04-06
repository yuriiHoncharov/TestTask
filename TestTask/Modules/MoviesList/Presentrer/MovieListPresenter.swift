//
//  MovieListPresenter.swift
//  TestTask
//
//  Created by Yurii Honcharov on 24.03.2023.
//

import Foundation
import UIKit

protocol MovieListPresenterProtocol {
    func getData()
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
        let vc = MoviesInfoViewController.fromStoryboard
        vc.getId = self.movieUpcoming[indexPath.row].id
        print(self.movieUpcoming[indexPath.row].id)
        self.view.navigationController?.pushViewController(vc, animated: true)
    }
    
    func reloadData() {
        page = 0
        movieUpcoming = []
        getData()
    }
    
    func getData() {
        guard !isLoading else { return }
        
        page += 1
        isLoading = true
        let params = UpcomingApiEntity.Request(page: page)
        
        movieApi.getAllUpcomingMovies(params: params) { [weak self] response in
            guard let self else { return }
            
            DispatchQueue.main.async {
                var upcomingMovies: [MovieEntity] = []
                switch response {
                case .success(let model):
                    if let error = model.error {
                        print(error)
                    } else {
                        let items = model.results ?? []
                        let movies = items.map {
                            MovieEntityMapper.mapUpcoming($0, dateUtility: DateFormatterUtility())
                        }
                        upcomingMovies = movies
                        self.movieUpcoming.append(contentsOf: upcomingMovies)
                        self.view.reloadData(with: self.movieUpcoming)
                        self.isLoading = false
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
