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
        case .home: return UIImage(named: "Home") ?? .add
        case .favourite: return UIImage(named: "Favourite") ?? .add
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .home: return UIImage(named: "HomeSelected") ?? .add
        case .favourite: return UIImage(named: "FavouriteSelected") ?? .add
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .home: return ViewController()
        case .favourite: return ViewController()
        }
    }
}
