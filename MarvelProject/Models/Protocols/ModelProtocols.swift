//
//  ModelProtocols.swift
//  MarvelProject
//
//  Created by Luis  Costa on 14/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import Foundation

protocol ImageItemProtocol {
    func url(for imageType: ImageType) -> URL?
}

protocol CharacterListItemProtocol: ImageItemProtocol {
    var text: String { get }
}

protocol DetailItemProtocol {
    var title: String { get }
    var description: String { get }
}
