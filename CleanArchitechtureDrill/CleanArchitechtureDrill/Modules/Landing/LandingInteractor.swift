//
//  LandingInteractor.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 29/12/23.
//
//  Template author: leowirasanto

import Foundation

class LandingInteractor: ILandingInteractor {
    private let service: LandingService
    weak var presenter: ILandingPresenter?
    
    init(service: LandingService) {
        self.service = service
    }
    
    func fetchMarketData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let data = MarketListResponse.response.data(using: .utf8)
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(MarketListResponse.self, from: data!)
                self.presenter?.successFetchMarketData(response.toViewModel())
            } catch {
                self.presenter?.failedFetchMargetData(.generalError)
            }
        }
    }
}
