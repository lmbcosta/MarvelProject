//
//  CharacterDetailViewModel.swift
//  MarvelProject
//
//  Created by Luis  Costa on 13/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import UIKit

protocol CharacterDetailViewModelProtocol {
    var title: String { get }
    var imageURL: URL? { get }
    var id: String { get }
    var description: String { get }
}

struct CharacterDetailViewModel: CharacterDetailViewModelProtocol {
    // MARK:  - Properties
    private(set) var item: MarvelCharacter
    
    var title: String { item.name ?? "" }
    
    var imageURL: URL? { item.url(for: .landscape) }
    
    var id: String {
        guard let id = item.id else { return "Without Id" }
        return String(format: "%d", id)
    }
    
    var description: String { item.description ?? "Wothout description" }
    
    // MARK: - Initializer
    init(item: MarvelCharacter) {
        self.item = item
    }
}
