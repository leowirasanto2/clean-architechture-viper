//
//  InputCell.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 30/12/23.
//

import Foundation
import UIKit

class InputCell: UICollectionViewCell {
    static let identifier = "InputCell"
    private lazy var inputField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    var textDidChangeListener: ((String?) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        
        inputField.delegate = self
        addSubview(inputField)
        NSLayoutConstraint.activate([
            inputField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            inputField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            inputField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            inputField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    func configure(_ config: SimulatorContentViewModel?) {
        inputField.placeholder = config?.inputPlaceholder
        inputField.accessibilityLabel = config?.inputLabel
    }
}

extension InputCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(
                in: textRange,
                with: string)
            textDidChangeListener?(updatedText)
        }
        return true
    }

}
