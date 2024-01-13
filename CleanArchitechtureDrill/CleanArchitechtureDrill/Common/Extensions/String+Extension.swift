//
//  String+Extension.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 30/12/23.
//

import Foundation

extension String {
    
}

extension Optional where Wrapped == String {
    var orEmpty: String {
        if let value = self {
            return value
        }
        return ""
    }
}
