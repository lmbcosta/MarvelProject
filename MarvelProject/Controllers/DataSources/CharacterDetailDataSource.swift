//
//  CharacterDetailDataSource.swift
//  MarvelProject
//
//  Created by Luis  Costa on 13/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import UIKit

class CharacterDetailDataSource: NSObject, UITableViewDataSource {
    // MARK: - Properties
    private let viewModel: CharacterDetailViewModelProtocol
    
    // MARK: - Initializer
    init(viewModel: CharacterDetailViewModelProtocol,
         tableView: UITableView) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO:
        return .init()
    }
    
    // MARK: - Private
    func registerCells(in tableView: UITableView) {
        // TODO:
    }
}

extension CharacterDetailDataSource {
    struct Constants {
        static let numberOfItems = 3
    }
}
