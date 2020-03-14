//
//  CharacterListViewModelTests.swift
//  MarvelProjectTests
//
//  Created by Luis  Costa on 13/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import XCTest
@testable import MarvelProject

class CharacterListPaginableTests: XCTestCase {
    private let bundle = Bundle(for: ModelTests.self)
    
    func testRequestingCharactersValidNextPage() {
        // Given
        let jsonFileName = "wrapperResponse"
        let model: CharacterDataWrapper = bundle.decodeFile(name: jsonFileName)!
        let service = MockMarvelService(response: .success(model),
                                        requestLimit: 20)
        let hasMoreItemsExpectation = expectation(description: "View Model should have more available pages to fetch")
        let sut = CharacterListViewModel(service: service)
        
        // When
        sut.requestCharactersNextPage(then: { _ in
            if sut.hasMore == true {
                hasMoreItemsExpectation.fulfill()
            }
        })
        
        // Then
        wait(for: [hasMoreItemsExpectation], timeout: 0.3)
    }
    
    func testRequestingCharactersInvalidNextPage() {
        // Given
        let jsonFileName = "wrapperLastResponse"
        let model: CharacterDataWrapper = bundle.decodeFile(name: jsonFileName)!
        let service = MockMarvelService(response: .success(model),
        requestLimit: 20)
        let hasMoreItemsExpectation = expectation(description: "View Model should not have more available pages to fetch")
        let sut = CharacterListViewModel(service: service)
        
        // When
        sut.requestCharactersNextPage(then: { _ in
            if !sut.hasMore {
                hasMoreItemsExpectation.fulfill()
            }
        })
        
        // Then
        wait(for: [hasMoreItemsExpectation], timeout: 0.3)
    }
}
