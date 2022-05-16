//
//  Account.swift
//  iOS Demo
//
//  Created by Mo Moosa on 15/05/2022.
//

import Foundation

protocol AccountProtocol: Hashable {
    var id: String { get }
    var name: String { get }
    var amount: Double { get } // TODO: Decode as in
    var accountNumber: String { get } // TODO: Decode as in
}
struct Account: Decodable, AccountProtocol {
    let id: String
    let name: String
    let amount: Double
    let accountNumber: String
}
