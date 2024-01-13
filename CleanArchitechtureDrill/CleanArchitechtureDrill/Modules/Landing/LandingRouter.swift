//  
//  LandingRouter.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 29/12/23.
//
//  Template author: leowirasanto

import Foundation
import UIKit

class LandingRouter: ILandingRouter {
    weak var viewController: UIViewController?
    
    init() {}
    
    func navigateToMarketListPage(_ parameters: [String: Any]?) {
        let marketVc = MarketListModule().getMarketListPage(parameters: parameters)
        viewController?.navigationController?.pushViewController(marketVc, animated: true)
    }
    
    func navigateToMarketDetailPage(_ parameters: [String : Any]?) {
        let simulatorVc = SimulatorModule().getSimulatorPage(parameters: parameters)
        viewController?.navigationController?.pushViewController(simulatorVc, animated: true)
    }
}
