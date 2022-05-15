////
////  AccountListFlowController.swift
////  iOS Demo
////
////  Created by Mo Moosa on 15/05/2022.
////
//
import UIKit
//
class AccountListFlowController: UIViewController {
    private let navigation = UINavigationController()

    override func viewDidLoad() {
        super.viewDidLoad()
        add(child: navigation)
        showAccountListViewController()
    }

    func showAccountListViewController() {
        let api = AccountListViewModel<Account>(api: AccountListAPI())
    navigation.show(AccountListViewController(viewModel: api), sender: self)
    }

    func showAccountDetailViewController() {
        navigation.show(AccountDetailViewController(), sender: self)
    }

    func safeToMoveForward(from viewController: UIViewController) -> Bool {
        guard viewController == self.navigation.topViewController else {
            print("Received message to move forward from viewController that isn't currently active.")
            return false
        }
        return true
    }
}
