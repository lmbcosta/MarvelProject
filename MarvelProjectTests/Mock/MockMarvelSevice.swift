//
//  MockMarvelSevice.swift
//  MarvelProjectTests
//
//  Created by Luis  Costa on 13/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import Foundation
@testable import MarvelProject

struct MockMarvelService: MarvelServiceProtocol {
    private let response: Result<CharacterDataWrapper, Error>
    private(set) var requestLimit: Int
    
    var requestPerPage: Int {
        get { requestLimit }
        set { requestLimit = newValue }
    }
    
    init(response: Result<CharacterDataWrapper, Error>,
         requestLimit: Int) {
        self.response = response
        self.requestLimit = requestLimit
    }
    
    func fetchCharacters(for offset: Int, then handler: @escaping (Result<CharacterDataWrapper, Error>) -> Void) {
        handler(response)
    }
}
