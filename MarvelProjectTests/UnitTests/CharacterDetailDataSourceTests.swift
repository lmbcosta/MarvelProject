//
//  CharacterDetailDataSourceTests.swift
//  MarvelProjectTests
//
//  Created by Luis  Costa on 14/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import XCTest
@testable import MarvelProject

class CharacterDetailDataSourceTests: XCTestCase {
    private let bundle = Bundle(for: CharacterDetailDataSourceTests.self)
    private let jsonFileName = "characterResponse1"
    private var tableView = UITableView()
    
    func testDetailDataSourceConformsToUITableViewDataSourceProtocol() {
        // Given
        let model: MarvelCharacter = bundle.decodeFile(name: jsonFileName)!
        let viewModel = CharacterDetailViewModel(item: model)

        // When
        let sut = CharacterDetailDataSource(viewModel: viewModel, tableView: tableView)

        // Then
        XCTAssertTrue(sut.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:cellForRowAt:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:numberOfRowsInSection:))))
    }
    
    func testDetailDetaSourceNumberOfItems() {
        // Given
        let model: MarvelCharacter = bundle.decodeFile(name: jsonFileName)!
        let viewModel = CharacterDetailViewModel(item: model)
        let sut = CharacterDetailDataSource(viewModel: viewModel, tableView: tableView)
        
        // When
        tableView.dataSource = sut
        
        // Then
        XCTAssertTrue(tableView.numberOfRows(inSection: 0) == 3)
    }
}
