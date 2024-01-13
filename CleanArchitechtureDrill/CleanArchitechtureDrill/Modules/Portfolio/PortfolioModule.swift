//  
//  PortfolioModule.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 29/12/23.
//
//  Template author: leowirasanto

import Foundation
import UIKit

class PortfolioModule: IPortfolioModule {
    
    init() {}
    
    func getPortfolioPage(parameters: [String: Any]?) -> UIViewController {
        let interactor = PortfolioInteractor()
        let router = PortfolioRouter()
        let presenter = PortfolioPresenter(interactor: interactor, router: router, parameters: parameters)
        let viewController = PortfolioViewController(presenter: presenter)
        router.viewController = viewController
        interactor.presenter = presenter
        return viewController
    }
}
