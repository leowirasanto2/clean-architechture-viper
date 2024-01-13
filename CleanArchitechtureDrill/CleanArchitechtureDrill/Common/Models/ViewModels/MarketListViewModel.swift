//
//  MarketListViewModel.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 26/12/23.
//

import Foundation

struct MarketListViewModel{
    var date: String?
    var data: [MarketListDataViewModel]?
    
    func getCurrentSection(_ section: Int) -> MarketSection {
        MarketSection.atIndex(section)
    }
    
    func getNumberOfSection() -> Int {
        return 3
    }
    
    func getNumberOfItemInSection(_ section: Int) -> Int {
        switch getCurrentSection(section) {
        case .trending:
            return 1
        default:
            return (data?.filter { $0.section?.index == section }.count).orZero
        }
    }
    
    func getData(_ section: Int, row: Int) -> MarketListDataViewModel? {
        return data?.filter { $0.section?.index == section }[row]
    }
    
    func getSectionData(_ section: Int) -> [MarketListDataViewModel]? {
        return data?.filter { $0.section?.index == section }
    }
}

struct MarketListDataViewModel {
    var image: String?
    var companyName: String?
    var abbreviation: String?
    var previousPrice: Int
    var currentPrice: Int
    var profitPercent: Double
    var section: MarketSection?
}
