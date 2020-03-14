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
    var imageItem: ImageItemProtocol { get }
    
    func detailItem(for type: DetailType) -> DetailItemProtocol
}

struct CharacterDetailViewModel: CharacterDetailViewModelProtocol {
    private struct DetailItem: DetailItemProtocol {
        let title: String
        let description: String
    }
    
    // MARK:  - Properties
    private(set) var item: MarvelCharacter
    
    var title: String { item.name ?? "" }
    
    var imageItem: ImageItemProtocol { item }
    
    // MARK: - Initializer
    init(item: MarvelCharacter) {
        self.item = item
    }
    
    // MARK: - Internal
    func detailItem(for type: DetailType) -> DetailItemProtocol {
        switch type {
        case .id:
            var description = "Without Id😕"
            if let id = item.id {
                description = String(format: "%d", id)
            }
            return DetailItem(title: Strings.Id.title, description: description)
            
        case .description:
            return DetailItem(title: Strings.Description.title, description: item.description.text(placeholder: "Without Description😕"))
        }
    }
}

private extension CharacterDetailViewModel {
    struct Strings {
        struct Id {
            static let title = "ID:"
        }
        
        struct Description {
            static let title = "Description: "
        }
    }
}

private extension Optional where Wrapped == String {
    func text(placeholder: String) -> String {
        guard let text = self,
            !text.isEmpty else { return placeholder }
        return text
    }
}
