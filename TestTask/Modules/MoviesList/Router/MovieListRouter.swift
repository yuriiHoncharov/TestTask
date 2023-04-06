//
//  MovieListRouter.swift
//  TestTask
//
//  Created by Yurii Honcharov on 06.04.2023.
//

import UIKit

protocol MovieListRouterProtocol: AnyObject {
    func moveToMovieInfo(_ indexPath: IndexPath)
}

class MovieListRouter: MovieListRouterProtocol {
    private unowned let view: UIViewController
    private unowned let presenter: MovieListPresenter
    
    required init(view: UIViewController, presenter: MovieListPresenter) {
        self.view = view
        self.presenter = presenter
    }
        
    func moveToMovieInfo(_ indexPath: IndexPath) {
        let vc = MoviesInfoViewController.fromStoryboard
        vc.getId = self.presenter.movieUpcoming[indexPath.row].id
        print(self.presenter.movieUpcoming[indexPath.row].id)
        view.navigationController?.pushViewController(vc, animated: true)
    }
}
