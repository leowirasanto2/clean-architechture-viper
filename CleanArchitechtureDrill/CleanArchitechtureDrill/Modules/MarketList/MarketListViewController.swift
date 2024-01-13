//  
//  MarketListViewController.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 29/12/23.
//
//  Template author: leowirasanto

import Foundation
import UIKit

class MarketListViewController: UIViewController, IMarketListViewController {
    private let presenter: IMarketListPresenter
    private var loader: FullscreenLoaderView?
    private lazy var collectionView: UICollectionView? = { [weak self] in
        return self?.getCollectionView()
    }()
    
    init(presenter: IMarketListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard presenter.viewModel?.data == nil else { return }
        presenter.getMarketData()
    }
    
    func registerCells() {
        collectionView?.register(MarketRowCell.self, forCellWithReuseIdentifier: MarketRowCell.identifier)
    }
    
    func getCollectionView() -> UICollectionView? {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        return collection
    }
    
    func setupView() {
        guard let collectionView = self.collectionView else { return }
        registerCells()
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupNavBar() {
        let customView = getCustomTitleView(title: presenter.pageTitle)
        customView.isUserInteractionEnabled = true
        customView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(back)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customView)
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: Protocol implementation
extension MarketListViewController {
    func startLoader(_ completion: () -> Void?) {
        guard let view = self.navigationController?.view else {
            completion()
            return
        }
        loader = FullscreenLoaderView(frame: view.frame)
        loader?.parentView = view
        loader?.start()
        completion()
    }
    
    func stopLoader(_ completion: () -> Void?) {
        loader?.stop()
        loader = nil
        completion()
    }
    
    func showMarketData() {
        collectionView?.reloadData()
    }
}

extension MarketListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarketRowCell.identifier, for: indexPath) as? MarketRowCell else { return UICollectionViewCell () }
        cell.configure(presenter.selectedData()?[indexPath.row])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (presenter.selectedData()?.count).orZero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width) - 32, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = presenter.viewModel?.getData(indexPath.section, row: indexPath.row)
        presenter.seeMarketDetail(data)
    }
}
