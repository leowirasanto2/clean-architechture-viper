//  
//  MarketListInteractor.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 29/12/23.
//
//  Template author: leowirasanto

import Foundation

class MarketListInteractor: IMarketListInteractor {
    weak var presenter: IMarketListPresenter?
    
    init() {
    }
    
    func fetchMarketData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
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
