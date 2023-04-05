//
//  MovieListPresenter.swift
//  TestTask
//
//  Created by Yurii Honcharov on 24.03.2023.
//

import Foundation

protocol MovieListPresenterProtocol {
    func getData()
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
    
    func getData() {
        guard !isLoading else { return }
        
        isLoading = true
        
        getUpcomingMovies { [weak self] items in
            guard let self else { return }
            
            self.isLoading = false
            self.movieUpcoming.append(contentsOf: items)
            self.view.reloadData(with: items)
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
                        items.forEach { item in
                            let movies = MovieEntityMapper.mapUpcoming(item, dateUtility: DateFormatterUtility())
                            upcomingMovies.append(movies)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                completionHandler?(upcomingMovies)
            }
        }
    }
}
