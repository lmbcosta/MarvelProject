//
//  MockNavigator.swift
//  MarvelProjectTests
//
//  Created by Luis  Costa on 15/05/2021.
//  Copyright © 2021 Luis  Costa. All rights reserved.
//

import UIKit
@testable import MarvelProject

class MockNavigator: Navigatable {
    private(set) var isNavigate: Bool = false
    
    func navigateToCharacterDetail(from: UIViewController, using viewModel: CharacterDetailViewModelProtocol) {
        isNavigate = true
    }
}
