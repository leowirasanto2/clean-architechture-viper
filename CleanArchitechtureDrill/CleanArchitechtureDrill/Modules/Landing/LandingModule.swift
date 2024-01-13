//  
//  LandingModule.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 29/12/23.
//
//  Template author: leowirasanto

import Foundation
import UIKit

class LandingModule: ILandingModule {
    
    init() {}
    
    func getLandingPage(parameters: [String: Any]?) -> UIViewController {
        let service = DefaultAPIService(baseUrl: "")
        let interactor = LandingInteractor(service: LandingService(service: service))
        let router = LandingRouter()
        let presenter = LandingPresenter(interactor: interactor, router: router, parameters: parameters)
        let viewController = LandingViewController(presenter: presenter)
        router.viewController = viewController
        interactor.presenter = presenter
        return viewController
    }
}
