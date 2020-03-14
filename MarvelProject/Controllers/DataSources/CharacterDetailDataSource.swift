//
//  CharacterDetailDataSource.swift
//  MarvelProject
//
//  Created by Luis  Costa on 13/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import UIKit

final class CharacterDetailDataSource: NSObject, UITableViewDataSource {
    // MARK: - Properties
    private let viewModel: CharacterDetailViewModelProtocol
    
    // MARK: - Initializer
    init(viewModel: CharacterDetailViewModelProtocol,
         tableView: UITableView) {
        self.viewModel = viewModel
        super.init()
        registerCells(in: tableView)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return indexPath.item == Constants.Item.image ?
            buildImageCell(for: tableView, at: indexPath) :
            buildDetailCell(for: tableView, at: indexPath)
    }
    
    // MARK: - Private
    private func registerCells(in tableView: UITableView) {
        tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.reuseIdentifier)
        tableView.register(DetailCell.self, forCellReuseIdentifier: DetailCell.reuseIdentifier)
    }
    
    private func buildImageCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.reuseIdentifier, for: indexPath) as! ImageCell
        cell.setupContent(viewModel.imageItem)
        return cell
    }
    
    private func buildDetailCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.reuseIdentifier, for: indexPath) as! DetailCell
        
        let item: DetailItemProtocol = {
            switch indexPath.item {
            case Constants.Item.id: return viewModel.detailItem(for: .id)
            default: return viewModel.detailItem(for: .description)
            }
        }()
        
        cell.setupContent(item)
        return cell
    }
}

extension CharacterDetailDataSource {
    struct Constants {
        static let numberOfItems = 3
        
        struct Item {
            static let image = 0
            static let id = 1
            static let description = 2
        }
    }
}
