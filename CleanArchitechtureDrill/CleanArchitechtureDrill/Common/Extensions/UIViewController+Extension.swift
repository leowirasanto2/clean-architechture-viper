//
//  UIViewController+Extension.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 30/12/23.
//

import Foundation
import UIKit

extension UIViewController {
    func getCustomTitleView(title: String?, tintColor: UIColor = .black) -> UIView {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel.text = title
        let backButton = UIImageView()
        backButton.image = UIImage(systemName: "arrow.backward")
        backButton.tintColor = tintColor
        titleLabel.textColor = tintColor
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        [backButton, titleLabel].forEach { stack.addArrangedSubview($0) }
        return stack
    }
}

