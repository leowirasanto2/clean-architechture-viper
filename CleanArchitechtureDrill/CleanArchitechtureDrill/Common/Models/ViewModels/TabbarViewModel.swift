//
//  TabbarViewModel.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 28/12/23.
//

import Foundation
import UIKit

struct TabbarViewModel {
    var page: TabBarPage
}

enum TabBarPage: Int {
    case landing = 0
    case history = 1
    case portfolio = 2
    
    var title: String {
        switch self {
        case .landing:
            "Market"
        case .history:
            "History"
        case .portfolio:
            "Portfolio"
        }
    }
    
    var icon: UIImage {
        switch self {
        case .landing:
            return UIImage(systemName: "chart.xyaxis.line") ?? UIImage()
        case .history:
            return UIImage(systemName: "clock") ?? UIImage()
        case .portfolio:
            return UIImage(systemName: "chart.pie") ?? UIImage()
        }
    }
}
