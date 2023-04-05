//
//  MoviesTopRatedPresenter.swift
//  TestTask
//
//  Created by Yurii Honcharov on 04.04.2023.
//

import Foundation

protocol MoviesTopRatedPresenterProtocol {
    func getData()
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
    
    func getData() {
        guard !isLoading else { return }
        
        isLoading = true
        getTopRate { [weak self] items in
            guard let self else { return }
            
            self.isLoading = false
            self.movieTopRate.append(contentsOf: items)
            self.view.reloadData(with: items)
        }
    }
    
    func getTopRate(completionHandler: ((_ item: [MovieEntity]) -> Void)?) {
        page += 1
        let params = TopRateApiEntity.Request(language: Language.english.rawValue, page: page)
        
        movieApi.getAllTopMovies(params: params) {  response in
            DispatchQueue.main.async {
                var topMovies: [MovieEntity] = []
                switch response {
                case .success(let model):
                    if let error = model.error {
                        print(error)
                    } else {
                        let items = model.results ?? []
                        items.forEach { item in
                            let movies = MovieEntityMapper.mapTop(item, dateUtility: DateFormatterUtility())
                            topMovies.append(movies)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                completionHandler?(topMovies)
            }
        }
    }
}
