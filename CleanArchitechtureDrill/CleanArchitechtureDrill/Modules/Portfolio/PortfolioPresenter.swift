//  
//  PortfolioPresenter.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 29/12/23.
//
//  Template author: leowirasanto

import Foundation

class PortfolioPresenter: IPortfolioPresenter {
    private let interactor: IPortfolioInteractor
    private let router: IPortfolioRouter
    private let parameters: [String: Any]?
    weak var view: IPortfolioViewController?
    
    init(interactor: IPortfolioInteractor, router: IPortfolioRouter, parameters: [String: Any]?) {
        self.interactor = interactor
        self.router = router
        self.parameters = parameters
    }
    
    func viewDidLoad(view: IPortfolioViewController) {
        self.view = view
    }
    //TODO: - add your code here
}
