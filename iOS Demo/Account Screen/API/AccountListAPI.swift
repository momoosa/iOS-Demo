//
//  AccountListAPI.swift
//  iOS Demo
//
//  Created by Mo Moosa on 15/05/2022.
//

import Foundation

protocol AccountListAPIProtocol {
    func getAccountList() async throws -> [Account]
}

final class AccountListAPI: API, AccountListAPIProtocol{
    override var baseURL: String {
        return "62812cd71020d85205865f3c.mockapi.io"
    }

    private let getAccountList = Endpoint<[Account]>(path: "accounts",
                                                                  method: .get,
                                                                  authenticated: false,
                                                                  queryItems: [])
    func getAccountList() async throws -> [Account] {
        let request = try makeRequest(for: getAccountList, data: nil)
        return try await send(request: request)
    }
}
