//
//  MoviesTopRatedPresenter.swift
//  TestTask
//
//  Created by Yurii Honcharov on 04.04.2023.
//

import Foundation

protocol MoviesTopRatedPresenterProtocol {
    func getData()
    var movieTopRate: [TopRateApiEntity.Item] { get }
    var isLoadMoreItem: Bool { get set }
}

class MoviesTopRatedPresenter: MoviesTopRatedPresenterProtocol {
    // MARK: properties
    private unowned let view: MoviesTopRatedViewControllerProtocol
    private let movieApi = MovieRequest()
    var movieTopRate: [TopRateApiEntity.Item] = []
    
    private var page: Int = 0
    var isLoadMoreItem: Bool = true
    
    required init(view: MoviesTopRatedViewControllerProtocol) {
        self.view = view
    }
    
    func getData() {
        getTopRate { [weak self] item in
            guard let self else { return }
            self.isLoadMoreItem = self.movieTopRate.isEmpty ? true : false
            self.movieTopRate.append(contentsOf: item)
            self.view.reloadData()
        }
    }
    
    func getTopRate(completionHandler: ((_ item: [TopRateApiEntity.Item]) -> Void)?) {
        page += 1
        isLoadMoreItem = false
        let params = TopRateApiEntity.Request(language: Language.english.rawValue, page: page)
        movieApi.getAllTopMovies(params: params) { [weak self] response in
            guard let self else { return }
            DispatchQueue.main.async {
                var topMovies: [TopRateApiEntity.Item] = []
                switch response {
                case .success(let model):
                    if let error = model.error {
                        print(error)
                    } else {
                        topMovies.append(contentsOf: model.results)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                completionHandler?(topMovies)
                self.isLoadMoreItem = true
            }
        }
    }
}
