//
//  MovieListPresenter.swift
//  TestTask
//
//  Created by Yurii Honcharov on 24.03.2023.
//

import Foundation

protocol MovieListPresenterProtocol {
    init(view: MovieListTableViewControllerProtocol)
    var movieUpcoming: [UpcomingApiEntity.Item] { get }
    func getData()
}


class MovieListPresenter: MovieListPresenterProtocol {
    // MARK: properties
    private unowned let view: MovieListTableViewControllerProtocol
    private let movieApi = MovieRequest()
    var movieUpcoming: [UpcomingApiEntity.Item] = []
    
    var page: Int = 0
//    var isNeedReload: Bool = false
//    var isNextPageExist: Bool = true
//    var shouldDoRequest: Bool = true
    
    required init(view: MovieListTableViewControllerProtocol) {
        self.view = view
    }
    
    func getData() {
        getUpcomingMovies { [weak self] item in
            guard let self else { return }
            self.movieUpcoming.append(contentsOf: item)
            self.view.reloadData()
        }
    }
    
    private func getUpcomingMovies(completionHandler: ((_ item: [UpcomingApiEntity.Item]) -> Void)?) {
//        if isNeedReload { return }
        page += 1
//        isNeedReload = true
        let params = UpcomingApiEntity.Request(apiKey: Constants.apiKey,
                                               language: "en-US",
                                               page: page,
                                               region: "")
        print(page)
        movieApi.getAllUpcomingMovies(params: params) { [weak self] response in
            
            guard let self else { return }
            
            DispatchQueue.main.async {
                var upcomingMovies: [UpcomingApiEntity.Item] = []
                
                switch response {
                case .success(let model):
                    if let error = model.error {
                        print(error)
                    } else {
                        upcomingMovies.append(contentsOf: model.results)
                        self.movieUpcoming.append(contentsOf: upcomingMovies)
//                        self.isNeedReload = false
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                completionHandler?(upcomingMovies)
            }
        }
    }
}
