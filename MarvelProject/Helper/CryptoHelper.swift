//
//  CryptoHelper.swift
//  MarvelProject
//
//  Created by Luis  Costa on 13/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import Foundation
import CryptoSwift

protocol CryptoHelperProtocol {
    func hashMD5(publicKey: String, privateKey: String, timeStamp: String) -> String
}

struct CryptoHelper: CryptoHelperProtocol {
    func hashMD5(publicKey: String, privateKey: String, timeStamp: String) -> String {
        return hashMD5(contents: [timeStamp, privateKey, publicKey])
    }
    
    private func hashMD5(contents: [String]) -> String {
        return contents.reduce("", +).md5()
    }
}
