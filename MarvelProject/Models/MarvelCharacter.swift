//
//  MarvelCharacter.swift
//  MarvelProject
//
//  Created by Luis  Costa on 13/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import Foundation

struct CharacterDataWrapper: Decodable {
    let data: CharacterDataContainer
    let code: Int?
    let status: String?
}

struct CharacterDataContainer: Decodable {
    let offset: Int?
    let total: Int?
    let results: [MarvelCharacter]
}

struct MarvelCharacter: Decodable {
    let id: Int?
    let name: String?
    let description: String?
    let thumbnail: Image?
}

extension MarvelCharacter: CharacterListItemProtocol {
    var text: String {
        return name.text(placeholder: "Without Name🙁")
    }
    
    func url(for imageType: ImageType) -> URL? {
        guard
            let image = thumbnail,
            let ext = image.extension,
            let path = image.path else { return nil }
        
        let urlString = String(format: "%@%@%@", path, imageType.description, ext)
        return URL(string: urlString)
    }
}

struct Image: Decodable {
    let path: String?
    let `extension`: String?
}
