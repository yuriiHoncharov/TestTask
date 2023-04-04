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
    private let worker: MainTabBarWorkerProtocol?
    
    required init(worker: MainTabBarWorkerProtocol, presenter: MainTabBarPresenterProtocol) {
        self.worker = worker
        self.presenter = presenter
    }
}
