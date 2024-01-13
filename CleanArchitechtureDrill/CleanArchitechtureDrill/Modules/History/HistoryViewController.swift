//  
//  HistoryViewController.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 29/12/23.
//
//  Template author: leowirasanto

import Foundation
import UIKit

class HistoryViewController: UIViewController, IHistoryViewController {
    private let presenter: IHistoryPresenter
    
    init(presenter: IHistoryPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    // TODO: add your code here
}
