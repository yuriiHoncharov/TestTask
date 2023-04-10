//
//  MainTabBarController.swift
//  Dogiz
//
//  Created by Yurii Honcharov on 24.03.2023.
//
import UIKit

protocol MainTabBarControllerProtocol: AnyObject {
}

class MainTabBarController: UITabBarController {
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
    
    private func setupTabBarController() {
        setupTabBar()
        
        self.viewControllers = MainTabBarItems.allCases.map { return setupTabBarControllers($0) }
    }
    
    private func setupTabBarControllers(_ item: MainTabBarItems) -> UIViewController {
        let vc = item.viewController
        let tabBarItem = UITabBarItem(title: item.title,
                                      image: item.image,
                                      selectedImage: item.selectedImage)
        tabBarItem.tag = item.rawValue
        vc.tabBarItem = tabBarItem
        
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.isNavigationBarHidden = true
        
        return navigationController
    }
    
    private func setupTabBar() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: Colors.grayForButton.name) ?? .gray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: Colors.baseOrange.name) ?? .green], for: .selected)
    }
}

extension MainTabBarController: MainTabBarControllerProtocol {
}
