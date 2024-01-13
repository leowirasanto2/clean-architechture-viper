//  
//  HistoryModule.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 29/12/23.
//
//  Template author: leowirasanto

import Foundation
import UIKit

class HistoryModule: IHistoryModule {
    
    init() {}
    
    func getHistoryPage(parameters: [String: Any]?) -> UIViewController {
        let interactor = HistoryInteractor()
        let router = HistoryRouter()
        let presenter = HistoryPresenter(interactor: interactor, router: router, parameters: parameters)
        let viewController = HistoryViewController(presenter: presenter)
        router.viewController = viewController
        interactor.presenter = presenter
        return viewController
    }
}
