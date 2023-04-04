//
//  MainTabBarBuilder.swift
//  Dogiz
//
//  Created by Yurii Honcharov on 24.03.2023.
//

import UIKit

struct MainTabBarBuilder {
    typealias Controller = MainTabBarController
    typealias Presenter = MainTabBarPresenter
    
    func`default`() -> Controller {
        let vc = Controller.fromStoryboard
        let presenter = Presenter(view: vc)
        let worker = MainTabBarWorker()
        let interactor = MainTabBarInteractor(worker: worker, presenter: presenter)
        let router = MainTabBarRouter(view: vc, interactor: interactor)
        
        vc.initialSetup(interactor: interactor, router: router)
        return vc
    }
}
