//
//  ViewState.swift
//  MarvelProject
//
//  Created by Luis  Costa on 13/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

enum ViewState {
    case data(items: [MarvelCharacter])
    case error(title: String, message: String)
}
