//  
//  LandingViewController.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 29/12/23.
//
//  Template author: leowirasanto

import Foundation
import UIKit

class LandingViewController: UIViewController, ILandingViewController {
    private let presenter: ILandingPresenter
    private var loader: FullscreenLoaderView?
    
    private lazy var collectionView: UICollectionView? = { [weak self] in
        return self?.getCollectionView()
    }()
    
    init(presenter: ILandingPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if presenter.viewModel?.data == nil {
            presenter.getLandingPageData()
        }
    }
}

private extension LandingViewController {
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
    
    func registerCells() {
        collectionView?.register(MarketRowCell.self, forCellWithReuseIdentifier: MarketRowCell.identifier)
        collectionView?.register(MarketGridCell.self, forCellWithReuseIdentifier: MarketGridCell.identifier)
        collectionView?.register(MarketCarouselCell.self, forCellWithReuseIdentifier: MarketCarouselCell.identifier)
        collectionView?.register(CommonCollectionViewCellHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CommonCollectionViewCellHeader.identifier)
    }
    
    func getCollectionView() -> UICollectionView? {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        return collection
    }
}

// MARK: Protocol Implementation
extension LandingViewController {
    
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
    
    func showLandingPageData() {
        collectionView?.reloadData()
    }
    
    func showErrorDialog(_ error: CustomError) {
        //
    }
}

extension LandingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = presenter.viewModel?.getData(indexPath.section, row: indexPath.row)
        switch data?.section ?? .all {
        case .trending:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarketCarouselCell.identifier, for: indexPath) as? MarketCarouselCell else { return UICollectionViewCell() }
            cell.configure(presenter.viewModel?.getSectionData(indexPath.section))
            cell.didSelectItem = { [weak self] data in
                self?.presenter.seeMarketDetail(data)
            }
            return cell
        case .watched:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarketRowCell.identifier, for: indexPath) as? MarketRowCell else { return UICollectionViewCell () }
            cell.configure(data)
            return cell
        case .all:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarketRowCell.identifier, for: indexPath) as? MarketRowCell else { return UICollectionViewCell () }
            cell.configure(data)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CommonCollectionViewCellHeader.identifier, for: indexPath) as? CommonCollectionViewCellHeader else { fatalError("not found") }
        let data = presenter.viewModel?.getData(indexPath.section, row: indexPath.row)
        view.configure(title: data?.section?.title)
        view.seeAllTapped = { [weak self] in
            switch data?.section ?? .all {
            case .trending:
                self?.presenter.seeAllTopMarket()
            case .watched:
                self?.presenter.seeAllWatchingMarket()
            case .all:
                self?.presenter.seeAllMarket()
            }
        }
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = presenter.viewModel?.getData(indexPath.section, row: indexPath.row)
        presenter.seeMarketDetail(data)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (presenter.viewModel?.getNumberOfSection()).orZero
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (presenter.viewModel?.getNumberOfItemInSection(section)).orZero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let data = presenter.viewModel?.getData(indexPath.section, row: indexPath.row)
        switch data?.section ?? .all {
        case .trending:
            return CGSize(width: view.frame.width, height: 100)
        case .watched, .all:
            return CGSize(width: (view.frame.width) - 32, height: 80)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let section = presenter.viewModel?.getCurrentSection(section)
        switch section ?? .all {
        case .trending:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case .watched:
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        case .all:
            return UIEdgeInsets(top: 0, left: 16, bottom: 32, right: 16)
        }
    }
}
