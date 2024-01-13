//
//  InfoCell.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 30/12/23.
//

import Foundation
import UIKit

class InfoCell: UICollectionViewCell {
    static let identifier = "InfoCell"
    
    private lazy var labelLabel: UILabel = {
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private lazy var valueLabel: UILabel = {
        $0.textAlignment = .right
        return $0
    }(UILabel())
    
    private lazy var stack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alignment = .center
        $0.spacing = 16
        $0.axis = .horizontal
        return $0
    }(UIStackView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        
        [labelLabel, valueLabel].forEach { stack.addArrangedSubview($0) }
    }
    
    func configure(label: String?, value: String?) {
        labelLabel.text = label
        valueLabel.text = value
    }
}
