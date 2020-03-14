//
//  CharacterListViewModel.swift
//  MarvelProject
//
//  Created by Luis  Costa on 13/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import Foundation

protocol CharacterListReloadable {
    var hasMore: Bool { get }
}

protocol CharacterListPaginable {
    func requestCharactersNextPage(then handler: @escaping (ViewState) -> Void)
}

typealias CharacterListViewModelProtocol = CharacterListReloadable & CharacterListPaginable

final class CharacterListViewModel: CharacterListViewModelProtocol {
    // MARK: - Properties
    private let service: MarvelServiceProtocol
    private var offset = 0
    private var total = 0
    
    var hasMore: Bool {
        offset > 0 && offset <= total || offset == 0 && total == 0
    }
    
    // MARK: - Initializer
    init(service: MarvelServiceProtocol) {
        self.service = service
    }
    
    func requestCharactersNextPage(then handler: @escaping (ViewState) -> Void) {
        service.fetchCharacters(for: offset) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure:
                    handler(.error(title: Strings.errorTitle,
                                   message: Strings.errorMessage))
                        
                case .success(let model):
                    let data = model.data
                    self?.updatePagination(totalResults: data.total,
                                           newOffset: data.results.count)
                    handler(.data(items: data.results))
                }
            }
        }
    }
    
    private func updatePagination(totalResults: Int?, newOffset: Int?) {
        total = (totalResults ?? total)
        offset += (newOffset ?? 0)
    }
}

extension CharacterListViewModel {
    struct Strings {
        static let errorTitle = "Error"
        static let errorMessage = "Something went wrong. Please try again"
    }
}
