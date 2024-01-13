//
//  MarketListResponse.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 26/12/23.
//

import Foundation

struct MarketListResponse: Decodable {
    let market: [MarketDataResponse]?
    let date: String?
    
    func toViewModel() -> MarketListViewModel {
        return MarketListViewModel(
            date: date,
            data: market?.map { $0.toViewModel() }.sorted(by: { ($0.section?.rawValue).orEmpty > ($1.section?.rawValue).orEmpty })
        )
    }
}

struct MarketDataResponse: Decodable {
    let image: String?
    let companyName: String?
    let abbreviation: String?
    let previousPrice: Int?
    let currentPrice: Int?
    let profitPercent: Double?
    let section: MarketSection?
    
    func toViewModel() -> MarketListDataViewModel {
        return MarketListDataViewModel(
            image: self.image,
            companyName: self.companyName,
            abbreviation: self.abbreviation,
            previousPrice: self.previousPrice.orZero,
            currentPrice: self.currentPrice.orZero,
            profitPercent: self.profitPercent.orZero,
            section: self.section)
    }
}

extension MarketListResponse {
    static let response = """
{
  "market": [
    {
      "image": "https://picsum.photos/200",
      "company_name": "PT Leklek",
      "abbreviation": "LEKL",
      "previous_price": 100,
      "current_price": 150,
      "profit_percent": 10,
      "section": "trending"
    },
    {
      "image": "https://picsum.photos/200",
      "company_name": "PT Laklak",
      "abbreviation": "LAKL",
      "previous_price": 1000,
      "current_price": 900,
      "profit_percent": -5,
      "section": "trending"
    },
    {
      "image": "https://picsum.photos/200",
      "company_name": "PT Bebek",
      "abbreviation": "BEBE",
      "previous_price": 200,
      "current_price": 190,
      "profit_percent": 10,
      "section": "trending"
    },
    {
      "image": "https://picsum.photos/200",
      "company_name": "PT Santai",
      "abbreviation": "SANT",
      "previous_price": 130,
      "current_price": 199,
      "profit_percent": 10,
      "section": "trending"
    },
    {
      "image": "https://picsum.photos/200",
      "company_name": "PT Santai",
      "abbreviation": "SANT",
      "previous_price": 130,
      "current_price": 199,
      "profit_percent": 10,
      "section": "watched"
    },
    {
      "image": "https://picsum.photos/200",
      "company_name": "PT Bebek",
      "abbreviation": "BEBE",
      "previous_price": 200,
      "current_price": 190,
      "profit_percent": 10,
      "section": "watched"
    },
    {
      "image": "https://picsum.photos/200",
      "company_name": "PT Leklek",
      "abbreviation": "LEKL",
      "previous_price": 100,
      "current_price": 150,
      "profit_percent": 10,
      "section": "all"
    },
    {
      "image": "https://picsum.photos/200",
      "company_name": "PT Laklak",
      "abbreviation": "LAKL",
      "previous_price": 1000,
      "current_price": 1110,
      "profit_percent": 10,
      "section": "all"
    },
    {
      "image": "https://picsum.photos/200",
      "company_name": "PT Bebek",
      "abbreviation": "BEBE",
      "previous_price": 200,
      "current_price": 190,
      "profit_percent": 10,
      "section": "all"
    },
    {
      "image": "https://picsum.photos/200",
      "company_name": "PT Santai",
      "abbreviation": "SANT",
      "previous_price": 130,
      "current_price": 199,
      "profit_percent": 10,
      "section": "all"
    },
    {
      "image": "https://picsum.photos/200",
      "company_name": "PT Santai",
      "abbreviation": "SANT",
      "previous_price": 130,
      "current_price": 199,
      "profit_percent": 10,
      "section": "all"
    },
    {
      "image": "https://picsum.photos/200",
      "company_name": "PT Gmn Sih",
      "abbreviation": "GMNS",
      "previous_price": 200,
      "current_price": 400,
      "profit_percent": 10,
      "section": "all"
    },
    {
      "image": "https://picsum.photos/200",
      "company_name": "PT Yaudah Iya",
      "abbreviation": "YAUD",
      "previous_price": 1000,
      "current_price": 5000,
      "profit_percent": 10,
      "section": "all"
    }
  ],
  "date": ""
}

"""
}
