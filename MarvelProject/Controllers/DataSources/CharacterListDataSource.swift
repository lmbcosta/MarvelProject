//
//  CharacterListDataSource.swift
//  MarvelProject
//
//  Created by Luis  Costa on 13/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import UIKit

protocol CharacterListDataSourceProtocol {
    func updateItems(_ newItems: [MarvelCharacter])
    func resetItems()
    func viewModelForItem(at index: Int) -> CharacterDetailViewModelProtocol
    func isLoadingCell(_ cell: UITableViewCell) -> Bool
}

class CharacterListDataSource: NSObject, UITableViewDataSource {
    // MARK: - Properites
    var updateHandler: (() -> Void)?
    
    private let viewModel: CharacterListReloadable
    private var data: [MarvelCharacter] = []
    
    // MARK: - Initializer
    init(viewModel: CharacterListReloadable,
         tableView: UITableView) {
        self.viewModel = viewModel
        super.init()
        registerCells(on: tableView)
    }
    
    // MARK: - Private
    private func registerCells(on tableView: UITableView) {
        tableView.register(CharacterListCell.self,
                           forCellReuseIdentifier: CharacterListCell.reuseIdentifier)
        tableView.register(LoadingCell.self,
                           forCellReuseIdentifier: LoadingCell.reuseIdentifier)
    }
    
    private func buildListCell(for tableView: UITableView, at indexPath: IndexPath) -> CharacterListCell {
        let item = data[indexPath.item]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterListCell.reuseIdentifier, for: indexPath) as? CharacterListCell else {
            fatalError("👻 Unable to dequeue cell with identifier: \(CharacterListCell.reuseIdentifier)")
        }
        cell.setupContent(item)
        
        return cell
    }
    
    private func buildLoadingCell(for tableView: UITableView, at indexPath: IndexPath) -> LoadingCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.reuseIdentifier, for: indexPath) as? LoadingCell else {
            fatalError("👻 Unable to dequeue cell with identifier: \(LoadingCell.reuseIdentifier)")
        }
        
        cell.startAnimating()
        return cell
    }
}

// MARK: UITableViewDelegate
extension CharacterListDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfItems = data.count
        return viewModel.hasMore ? numberOfItems + 1 : numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let isLoadingCell = indexPath.item == data.count
        return isLoadingCell ?
        buildLoadingCell(for: tableView, at: indexPath) :
        buildListCell(for: tableView, at: indexPath)
    }
}

// MARK: - CharacterListDataSourceProtocol
extension CharacterListDataSource: CharacterListDataSourceProtocol {
    func updateItems(_ newItems: [MarvelCharacter]) {
        guard !newItems.isEmpty else { return }
        data.append(contentsOf: newItems)
        updateHandler?()
    }
    
    func resetItems() {
        data = []
        updateHandler?()
    }
    
    func viewModelForItem(at index: Int) -> CharacterDetailViewModelProtocol {
        let item = data[index]
        return CharacterDetailViewModel(item: item)
    }
    
    func isLoadingCell(_ cell: UITableViewCell) -> Bool {
        return cell is LoadingCell
    }
}
