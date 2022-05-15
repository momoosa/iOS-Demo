//
//  Session.swift
//  iOS Demo
//
//  Created by Mo Moosa on 15/05/2022.
//

import Foundation

class Session: Decodable, Equatable {
    // Redundant Equatable conformance added for unit tests.
    enum CodingKeys: String, CodingKey {
        case bearerToken = "BearerToken"
        case externalSessionID = "ExternalSessionId"
        case expiryInSeconds = "ExpiryInSeconds"
    }

    let bearerToken: String
    let externalSessionID: String
    let expiryInSeconds: Int

    // MARK: - Init
    init(bearerToken: String, externalSessionID: String, expiryInSeconds: Int) {
        self.bearerToken = bearerToken
        self.externalSessionID = externalSessionID
        self.expiryInSeconds = expiryInSeconds
    }

    // MARK: - Equatable

    static func == (lhs: Session, rhs: Session) -> Bool {
        return lhs.bearerToken == rhs.bearerToken &&
        lhs.externalSessionID == rhs.externalSessionID &&
        lhs.expiryInSeconds == rhs.expiryInSeconds
    }
}
