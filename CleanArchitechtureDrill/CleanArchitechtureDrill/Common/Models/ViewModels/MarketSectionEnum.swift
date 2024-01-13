//
//  MarketSectionEnum.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 30/12/23.
//

import Foundation

enum MarketSection: String, Decodable {
    case trending
    case watched
    case all
    
    static func atIndex(_ index: Int) -> MarketSection {
        switch index {
        case 0:
            return .trending
        case 1:
            return .watched
        default:
            return .all
        }
    }
    
    var index: Int {
        switch self {
        case .trending:
            return 0
        case .watched:
            return 1
        case .all:
            return 2
        }
    }
    
    var title: String {
        switch self {
        case .trending:
            return "Trending Market"
        case .watched:
            return "Watch List"
        case .all:
            return "All Market"
        }
    }
}
