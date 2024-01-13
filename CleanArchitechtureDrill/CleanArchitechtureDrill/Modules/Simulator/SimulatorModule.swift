//  
//  SimulatorModule.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 30/12/23.
//
//  Template author: leowirasanto

import Foundation
import UIKit

class SimulatorModule: ISimulatorModule {
    
    init() {}
    
    func getSimulatorPage(parameters: [String: Any]?) -> UIViewController {
        let interactor = SimulatorInteractor()
        let router = SimulatorRouter()
        let presenter = SimulatorPresenter(interactor: interactor, router: router, parameters: parameters)
        let viewController = SimulatorViewController(presenter: presenter)
        router.viewController = viewController
        interactor.presenter = presenter
        return viewController
    }
    
    func getPreview() -> SimulatorViewController {
        let interactor = SimulatorInteractor()
        let router = SimulatorRouter()
        let presenter = SimulatorPresenter(interactor: interactor, router: router, parameters: nil)
        let viewController = SimulatorViewController(presenter: presenter)
        router.viewController = viewController
        interactor.presenter = presenter
        return viewController
    }
}
