//  
//  LandingPresenter.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 29/12/23.
//
//  Template author: leowirasanto

import Foundation

class LandingPresenter: ILandingPresenter {
    
    private let interactor: ILandingInteractor
    private let router: ILandingRouter
    private let parameters: [String: Any]?
    weak var view: ILandingViewController?
    var viewModel: MarketListViewModel?
    
    init(interactor: ILandingInteractor, router: ILandingRouter, parameters: [String: Any]?) {
        self.interactor = interactor
        self.router = router
        self.parameters = parameters
    }
    
    func viewDidLoad(view: ILandingViewController) {
        self.view = view
    }
    
}

// MARK: - Protocol Implementation
extension LandingPresenter {
    
    func getLandingPageData() {
        view?.startLoader { [weak self] in
            self?.interactor.fetchMarketData()
        }
    }
    
    func successFetchMarketData(_ data: MarketListViewModel?) {
        view?.stopLoader { [weak self] in
            self?.viewModel = data
            self?.view?.showLandingPageData()
        }
    }
    
    func failedFetchMargetData(_ error: CustomError) {
        view?.stopLoader { [weak self] in
            self?.view?.showErrorDialog(error)
        }
    }
    
    func seeAllTopMarket() {
        router.navigateToMarketListPage([Constants.marketSection: MarketSection.trending])
    }
    
    func seeAllWatchingMarket() {
        router.navigateToMarketListPage([Constants.marketSection: MarketSection.watched])
    }
    
    func seeAllMarket() {
        router.navigateToMarketListPage([Constants.marketSection: MarketSection.all])
    }
    
    func seeMarketDetail(_ selectedMarket: MarketListDataViewModel?) {
        guard let selectedMarket = selectedMarket else { return }
        router.navigateToMarketDetailPage([Constants.marketData: selectedMarket])
    }
}
