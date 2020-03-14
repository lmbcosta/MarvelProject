//
//  CharacterListDataSourceTests.swift
//  MarvelProjectTests
//
//  Created by Luis  Costa on 13/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import XCTest
@testable import MarvelProject

class CharacterListDataSourceTests: XCTestCase {
    private let bundle = Bundle(for: ModelTests.self)
    private let jsonFileName = "wrapperResponse"
    private var tableView = UITableView()
    
    func testDataSourceNumberOfItemsWithHasMore() {
        // Given
        let model: CharacterDataWrapper = bundle.decodeFile(name: jsonFileName)!
        let items = model.data.results
        let viewModel = MockCharacterListViewModel(hasMoreItems: true,
                                                   viewState: .data(items: items))
        let indexPath = IndexPath(item: items.count, section: 0)
        let sut = CharacterListDataSource(viewModel: viewModel, tableView: tableView)
        tableView.dataSource = sut
        
        
        // When
        sut.updateItems(items)
        let cell = sut.tableView(tableView, cellForRowAt: indexPath)
        
        // Then
        XCTAssertTrue(tableView.numberOfRows(inSection: 0) == items.count + 1)
        XCTAssertTrue(cell is LoadingCell)
    }
    
    func testDataSourceNumberOfItemsWithoutHasMore() {
        // Given
        let model: CharacterDataWrapper = bundle.decodeFile(name: jsonFileName)!
        let items = model.data.results
        let viewModel = MockCharacterListViewModel(hasMoreItems: false,
                                                viewState: .data(items: items))
        let indexPath = IndexPath(item: items.count - 1, section: 0)
        let sut = CharacterListDataSource(viewModel: viewModel, tableView: tableView)
        tableView.dataSource = sut

        // When
        sut.updateItems(items)
        let cell = sut.tableView(tableView, cellForRowAt: indexPath)

        // Then
        XCTAssertTrue(tableView.numberOfRows(inSection: 0) == items.count)
        XCTAssertTrue(cell is CharacterListCell)
    }
    
    func testDataSourceConformsToUITableViewDataSourceProtocol() {
        // Given
        let viewModel = MockCharacterListViewModel(hasMoreItems: true,
                                                   viewState: .error(title: "", message: ""))
        
        // When
        let sut = CharacterListDataSource(viewModel: viewModel,tableView: tableView)
        
        // Then
        XCTAssertTrue(sut.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:cellForRowAt:))))
        XCTAssertTrue(sut.responds(to: #selector(sut.tableView(_:numberOfRowsInSection:))))
    }
    
    func testDataSourceResetDataWithMoreItems() {
        // Given
        let model: CharacterDataWrapper = bundle.decodeFile(name: jsonFileName)!
        let items = model.data.results
        let viewModel = MockCharacterListViewModel(hasMoreItems: true,
                                                   viewState: .data(items: items))
        
        // When
        let sut = CharacterListDataSource(viewModel: viewModel,
                                          tableView: tableView)
        sut.resetItems()
        
        // Then
        XCTAssertTrue(sut.tableView(tableView, numberOfRowsInSection: 0) == 1)
    }
    
    func testDataSourceResetDataWithoutMoreItems() {
        // Given
        let model: CharacterDataWrapper = bundle.decodeFile(name: jsonFileName)!
        let items = model.data.results
        let viewModel = MockCharacterListViewModel(hasMoreItems: false,
                                                   viewState: .data(items: items))
        
        // When
        let sut = CharacterListDataSource(viewModel: viewModel,
                                          tableView: tableView)
        sut.resetItems()
        
        // Then
        XCTAssertTrue(sut.tableView(tableView, numberOfRowsInSection: 0) == 0)
    }
}
