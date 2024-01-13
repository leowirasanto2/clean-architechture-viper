//
//  FullscreenLoaderView.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 26/12/23.
//

import Foundation
import UIKit

final class FullscreenLoaderView: UIView {
    private let indicatorTintColor: UIColor
    private lazy var indicator: UIActivityIndicatorView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.hidesWhenStopped = true
        $0.style = .large
        $0.tintColor = .brown
        return $0
    }(UIActivityIndicatorView())
    
    weak var parentView: UIView?
    
    init(frame: CGRect, indicatorTintColor: UIColor = .brown) {
        self.indicatorTintColor = indicatorTintColor
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .black.withAlphaComponent(0.4)
        addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        indicator.stopAnimating()
    }
}

extension FullscreenLoaderView {
    func start() {
        if let parentView = self.parentView {
            parentView.addSubview(self)
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: parentView.topAnchor),
                bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
                leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
                trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
            ])
            layoutSubviews()
            indicator.startAnimating()
        }
    }
    
    func stop() {
        removeFromSuperview()
    }
}
