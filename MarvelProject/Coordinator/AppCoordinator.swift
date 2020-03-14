//
//  AppCoordinator.swift
//  MarvelProject
//
//  Created by Luis  Costa on 13/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import UIKit

protocol Navigatable: class {
    func navigateToCharacterDetail(from: UIViewController,
                                   using viewModel: CharacterDetailViewModelProtocol)
}

final class AppCoordinator {
    func buildRootViewController() -> UIViewController {
        return buildCharacterListViewController()
    }
    
    // MARK: - Private
    private func buildCharacterListViewController() -> UIViewController {
        let cryptoHelper = CryptoHelper()
        let service = MarvelService(cryptoHelper: cryptoHelper, requestLimit: 20)
        let viewModel = CharacterListViewModel(service: service)
        let viewController = CharacterListViewController(viewModel: viewModel,
                                                         navigationDelegate: self)
        
        
        let navigationcontroller = UINavigationController(rootViewController: viewController)
        navigationcontroller.navigationBar.prefersLargeTitles = true
        return navigationcontroller
    }
    
    private func buildCharacterDetailViewController(using viewModel: CharacterDetailViewModelProtocol) -> UIViewController {
        return CharacterDetailViewController(viewModel: viewModel)
    }
}

// MARK: - Navigatable
extension AppCoordinator: Navigatable {
    func navigateToCharacterDetail(from: UIViewController,
                                   using viewModel: CharacterDetailViewModelProtocol) {
        let detailViewController = buildCharacterDetailViewController(using: viewModel)
        from.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
