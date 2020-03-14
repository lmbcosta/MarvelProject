//
//  CharacterDetailViewController.swift
//  MarvelProject
//
//  Created by Luis  Costa on 13/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    // MARK: - Properties
    private let tableView = UITableView(frame: .zero)
    private let viewModel: CharacterDetailViewModelProtocol
    private let dataSource: CharacterDetailDataSource
    
    // MARK: - Initializer
    init(viewModel: CharacterDetailViewModelProtocol) {
        self.viewModel = viewModel
        dataSource = CharacterDetailDataSource(viewModel: viewModel,
                                               tableView: tableView)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Private
    private func setupView() {
        view.backgroundColor = .white
        title = viewModel.title
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = dataSource
        view.addSubview(tableView)
        setupTableviewContraints()
    }
    
    private func setupTableviewContraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate
extension CharacterDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.item == 0 ? Dimensions.ImageCell.rowHeight : Dimensions.DetailCell.rowHEight
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension CharacterDetailViewController {
    struct Dimensions {
        struct ImageCell {
            static let rowHeight: CGFloat = 80
        }
        
        struct DetailCell {
            static let rowHEight: CGFloat = 40
        }
    }
}
