//
//  CharacterListViewController.swift
//  MarvelProject
//
//  Created by Luis  Costa on 13/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import UIKit

class CharacterListViewController: UIViewController {
    // MARK: - Properties
    private let tableView = UITableView(frame: .zero)
    private let emptyStateView = EmptyStateView()
    private let viewModel: CharacterListPaginable
    private let dataSource: CharacterListDataSource
    
    private weak var navigationDelegate: Navigatable?
    
    private lazy var fetchHandler: () -> Void = { [weak self] in
        self?.viewModel.requestCharactersNextPage(then: { [weak self] in
            self?.handleViewState($0)
        })
    }
    
    // MARK: - Initializer
    init(viewModel: CharacterListViewModelProtocol,
         navigationDelegate: Navigatable?) {
        self.viewModel = viewModel
        self.dataSource = CharacterListDataSource(viewModel: viewModel,
                                                  tableView: tableView)
        self.navigationDelegate = navigationDelegate
        super.init(nibName: nil, bundle: nil)
        dataSource.updateHandler = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchHandler()
    }
    
    // MARK: Private
    private func setupView() {
        title = Strings.title
        setupTableview()
        setupEmptyStateView()
    }
    
    private func setupTableview() {
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.rowHeight = Dimensions.TableView.rowHeight
        tableView.separatorStyle = .singleLine
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
    
    private func setupEmptyStateView() {
        emptyStateView.isHidden = true
        view.addSubview(emptyStateView)
        view.bringSubviewToFront(emptyStateView)
        setupEmptyStateViewConstraints()
    }
    
    private func setupEmptyStateViewConstraints() {
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyStateView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func handleViewState(_ viewState: ViewState) {
        switch viewState {
        case .data(items: let items):
            emptyStateView.isHidden = true
            dataSource.updateItems(items)
        
        case .error(title: let title, message: let message):
            emptyStateView.configure(title: title,
                                     message: message,
                                     buttonHandle: fetchHandler)
            emptyStateView.isHidden = false
        }
    }
}

// MARK: UITableViewDelegate
extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemViewModel = dataSource.viewModelForItem(at: indexPath.row)
        navigationDelegate?.navigateToCharacterDetail(from: self,
                                                      using: itemViewModel)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if dataSource.isLoadingCell(cell), indexPath.item != 0 {
            viewModel.requestCharactersNextPage { [weak self] in
                self?.handleViewState($0)
            }
        }
    }
}

extension CharacterListViewController {
    struct Strings {
        static let title = "Marvel Characters"
    }
    struct Dimensions {
        struct TableView {
            static let rowHeight: CGFloat = 60
        }
    }
}
