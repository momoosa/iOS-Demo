//
//  Transaction.swift
//  iOS Demo
//
//  Created by Mo Moosa on 15/05/2022.
//

import Foundation

struct Transaction: Decodable {
    let id: String
    let name: String
    let avatar: String
    let timestamp: Date
}
