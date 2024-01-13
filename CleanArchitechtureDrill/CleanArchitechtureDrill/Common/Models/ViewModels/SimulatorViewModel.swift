//
//  SimulatorViewModel.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 30/12/23.
//

import Foundation

enum SimulatorSection: Int {
    case header = 0
    case input = 1
    case result = 2
}


struct SimulatorViewModel {
    var itemSection: [SimulatorSectionViewModel]
    
    func getInputContent() -> SimulatorSectionViewModel? {
        return itemSection.first(where: { $0.section == .input} )
    }
    
    func getMarketContent() -> MarketListDataViewModel? {
        return itemSection.first(where: { $0.section == .header} )?.content.first?.marketData
    }
    
    static func createFormViewModel(_ marketData: MarketListDataViewModel?) -> SimulatorViewModel {
        var sections = [
            SimulatorSectionViewModel(
                section: .header,
                content: [SimulatorContentViewModel(marketData: marketData)]),
            SimulatorSectionViewModel(
                section: .input,
                content: [
                    SimulatorContentViewModel(inputLabel: "Invest in IDR", inputPlaceholder: "ex. 15.000.000"),
                    SimulatorContentViewModel(inputLabel: "Sell at", inputPlaceholder: "ex. 1000")
                ])
        ]
        
        return SimulatorViewModel(itemSection: sections)
    }
    
    func convertToResult() -> SimulatorViewModel {
        var sections = [
            SimulatorSectionViewModel(
                section: .header,
                content: [SimulatorContentViewModel(marketData: getMarketContent())])
        ]
        
        var resultContent = getInputContent()?.content.compactMap {
            SimulatorContentViewModel(infoLabel: $0.inputLabel, infoValue: $0.inputValue)
        }
        
        resultContent?.append(contentsOf: [
            SimulatorContentViewModel(infoLabel: "P&L", infoValue: "-"),
            SimulatorContentViewModel(infoLabel: "Capital Gain", infoValue: "-")
        ])
        
        sections.append(SimulatorSectionViewModel(
            section: .result,
            content: resultContent ?? [])
        )
        
        return SimulatorViewModel(itemSection: sections)
    }
}

struct SimulatorSectionViewModel {
    var section: SimulatorSection
    var content: [SimulatorContentViewModel]
}

struct SimulatorContentViewModel {
    var marketData: MarketListDataViewModel?
    var inputLabel: String?
    var inputPlaceholder: String?
    var infoLabel: String?
    var infoValue: String?
    var inputValue: String?
    
    mutating func setInputValue(_ value: String?) {
        self.inputValue = value
    }
}
