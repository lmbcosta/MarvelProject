//
//  CharacterDetailViewModelTests.swift
//  MarvelProjectTests
//
//  Created by Luis  Costa on 14/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import XCTest
@testable import MarvelProject

class CharacterDetailViewModelTests: XCTestCase {
    private let bundle = Bundle(for: ModelTests.self)
    
    func testCharacterDetailWithTitle() {
        // Given
        let jsonFileName = "characterResponse1"
        let model: MarvelCharacter = bundle.decodeFile(name: jsonFileName)!
        
        // When
        let sut = CharacterDetailViewModel(item: model)
        
        // Then
        XCTAssertTrue(sut.title == "3-D Man")
    }
    
    func testCharacterDetailWithoutTitle() {
        // Given
        let jsonFileName = "characterResponse2"
        let model: MarvelCharacter = bundle.decodeFile(name: jsonFileName)!
        
        // When
        let sut = CharacterDetailViewModel(item: model)
        
        // Then
        XCTAssertTrue(sut.title == "Without Title😕")
    }
    
    func testCharacterDetailWithId() {
        // Given
        let jsonFileName = "characterResponse1"
        let model: MarvelCharacter = bundle.decodeFile(name: jsonFileName)!
        let sut = CharacterDetailViewModel(item: model)
        
        // When
        let detailItem = sut.detailItem(for: .id)
        
        // Then
        XCTAssertTrue(detailItem.title == "ID:")
        XCTAssertTrue(detailItem.description == "1011334")
    }
    
    func testCharacterDetailWithoutId() {
        // Given
        let jsonFileName = "characterResponse2"
        let model: MarvelCharacter = bundle.decodeFile(name: jsonFileName)!
        let sut = CharacterDetailViewModel(item: model)
        
        // When
        let detailItem = sut.detailItem(for: .id)
        
        // Then
        XCTAssertTrue(detailItem.title == "ID:")
        XCTAssertTrue(detailItem.description == "Without Id😕")
    }
    
    func testCharacterDetailWithDescription() {
        // Given
        let jsonFileName = "characterResponse1"
        let model: MarvelCharacter = bundle.decodeFile(name: jsonFileName)!
        let extractedExpr = CharacterDetailViewModel(item: model)
        let sut = extractedExpr
        
        // When
        let detailItem = sut.detailItem(for: .description)
        
        // Then
        XCTAssertTrue(detailItem.title == "Description: ")
        XCTAssertTrue(detailItem.description == "Some Description")
    }
    
    func testCharacterDetailWithoutDescription() {
        // Given
        let jsonFileName = "characterResponse2"
        let model: MarvelCharacter = bundle.decodeFile(name: jsonFileName)!
        let sut = CharacterDetailViewModel(item: model)
        
        // When
        let detailItem = sut.detailItem(for: .description)
        
        // Then
        XCTAssertTrue(detailItem.title == "Description: ")
        XCTAssertTrue(detailItem.description == "Without Description😕")
    }
}
