//  
//  TabBarPresenter.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 29/12/23.
//
//  Template author: leowirasanto

import Foundation

class TabBarPresenter: ITabBarPresenter {
    private let interactor: ITabBarInteractor
    private let router: ITabBarRouter
    private let parameters: [String: Any]?
    weak var view: ITabBarViewController?
    var viewModel: TabbarViewModel?
    
    init(interactor: ITabBarInteractor, router: ITabBarRouter, parameters: [String: Any]?) {
        self.interactor = interactor
        self.router = router
        self.parameters = parameters
        self.viewModel = TabbarViewModel(page: .landing)
    }
    
    func viewDidLoad(view: ITabBarViewController) {
        self.view = view
    }
    
    func getParameters() -> [String: Any]? {
        return parameters
    }
    //TODO: - add your code here
}
