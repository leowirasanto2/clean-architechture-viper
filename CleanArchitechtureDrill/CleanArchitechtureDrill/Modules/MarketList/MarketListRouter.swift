//  
//  MarketListRouter.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 29/12/23.
//
//  Template author: leowirasanto

import Foundation
import UIKit

class MarketListRouter: IMarketListRouter {
    weak var viewController: UIViewController?
    
    init() {
    }
    
    func navigateToMarketDetailPage(_ parameters: [String : Any]?) {
        let simulatorVc = SimulatorModule().getSimulatorPage(parameters: parameters)
        viewController?.navigationController?.pushViewController(simulatorVc, animated: true)
    }
}
