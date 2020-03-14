//
//  MockCharacterListViewModel.swift
//  MarvelProjectTests
//
//  Created by Luis  Costa on 13/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

@testable import MarvelProject

struct MockCharacterListViewModel: CharacterListViewModelProtocol {
    private let hasMoreItems: Bool
    private let viewState: ViewState
    
    var hasMore: Bool { hasMoreItems }
    
    init(hasMoreItems: Bool,
         viewState: ViewState) {
        self.hasMoreItems = hasMoreItems
        self.viewState = viewState
    }
    
    func requestCharactersNextPage(then handler: @escaping (ViewState) -> Void) {
        handler(viewState)
    }
}
