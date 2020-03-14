//
//  ImageSize.swift
//  MarvelProject
//
//  Created by Luis  Costa on 13/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

enum ImageType {
    case square
    case landscape
}

extension ImageType {
    var description: String {
        switch self {
        case .landscape: return "/landscape_amazing."
        case .square: return "/standard_medium."
        }
    }
}


