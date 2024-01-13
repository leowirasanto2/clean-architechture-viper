//
//  LandingService.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 31/12/23.
//

import Foundation

protocol ILandingService: AnyObject {
    func fetchMarketData(result: @escaping (Result<MarketListResponse, CustomError>) -> Void)
}

final class LandingService: ILandingService {
    private let service: APIService
    
    init(service: APIService) {
        self.service = service
    }
    
    func fetchMarketData(result: @escaping (Result<MarketListResponse, CustomError>) -> Void) {
        service.fetch(APIRequest(endPoint: "", parameters: [:]), result: result)
    }
}
