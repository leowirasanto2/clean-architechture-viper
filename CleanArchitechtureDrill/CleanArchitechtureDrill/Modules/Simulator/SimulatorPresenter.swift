//  
//  SimulatorPresenter.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 30/12/23.
//
//  Template author: leowirasanto

import Foundation

class SimulatorPresenter: ISimulatorPresenter {
    private let interactor: ISimulatorInteractor
    private let router: ISimulatorRouter
    private let parameters: [String: Any]?
    weak var view: ISimulatorViewController?
    var viewModel: SimulatorViewModel?
    var pageTitle: String? {
        return "Simulator"
    }
    
    init(interactor: ISimulatorInteractor, router: ISimulatorRouter, parameters: [String: Any]?) {
        self.interactor = interactor
        self.router = router
        self.parameters = parameters
    }
    
    func viewDidLoad(view: ISimulatorViewController) {
        viewModel = SimulatorViewModel.createFormViewModel((parameters?[Constants.marketData] as? MarketListDataViewModel))
        self.view = view
    }
}

extension SimulatorPresenter {
    func calculate(investValue: Double, sellValue: Double) {
        viewModel = viewModel?.convertToResult()
        view?.showResult()
    }
    
    func getForm() {
        view?.showForm()
    }
}
