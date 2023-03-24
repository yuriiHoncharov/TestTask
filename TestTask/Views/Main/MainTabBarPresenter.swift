//
//  MainTabBarPresenter.swift
//  Dogiz
//
//  Created by Yurii Honcharov on 24.03.2023.


import Foundation

protocol MainTabBarPresenterProtocol {
}

class MainTabBarPresenter: MainTabBarPresenterProtocol {
    private unowned let view: MainTabBarControllerProtocol
    
    required init(view: MainTabBarControllerProtocol) {
        self.view = view
    }
}
