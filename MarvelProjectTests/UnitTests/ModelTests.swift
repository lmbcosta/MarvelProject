//
//  ModelTests.swift
//  MarvelProjectTests
//
//  Created by Luis  Costa on 13/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import XCTest
@testable import MarvelProject

class ModelTests: XCTestCase {
    private let bundle = Bundle(for: ModelTests.self)
    private let jsonFileName = "wrapperResponse"
    
    func testWrapperResponse() {
        // When
        let sut: CharacterDataWrapper = bundle.decodeFile(name: jsonFileName)!
        
        // Then
        XCTAssertNotNil(sut.data)
    }
    
    func testWrapperDataResponse() {
        // Given
        let wrapper: CharacterDataWrapper = bundle.decodeFile(name: jsonFileName)!
        
        // When
        let sut = wrapper.data
        
        // Then
        XCTAssertTrue(sut.offset == 0)
        XCTAssertTrue(sut.results.count == 20)
    }
    
    func testCharacter() {
        // Given
        let wrapper: CharacterDataWrapper = bundle.decodeFile(name: jsonFileName)!
        
        // When
        let sut = wrapper.data.results.first!
        
        // Then
        XCTAssertTrue(sut.name == "3-D Man")
        XCTAssertTrue(sut.id == 1011334)
    }
    
    func testCharacterThumNail() {
        // Given
        let jsonFileName = "wrapperResponse"
        let wrapper: CharacterDataWrapper = bundle.decodeFile(name: jsonFileName)!
        
        // When
        let sut = wrapper.data.results.first!.thumbnail
        
        // Then
        XCTAssertTrue(sut?.extension == "jpg")
        XCTAssertTrue(sut?.path == "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784")
    }
}
