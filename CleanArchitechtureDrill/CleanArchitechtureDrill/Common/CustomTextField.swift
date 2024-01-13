//
//  CustomTextField.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 25/12/23.
//

import Foundation
import UIKit

typealias CustomTextFieldPadding = (horizontal: CGFloat, vertical: CGFloat)

final class CustomTextField: UITextField {
    private let borderColor: UIColor
    private let customPadding: CustomTextFieldPadding
    
    init(frame: CGRect = .zero, _ borderColor: UIColor = .black, _ customPadding: CustomTextFieldPadding = (16, 0)) {
        self.borderColor = borderColor
        self.customPadding = customPadding
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: customPadding.vertical, left: customPadding.horizontal, bottom: customPadding.vertical, right: customPadding.horizontal))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: customPadding.vertical, left: customPadding.horizontal, bottom: customPadding.vertical, right: customPadding.horizontal))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: customPadding.vertical, left: customPadding.horizontal, bottom: customPadding.vertical, right: customPadding.horizontal))
    }
    
    func setupView() {
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
    }
}
