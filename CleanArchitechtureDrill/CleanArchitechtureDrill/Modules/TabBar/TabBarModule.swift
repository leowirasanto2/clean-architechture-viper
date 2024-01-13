//  
//  TabBarModule.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 29/12/23.
//
//  Template author: leowirasanto

import Foundation
import UIKit

class TabBarModule: ITabBarModule {
    init() {}
    
    func getTabBarPage(parameters: [String: Any]?) -> UIViewController {
        let interactor = TabBarInteractor()
        let router = TabBarRouter()
        let presenter = TabBarPresenter(interactor: interactor, router: router, parameters: parameters)
        let viewController = TabBarViewController(presenter: presenter)
        router.viewController = viewController
        interactor.presenter = presenter
        return viewController
    }
}
