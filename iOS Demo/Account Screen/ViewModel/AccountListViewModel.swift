//
//  AccountListViewModel.swift
//  iOS Demo
//
//  Created by Mo Moosa on 15/05/2022.
//

import Foundation

class AccountListViewModel<T: AccountProtocol> {
    private(set) var accounts: [AccountViewModel<T>] = []
    private var api: AccountListAPIProtocol

    init(api: AccountListAPIProtocol) {
        self.api = api
    }

    // MARK: API
    func getAccountList() async throws -> [AccountViewModel<T>] {
        accounts = try await api.getAccountList().compactMap({ account in
            guard let account = account as? T else {
                return nil // FIXME
            }

            return AccountViewModel(account: account)
        })
        return accounts
    }

    // MARK: Model Retrieval


    func message(for indexPath: IndexPath) -> AccountViewModel<T>? {

        guard indexPath.row < accounts.count else {
            print("ConversationViewModel received out-of-bounds indexPath: \(indexPath)")
            return nil
        }

        return accounts[indexPath.row]
    }

    func indexPath(for account: AccountViewModel<T>) -> IndexPath? {
        guard let accountIndex = accounts.firstIndex(of: account),
                accountIndex < accounts.count else { // TODO: Test
            return nil
        }

    return IndexPath(row: accountIndex, section: 0)
    }
}
