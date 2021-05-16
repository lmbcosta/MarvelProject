//
//  CharacterDetailViewControllerTests.swift
//  MarvelProjectTests
//
//  Created by Luis  Costa on 14/05/2021.
//  Copyright © 2021 Luis  Costa. All rights reserved.
//

import XCTest
@testable import MarvelProject

class CharacterDetailViewControllerTests: XCTestCase {
    private let bundle = Bundle(for: ModelTests.self)
    let model = MarvelCharacter(id: 123, name: "TestHero", description: "My Test Hero", thumbnail: .init(path: "path", extension: "extension"))
    
    func testCharacterDetailViewControllerTitle() {
        let viewModel = CharacterDetailViewModel(item: model)
        let sut = CharacterDetailViewController(viewModel: viewModel)
        let _ = sut.view
        XCTAssertTrue(sut.title == "TestHero")
    }
    
    func testCharacterDetailViewControllerImageCell() {
        let viewModel = CharacterDetailViewModel(item: model)
        let sut = CharacterDetailViewController(viewModel: viewModel)
        let _ = sut.view
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? ImageCell
        XCTAssert(cell != nil)
    }
    
    func testCharacterDetailViewControllerDetailCellID() {
        let viewModel = CharacterDetailViewModel(item: model)
        let sut = CharacterDetailViewController(viewModel: viewModel)
        let _ = sut.view
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 1, section: 0)) as? DetailCell
        XCTAssert(cell?.topLabel.text == "ID:")
        XCTAssert(cell?.bottomLabel.text == "\(123)")
    }
    
    func testCharacterDetailViewControllerDetailCellDescription() {
        let viewModel = CharacterDetailViewModel(item: model)
        let sut = CharacterDetailViewController(viewModel: viewModel)
        let _ = sut.view
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 2, section: 0)) as? DetailCell
        XCTAssert(cell?.topLabel.text == "Description: ")
        XCTAssert(cell?.bottomLabel.text == "My Test Hero")
    }
}
