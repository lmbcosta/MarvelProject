//
//  CharacterListViewControllerTests.swift
//  MarvelProjectTests
//
//  Created by Luis  Costa on 15/05/2021.
//  Copyright © 2021 Luis  Costa. All rights reserved.
//

import XCTest
@testable import MarvelProject

class CharacterListViewControllerTests: XCTestCase {
    private let bundle = Bundle(for: ModelTests.self)
    
    let jsonFileName = "wrapperResponse"
    
    func testEmptyStateIsHidden() {
        let model: CharacterDataWrapper = bundle.decodeFile(name: jsonFileName)!
        let service = MockMarvelService(response: .success(model),
                                        requestLimit: 20)
        let viewModel = CharacterListViewModel(service: service)
        let sut = CharacterListViewController(viewModel: viewModel,
                                              navigationDelegate: nil)
        _ = sut.view
        XCTAssertTrue(sut.emptyStateView.isHidden)
    }
    
    func testEmptyStateIsShowing() {
        let service = MockMarvelService(response: .failure(APIError.decodeJson),
                                        requestLimit: 20)
        let viewModel = CharacterListViewModel(service: service)
        let sut = CharacterListViewController(viewModel: viewModel,
                                              navigationDelegate: nil)
        _ = sut.view
        
        let expectation = XCTestExpectation(description: "Emplty state should Appear")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            if !sut.emptyStateView.isHidden {
                expectation.fulfill()
            }
        })
        
        wait(for: [expectation], timeout: 3)
    }
    
    func testCharacterListViewControllerCellsTitle() {
        let model: CharacterDataWrapper = bundle.decodeFile(name: jsonFileName)!
        let service = MockMarvelService(response: .success(model),
                                        requestLimit: 20)
        let viewModel = CharacterListViewModel(service: service)
        let sut = CharacterListViewController(viewModel: viewModel,
                                              navigationDelegate: nil)
        _ = sut.view
        let expectation = XCTestExpectation(description: "Expectation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            let firstCell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(item: 0, section: 0)) as? CharacterListCell
            let secondCell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(item: 1, section: 0)) as? CharacterListCell
            
            if firstCell?.label.text == "3-D Man", secondCell?.label.text == "A-Bomb (HAS)" {
                expectation.fulfill()
            }
        })
        
        wait(for: [expectation], timeout: 3)
    }
    
    func testCharacterListViewControllerNavigationToDetail() {
        let model: CharacterDataWrapper = bundle.decodeFile(name: jsonFileName)!
        let service = MockMarvelService(response: .success(model),
                                        requestLimit: 20)
        let viewModel = CharacterListViewModel(service: service)
        let navigator = MockNavigator()
        let sut = CharacterListViewController(viewModel: viewModel, navigationDelegate: navigator)
        _ = sut.view
        let expectation = XCTestExpectation(description: "Expectation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
            if navigator.isNavigate {
                expectation.fulfill()
            }
        })
        
        wait(for: [expectation], timeout: 3)
    }
    
    func testCharacterListViewControllerNavigationToDetailName() {
        
    }
}
