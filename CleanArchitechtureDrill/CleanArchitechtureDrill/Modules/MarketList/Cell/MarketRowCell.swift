//
//  MarketRowCell.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 29/12/23.
//

import Foundation
import UIKit

class MarketRowCell: UICollectionViewCell {
    static let identifier = "MarketRowCell"
    
    private lazy var icon: UIImageView = { [weak self] in
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .gray.withAlphaComponent(0.2)
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.image = UIImage(systemName: "building.2.crop.circle")
        $0.tintColor = .gray.withAlphaComponent(0.3)
        return $0
    }(UIImageView())
    
    private lazy var abbrLabel: UILabel = {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private lazy var nameLabel: UILabel = {
        $0.font = .systemFont(ofSize: 10, weight: .regular)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private lazy var priceLabel: UILabel = {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private lazy var nameStack: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.spacing = 16
        return $0
    }(UIStackView())
    
    private lazy var horizontalStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.alignment = .center
        $0.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        $0.isLayoutMarginsRelativeArrangement = true
        $0.spacing = 16
        return $0
    }(UIStackView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .gray.withAlphaComponent(0.1)
        roundCorner(10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ market: MarketListDataViewModel?) {
        nameLabel.text = market?.companyName
        abbrLabel.text = market?.abbreviation
        priceLabel.text = "\((market?.currentPrice).orZero)"
    }
    
    private func setupView() {
        let iconSize = contentView.frame.height - 32
        contentView.addSubview(horizontalStack)
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            icon.heightAnchor.constraint(equalToConstant: iconSize),
            icon.widthAnchor.constraint(equalToConstant: iconSize)
        ])
        
        [abbrLabel, nameLabel].forEach {
            nameStack.addArrangedSubview($0)
        }
        
        [icon, nameStack, priceLabel].forEach {
            horizontalStack.addArrangedSubview($0)
        }
    }
}
