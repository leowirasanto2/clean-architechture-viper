//  
//  HistoryPresenter.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 29/12/23.
//
//  Template author: leowirasanto

import Foundation

class HistoryPresenter: IHistoryPresenter {
    private let interactor: IHistoryInteractor
    private let router: IHistoryRouter
    private let parameters: [String: Any]?
    weak var view: IHistoryViewController?
    
    init(interactor: IHistoryInteractor, router: IHistoryRouter, parameters: [String: Any]?) {
        self.interactor = interactor
        self.router = router
        self.parameters = parameters
    }
    
    func viewDidLoad(view: IHistoryViewController) {
        self.view = view
    }
    //TODO: - add your code here
}
