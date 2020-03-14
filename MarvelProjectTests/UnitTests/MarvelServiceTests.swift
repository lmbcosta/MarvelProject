//
//  MarvelServiceTests.swift
//  MarvelProjectTests
//
//  Created by Luis  Costa on 13/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import XCTest
@testable import MarvelProject

class MarvelServiceTests: XCTestCase {
    private let bundle = Bundle(for: ModelTests.self)
    private let jsonFileName = "wrapperResponse"
    func testMarvelServiceWithIncorrectOffset() {
        // Given
        let errorExpectation = expectation(description: "Service should respon with error")
        let sut: MarvelServiceProtocol = MarvelService(cryptoHelper: CryptoHelper(),
                                    requestLimit: 20)
        
        // When
        sut.fetchCharacters(for: -89) { result in
            if case .failure = result {
                errorExpectation.fulfill()
            }
        }
        
        // Then
        wait(for: [errorExpectation], timeout: 3)
    }
    
    func testMarvelServiceWithIncorrectRequestLimit() {
        // Given
        let errorExpectation = expectation(description: "Service should respon with error")
        let sut: MarvelServiceProtocol = MarvelService(cryptoHelper: CryptoHelper(),
                                                       requestLimit: 0)
        
        // When
        sut.fetchCharacters(for: 0) { result in
            if case .failure = result {
                errorExpectation.fulfill()
            }
        }
        
        // Then
        wait(for: [errorExpectation], timeout: 3)
    }
    
    func testCorrectResponse() {
        // Given
        let validResponselExpectation = expectation(description: "Should receive a valid response")
        let sut: MarvelServiceProtocol = MarvelService(cryptoHelper: CryptoHelper(),
                                                       requestLimit: 20)
    
        // When
        sut.fetchCharacters(for: 20) { result in
            if case .success = result {
                validResponselExpectation.fulfill()
            }
        }
        
        // Then
        wait(for: [validResponselExpectation], timeout: 3)
    }
}
