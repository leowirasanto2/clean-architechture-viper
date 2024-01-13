//  
//  MarketListPresenter.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 29/12/23.
//
//  Template author: leowirasanto

import Foundation

class MarketListPresenter: IMarketListPresenter {
    private let interactor: IMarketListInteractor
    private let router: IMarketListRouter
    private let parameters: [String: Any]?
    weak var view: IMarketListViewController?
    var viewModel: MarketListViewModel?
    var pageTitle: String? {
        (parameters?[Constants.marketSection] as? MarketSection)?.title
    }
    
    init(interactor: IMarketListInteractor, router: IMarketListRouter, parameters: [String: Any]?) {
        self.interactor = interactor
        self.router = router
        self.parameters = parameters
    }
    
    func viewDidLoad(view: IMarketListViewController) {
        self.view = view
    }
}

// MARK: Protocol Implementation
extension MarketListPresenter {
    func getMarketData() {
        view?.startLoader { [weak self] in
            self?.interactor.fetchMarketData()
        }
    }
    
    func successFetchMarketData(_ data: MarketListViewModel?) {
        view?.stopLoader { [weak self] in
            self?.viewModel = data
            self?.view?.showMarketData()
        }
    }
    
    func failedFetchMargetData(_ error: CustomError) {
        view?.stopLoader {}
    }
    
    func selectedData() -> [MarketListDataViewModel]? {
        let section = parameters?[Constants.marketSection] as? MarketSection ?? .all
        return viewModel?.getSectionData(section.index)
    }
    
    func seeMarketDetail(_ selectedMarket: MarketListDataViewModel?) {
        guard let selectedMarket = selectedMarket else { return }
        router.navigateToMarketDetailPage([Constants.marketData: selectedMarket])
    }
}
