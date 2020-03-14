//
//  OptionaStringExtensions.swift
//  MarvelProject
//
//  Created by Luis  Costa on 14/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

extension Optional where Wrapped == String {
    func text(placeholder: String) -> String {
        guard let text = self,
            !text.isEmpty else { return placeholder }
        return text
    }
}
