//
//  UIComponent+Extension.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 30/12/23.
//

import Foundation
import UIKit

extension UIEdgeInsets {
    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}
