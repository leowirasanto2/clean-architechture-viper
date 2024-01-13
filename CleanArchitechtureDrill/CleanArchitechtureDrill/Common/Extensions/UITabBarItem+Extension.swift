//
//  UITabBarItem+Extension.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 29/12/23.
//

import Foundation
import UIKit

extension UITabBarItem {
    convenience init(_ page: TabBarPage) {
        self.init(title: page.title, image: page.icon, tag: page.rawValue)
    }
}
