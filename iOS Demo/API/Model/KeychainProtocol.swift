//
//  KeychainProtocol.swift
//  iOS Demo
//
//  Created by Mo Moosa on 15/05/2022.
//

import Foundation

protocol KeyChainProtocol {
    init(service: String)
    subscript(key: String) -> String? { get set }
}
