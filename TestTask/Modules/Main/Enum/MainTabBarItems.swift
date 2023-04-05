//
//  MainTabBarItems.swift
//  Dogiz
//
//  Created by Yurii Honcharov on 24.03.2023.
//

import UIKit

enum MainTabBarItems: Int, CaseIterable {
    case home = 0
    case favourite
    
    var title: String {
        switch self {
        case .home: return L10n.home()
        case .favourite: return L10n.favourite()
        }
    }
    
    var image: UIImage {
        switch self {
        case .home: return UIImage(named: Images.home.name) ?? .add
        case .favourite: return UIImage(named: Images.favorite.name) ?? .add
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .home: return UIImage(named: Images.homeSelected.name) ?? .add
        case .favourite: return UIImage(named: Images.favoriteSelected.name) ?? .add
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .home: return MovieListTableViewController.fromStoryboard
        case .favourite: return MoviesTopRatedViewController.fromStoryboard
        }
    }
}
