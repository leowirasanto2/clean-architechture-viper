//
//  MarketGridCell.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 29/12/23.
//

import Foundation
import UIKit
import SwiftUI

class MarketGridCell: UICollectionViewCell {
    static let identifier = "MarketGridCell"
    
    private lazy var abbrLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return $0
    }(UILabel())
    
    private lazy var priceLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return $0
    }(UILabel())
    
    private lazy var percentLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        return $0
    }(UILabel())
    
    private lazy var container: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        contentView.roundCorner(10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [abbrLabel, priceLabel, percentLabel].forEach { container.addSubview($0) }
        contentView.addSubview(container)
        NSLayoutConstraint.activate([
            // Container
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            // Abbr Label
            abbrLabel.topAnchor.constraint(equalTo: container.topAnchor),
            abbrLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            abbrLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            
            // Price Label
            priceLabel.topAnchor.constraint(greaterThanOrEqualTo: abbrLabel.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            
            // Percent Label
            percentLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            percentLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            percentLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            percentLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
        contentView.backgroundColor = .gray.withAlphaComponent(0.1)
    }
    
    private func setPercentLabelColor(_ value: Double) {
        percentLabel.textColor = value >= 0 ? .green : .red
    }
    
    func configure(_ data: MarketListDataViewModel?) {
        abbrLabel.text = data?.abbreviation
        priceLabel.text = "\((data?.currentPrice).orZero)"
        percentLabel.text = "\((data?.profitPercent).orZero)%"
        setPercentLabelColor((data?.profitPercent).orZero)
    }
}
