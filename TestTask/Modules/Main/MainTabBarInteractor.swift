//
//  MainTabBarInteractor.swift
//  Dogiz
//
//  Created by Yurii Honcharov on 24.03.2023.
//
import Foundation

protocol MainTabBarInteractorProtocol {
}

protocol MainTabBarDataStore: AnyObject {
}

class MainTabBarInteractor: MainTabBarInteractorProtocol, MainTabBarDataStore {
    private let presenter: MainTabBarPresenterProtocol?
    
    required init(presenter: MainTabBarPresenterProtocol) {
        self.presenter = presenter
    }
}
