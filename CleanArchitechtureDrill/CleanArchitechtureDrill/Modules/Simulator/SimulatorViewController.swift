//  
//  SimulatorViewController.swift
//  CleanArchitechtureDrill
//
//  Created by Leo Laia on 30/12/23.
//
//  Template author: leowirasanto

import Foundation
import UIKit
import SwiftUI

class SimulatorViewController: UIViewController, ISimulatorViewController {
    private let presenter: ISimulatorPresenter
    
    private lazy var collectionView: UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: self?.view.frame ?? .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    private lazy var simulateButton: UIButton = { [weak self] in
        let btn = UIButton(frame: self?.view.frame ?? .zero)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Simulate", for: .normal)
        btn.addTarget(self, action: #selector(self?.simulateTapped), for: .touchUpInside)
        btn.backgroundColor = .brown
        btn.roundCorner(12)
        return btn
    }()
    
    init(presenter: ISimulatorPresenter) {
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
        registerCells()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.getForm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    func showForm() {
        collectionView.reloadData()
    }
    
    func showResult() {
        collectionView.reloadData()
        simulateButton.isHidden = true
    }
}

private extension SimulatorViewController {
    func setupNavBar() {
        let customNavBar = getCustomTitleView(title: presenter.pageTitle)
        customNavBar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(back)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customNavBar)
    }
    
    func setupView() {
        [collectionView, simulateButton].forEach { view.addSubview($0) }
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            simulateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            simulateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            simulateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            simulateButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func registerCells() {
        collectionView.register(MarketRowCell.self, forCellWithReuseIdentifier: MarketRowCell.identifier)
        collectionView.register(InputCell.self, forCellWithReuseIdentifier: InputCell.identifier)
        collectionView.register(InfoCell.self, forCellWithReuseIdentifier: InfoCell.identifier)
    }
    
    @objc func simulateTapped() {
        presenter.calculate(investValue: 10, sellValue: 100)
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    
    func printText(_ text: String?) {
        print(text.orEmpty)
    }
}

extension SimulatorViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (presenter.viewModel?.itemSection.count).orZero
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (presenter.viewModel?.itemSection[section].content.count).orZero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionData = presenter.viewModel?.itemSection[indexPath.section]
        
        switch sectionData?.section ?? .header {
        case .header:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarketRowCell.identifier, for: indexPath) as? MarketRowCell else { return UICollectionViewCell() }
            cell.configure(sectionData?.content[indexPath.row].marketData)
            return cell
        case .input:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InputCell.identifier, for: indexPath) as? InputCell else { return UICollectionViewCell() }
            cell.configure(sectionData?.content[indexPath.row])
            cell.textDidChangeListener = { [weak self] text in
                self?.presenter.viewModel?.itemSection[indexPath.section].content[indexPath.row].setInputValue(text)
            }
            return cell
        case .result:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCell.identifier, for: indexPath) as? InfoCell else { return UICollectionViewCell() }
            let info = sectionData?.content[indexPath.row]
            cell.configure(label: info?.infoLabel, value: info?.infoValue)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionData = presenter.viewModel?.itemSection[indexPath.section]
        switch sectionData?.section ?? .header {
        case .header:
            return CGSize(width: (view.frame.width) - 32, height: 80)
        case .input, .result:
            return CGSize(width: (view.frame.width) - 32, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(horizontal: 16, vertical: 8)
    }
}

extension SimulatorViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let text = textField.text,
               let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(
                    in: textRange,
                    with: string)
                printText(updatedText)
            }
            return true
        }
}

// MARK: - Preview
struct SimulatorPagePreviews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            // Return whatever controller you want to preview
            return SimulatorModule().getPreview()
        }
    }
}
