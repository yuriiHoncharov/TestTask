//
//  MovieListPresenter.swift
//  TestTask
//
//  Created by Yurii Honcharov on 24.03.2023.
//

import Foundation

protocol MovieListPresenterProtocol {
    func getData()
    func reloadData()
}

class MovieListPresenter: MovieListPresenterProtocol {
    // MARK: properties
    private unowned let view: MovieListTableViewControllerProtocol
    private let movieApi = MovieRequest()
    private var movieUpcoming: [MovieEntity] = []
    
    private var page: Int = 0
    private var isLoading: Bool = false
    
    required init(view: MovieListTableViewControllerProtocol) {
        self.view = view
    }
    
    func reloadData() {
        page = 0
        movieUpcoming = []
        getData()
    }
    
    func getData() {
        guard !isLoading else { return }
        
        isLoading = true
        
        getUpcomingMovies { [weak self] items in
            guard let self else { return }
            
            self.isLoading = false
            self.movieUpcoming.append(contentsOf: items)
            self.view.reloadData(with: self.movieUpcoming)
        }
    }
    
    private func getUpcomingMovies(completionHandler: ((_ item: [MovieEntity]) -> Void)?) {
        page += 1
        let params = UpcomingApiEntity.Request(page: page)
        
        movieApi.getAllUpcomingMovies(params: params) { response in
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
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                completionHandler?(upcomingMovies)
            }
        }
    }
}
