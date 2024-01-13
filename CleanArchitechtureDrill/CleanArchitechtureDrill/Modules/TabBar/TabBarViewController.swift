//
//  TabBarViewController.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 29/12/23.
//
//  Template author: leowirasanto

import Foundation
import UIKit

class TabBarViewController: UITabBarController, ITabBarViewController {
    private let presenter: ITabBarPresenter
    
    private lazy var landingPage: LandingViewController? = { [weak self] in
        let vc = LandingModule().getLandingPage(parameters: self?.presenter.getParameters()) as? LandingViewController
        vc?.tabBarItem = UITabBarItem(.landing)
        return vc
    }()
    
    private lazy var historyPage: HistoryViewController? = { [weak self] in
        let vc = HistoryModule().getHistoryPage(parameters: self?.presenter.getParameters()) as? HistoryViewController
        vc?.tabBarItem = UITabBarItem(.history)
        return vc
    }()
    
    private lazy var portfolioPage: PortfolioViewController? = { [weak self] in
        let vc = PortfolioModule().getPortfolioPage(parameters: self?.presenter.getParameters()) as? PortfolioViewController
        vc?.tabBarItem = UITabBarItem(.portfolio)
        return vc
    }()
    
    private lazy var customTabBarView: UIView? = { [weak self] in
        guard let frame = self?.tabBar.frame else { return nil }
        return UIView(frame: frame)
    }()
    
    init(presenter: ITabBarPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
        setupTabControllers()
        setupTabBarUI()
        addCustomTabBarView()
        title = presenter.viewModel?.page.title
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupCustomTabBarFrame()
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        presenter.viewModel?.page = TabBarPage(rawValue: item.tag) ?? .landing
        title = presenter.viewModel?.page.title
    }
}

private extension TabBarViewController {
    func setupTabControllers() {
        guard (viewControllers?.count).orZero <= 0 else { return }
        viewControllers = [landingPage, historyPage, portfolioPage].compactMap { $0 }
    }
    
    func setupCustomTabBarFrame() {
        let height = view.safeAreaInsets.bottom + 64
        
        var tabFrame = tabBar.frame
        tabFrame.size.height = height
        tabFrame.origin.y = view.frame.size.height - height
        
        tabBar.frame = tabFrame
        tabBar.setNeedsLayout()
        tabBar.layoutIfNeeded()
        customTabBarView?.frame = tabBar.frame
    }
    
    func setupTabBarUI() {
        tabBar.layer.cornerRadius = 30
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.tintColor = .black
        tabBar.barTintColor = .brown
        removeTabBarLine()
    }
    
    func removeTabBarLine() {
        if #available(iOS 13.0, *) {
            let appearance = self.tabBar.standardAppearance
            appearance.shadowImage = nil
            appearance.shadowColor = .clear
            appearance.backgroundColor = .clear
            appearance.backgroundEffect = .none
            tabBar.standardAppearance = appearance
        } else {
            tabBar.shadowImage = UIImage()
            tabBar.backgroundImage = UIImage()
        }
    }
    
    func addCustomTabBarView() {
        guard let customTabBarView = customTabBarView else { return }
        customTabBarView.backgroundColor = .white
        customTabBarView.layer.cornerRadius = 30
        customTabBarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        customTabBarView.layer.masksToBounds = false
        customTabBarView.layer.shadowColor = UIColor.gray.cgColor
        customTabBarView.layer.shadowOffset = CGSize(width: -4, height: -6)
        customTabBarView.layer.shadowOpacity = 0.5
        customTabBarView.layer.shadowRadius = 20
        view.addSubview(customTabBarView)
        view.bringSubviewToFront(tabBar)
    }
}
