//
//  CommonCollectionViewCellHeader.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 29/12/23.
//

import Foundation
import UIKit

class CommonCollectionViewCellHeader: UICollectionReusableView {
    static let identifier = "CommonCollectionViewCellHeader"
    
    private lazy var titleLabel: UILabel = {
        $0.font = .systemFont(ofSize: 15, weight: .bold)
        $0.textColor = .black
        $0.text = "adfas"
        return $0
    }(UILabel())
    
    private lazy var seeAllLabelButton: UILabel = { [weak self] in
        $0.font = .systemFont(ofSize: 15, weight: .bold)
        $0.isUserInteractionEnabled = true
        $0.textColor = .black
        $0.text = "See All"
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self?.seeAllTap)))
        return $0
    }(UILabel())
    
    private lazy var stack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.spacing = 16
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        $0.isLayoutMarginsRelativeArrangement = true
        return $0
    }(UIStackView())
    
    var seeAllTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        [titleLabel, seeAllLabelButton].forEach { stack.addArrangedSubview($0) }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String?) {
        titleLabel.text = title
    }
    
    @objc func seeAllTap() {
        seeAllTapped?()
    }
}
