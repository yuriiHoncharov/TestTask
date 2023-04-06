//
//  MoviesInfoPresenter.swift
//  TestTask
//
//  Created by Yurii Honcharov on 29.03.2023.
//

import Foundation

protocol MoviesInfoPresenterProtocol: AnyObject {
    init(view: MoviesInfoViewControllerProtocol)
    var movieInfo: MovieInfoApiEntity.MovieInfo { get set }
    func getData(id: Int)
    func rightButton()
}

class MoviesInfoPresenter: MoviesInfoPresenterProtocol {
    // MARK: properties
    private unowned var view: MoviesInfoViewControllerProtocol!
    private let movieApi = MovieRequest()
    var movieInfo: MovieInfoApiEntity.MovieInfo = .mock
    
    required init(view: MoviesInfoViewControllerProtocol) {
        self.view = view
    }
    
    func rightButton() {
        self.view.navigationController?.popViewController(animated: true)
    }
    
    func getData(id: Int) {
        getMovieInfoById(id: id) { [weak self] item in
            guard let self else { return }
            self.movieInfo = item
            self.view.display(entity: self.movieInfo)
            self.view.reloadData()
        }
    }
    
    private func getMovieInfoById(id: Int, completionHandler: ((_ item: MovieInfoApiEntity.MovieInfo) -> Void)?) {
        let params = MovieInfoApiEntity.Request(language: Language.english.rawValue)
        movieApi.getMovieById(id: id, params: params) { response in
            DispatchQueue.main.async {
                var newMovieInfo: MovieInfoApiEntity.MovieInfo = .mock
                switch response {
                case .success(let model):
                    if let error = model.error {
                        print(error)
                    } else {
                        newMovieInfo = model
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                completionHandler?(newMovieInfo)
            }
        }
    }
}
