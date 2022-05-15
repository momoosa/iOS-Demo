//
//  SessionManager.swift
//  iOS Demo
//
//  Created by Mo Moosa on 15/05/2022.
//

import Foundation

protocol UserManagerProtocol {
    var isLoggedIn: Bool { get }
    var user: User? { get }
    var session: Session? { get }

    func update(user: User, session: Session) throws
    func loadSerializedSession() throws
    func invalidateUserAndSession() throws
}

final class UserManager: UserManagerProtocol {
    enum KeychainKey: String {
        case bearerToken
        case sessionID
        case userID
    }

    enum Error: LocalizedError {
        case missingKeychain

        var errorDescription: String? {
            switch self {
            case .missingKeychain:
                return "No keychain found, session details cannot be stored."
            }
        }
    }
    static let current = UserManager()
    var keychain: KeyChainProtocol? {
        didSet {
            try? loadSerializedSession()
        }
    }
    var isLoggedIn: Bool {
        guard let session = session else {
            return false
        }

        return !session.bearerToken.isEmptyWhenIgnoringWhiteSpace
    }

    private(set) var user: User?
    private(set) var session: Session?

    // MARK: - User & Session Management
    func update(user: User, session: Session) throws {
        var keychain = try getKeychain()

        self.user = user
        self.session = session
        keychain[KeychainKey.userID.rawValue] = user.userID
        keychain[KeychainKey.bearerToken.rawValue] = session.bearerToken
        keychain[KeychainKey.sessionID.rawValue] = session.externalSessionID
    }

    func loadSerializedSession() throws {
        let keychain = try getKeychain()

        guard let userID = keychain[KeychainKey.userID.rawValue],
              let bearer = keychain[KeychainKey.bearerToken.rawValue],
              let sessionID = keychain[KeychainKey.sessionID.rawValue] else {
            print("Unable to retrieve serialized session: missing persisted data.")
            return
        }
        self.user = User(userID: userID)
        self.session = Session(bearerToken: bearer,
                               externalSessionID: sessionID,
                               expiryInSeconds: 3600)
    }

    func invalidateUserAndSession() throws {
        var keychain = try getKeychain()
        keychain[KeychainKey.bearerToken.rawValue] = nil
        keychain[KeychainKey.sessionID.rawValue] = nil
        keychain[KeychainKey.userID.rawValue] = nil
        session = nil
    }

    private func getKeychain() throws -> KeyChainProtocol {
        guard let keychain = keychain else {
            print("Unable to retrieve serialized session: missing keychain.")
            throw Error.missingKeychain
        }
        return keychain
    }
}
