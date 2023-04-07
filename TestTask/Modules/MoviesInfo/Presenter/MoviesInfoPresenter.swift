//
//  MoviesInfoPresenter.swift
//  TestTask
//
//  Created by Yurii Honcharov on 29.03.2023.
//

import Foundation

protocol MoviesInfoPresenterProtocol: AnyObject {
    init(view: MoviesInfoViewControllerProtocol, id: Int)
    var movieInfo: MovieInfoEntity? { get set }
    func getData()
}

class MoviesInfoPresenter: MoviesInfoPresenterProtocol {
    // MARK: properties
    private unowned var view: MoviesInfoViewControllerProtocol!
    private let movieApi = MovieRequest()
    var movieInfo: MovieInfoEntity?
    let id: Int
    
    required init(view: MoviesInfoViewControllerProtocol, id: Int) {
        self.view = view
        self.id = id
    }
    
    func getData() {
        getMovieInfoById(id: id) { [weak self] item in
            guard let self else { return }
            self.movieInfo = item
            self.view.display(entity: self.movieInfo!)
            self.view.reloadData()
        }
    }
    
    private func getMovieInfoById(id: Int, completionHandler: ((_ item: MovieInfoEntity?) -> Void)?) {
        let params = MovieInfoApiEntity.Request(language: Language.english.rawValue)
        movieApi.getMovieById(id: id, params: params) { response in
            DispatchQueue.main.async {
                var newMovieInfo: MovieInfoEntity?
                switch response {
                case .success(let model):
                    if let error = model.error {
                        print(error)
                    } else {
                        let movies = MovieInfoEntityMapper.map(model, dateUtility: DateFormatterUtility())
                        newMovieInfo = movies
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                completionHandler?(newMovieInfo)
            }
        }
    }
}
