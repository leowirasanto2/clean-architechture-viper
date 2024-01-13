//
//  Number+Extension.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 30/12/23.
//

import Foundation

extension Optional where Wrapped == Int {
    var orZero: Int {
        if let value = self {
            return value
        }
        return 0
    }
}

extension Optional where Wrapped == CGFloat {
    var orZero: CGFloat {
        if let value = self {
            return value
        }
        return 0
    }
}

extension Optional where Wrapped == Double {
    var orZero: Double {
        if let value = self {
            return value
        }
        return 0
    }
}
