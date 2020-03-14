//
//  MarvelService.swift
//  MarvelProject
//
//  Created by Luis  Costa on 13/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import Foundation

protocol MarvelServiceProtocol {
    var requestPerPage: Int { get set }
    
    func fetchCharacters(for offset: Int, then handler: @escaping (Result<CharacterDataWrapper, Error>) -> Void)
}

class MarvelService: MarvelServiceProtocol {
    // MARK: - Properties
    private let cryptoHelper: CryptoHelperProtocol
    private var requestLimit: Int
    
    var requestPerPage: Int {
        get { requestLimit }
        set { requestLimit = newValue }
    }
    
    // MARK: - Initializer
    init(cryptoHelper: CryptoHelperProtocol,
         requestLimit: Int) {
        self.cryptoHelper = cryptoHelper
        self.requestLimit = requestLimit
    }
    
    // MARK: - Private
    private func buildURL(offset: String) -> URL? {
        let timeStamp = "\(Date().timeIntervalSince1970)"
        let hashValue = cryptoHelper.hashMD5(publicKey: Constants.publicKey,
                                             privateKey: Constants.privateKey,
                                             timeStamp: timeStamp)
        
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        urlComponents.path = Constants.path
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: Constants.hashKeyParameter, value: hashValue),
            URLQueryItem(name: Constants.limitKeyParameter, value: "\(requestLimit)"),
            URLQueryItem(name: Constants.offsetKeyParameter, value: offset),
            URLQueryItem(name: Constants.orderByKeyParamter, value: Constants.byNameOrderValueParameter),
            URLQueryItem(name: Constants.publicKeyParameter, value: Constants.publicKey),
            URLQueryItem(name: Constants.timeStampKeyParameter, value: timeStamp)
        ]
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
    
    func fetchCharacters(for offset: Int, then handler: @escaping (Result<CharacterDataWrapper, Error>) -> Void) {
        
        guard let url = buildURL(offset: "\(offset)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                handler(.failure(error))
                return
            }
            
            guard let data = data else {
                handler(.failure(APIError.decodeJson))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(CharacterDataWrapper.self, from: data)
                handler(.success(response))
            } catch let error {
                handler(.failure(error))
                return
            }
        }.resume()
    }
}

// MARK: - Constants
extension MarvelService {
    struct Constants {
        static let host = "gateway.marvel.com"
        static let path = "/v1/public/characters"
        static let scheme = "https"
        static let publicKey = "bcde88753eb18fcd02abd5398d150a0d"
        static let privateKey = "a60c9e45f8318bfb15ec6ca5b7b24eab56d89683"
        static let hashKeyParameter = "hash"
        static let offsetKeyParameter = "offset"
        static let limitKeyParameter = "limit"
        static let orderByKeyParamter = "orderBy"
        static let byNameOrderValueParameter = "name"
        static let publicKeyParameter = "apikey"
        static let timeStampKeyParameter = "ts"
    }
}
