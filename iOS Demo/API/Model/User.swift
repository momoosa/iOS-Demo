//
//  User.swift
//  iOS Demo
//
//  Created by Mo Moosa on 15/05/2022.
//

import Foundation

struct User: Decodable, Equatable { // Redundant Equatable conformance added for unit tests.
    enum CodingKeys: String, CodingKey {
        case userID
    }
    private(set) var userID: String?

    // MARK: - Init
    init(userID: String? = nil) {
        self.userID = userID
    }
}
