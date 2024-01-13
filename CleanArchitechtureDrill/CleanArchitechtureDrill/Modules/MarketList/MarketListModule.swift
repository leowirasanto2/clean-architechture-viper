//  
//  MarketListModule.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 29/12/23.
//
//  Template author: leowirasanto

import Foundation
import UIKit

class MarketListModule: IMarketListModule {
    
    init() {
    }
    
    func getMarketListPage(parameters: [String: Any]?) -> UIViewController {
        let interactor = MarketListInteractor()
        let router = MarketListRouter()
        let presenter = MarketListPresenter(interactor: interactor, router: router, parameters: parameters)
        let viewController = MarketListViewController(presenter: presenter)
        router.viewController = viewController
        interactor.presenter = presenter
        return viewController
    }
}
