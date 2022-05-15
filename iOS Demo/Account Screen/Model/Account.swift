//
//  Account.swift
//  iOS Demo
//
//  Created by Mo Moosa on 15/05/2022.
//

import Foundation

protocol AccountProtocol: Hashable {
    var id: String { get }
    var amount: String { get } // TODO: Decode as int
}
struct Account: Decodable, AccountProtocol {
    let id: String
    let amount: String
}
