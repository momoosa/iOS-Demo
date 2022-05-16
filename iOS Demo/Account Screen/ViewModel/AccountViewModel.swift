//
//  AccountViewModel.swift
//  iOS Demo
//
//  Created by Mo Moosa on 15/05/2022.
//

import Foundation

class AccountViewModel<T: AccountProtocol>: Hashable {

    var name: String {
        return account.name
    }
    
    var amount: String {
        return account.amount.formatted(.currency(code: Locale.current.currencyCode ?? "USD"))
    }

    var number: String {
        return account.accountNumber
    }

    private var account: T

    init(account: T) {
        self.account = account
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(account)
    }
    static func == (lhs: AccountViewModel<T>, rhs: AccountViewModel<T>) -> Bool {
        return lhs.account == rhs.account
    }
}
