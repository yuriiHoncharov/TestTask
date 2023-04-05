//
//  MainTabBarRouter.swift
//  Dogiz
//
//  Created by Yurii Honcharov on 24.03.2023.
//

import UIKit

protocol MainTabBarRouterProtocol: AnyObject {
}

class MainTabBarRouter: MainTabBarRouterProtocol {
    private unowned let view: UIViewController
    private unowned let dataStore: MainTabBarDataStore
    
    required init(view: UIViewController, interactor: MainTabBarDataStore) {
        self.view = view
        self.dataStore = interactor
    }
}
