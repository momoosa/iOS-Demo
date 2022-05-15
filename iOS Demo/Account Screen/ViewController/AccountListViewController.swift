//
//  ViewController.swift
//  iOS Demo
//
//  Created by Mo Moosa on 15/05/2022.
//

import Combine
import UIKit

class AccountListViewController: UIViewController {

    private let viewModel: AccountListViewModel<Account>
    // MARK: - UICollectionView
    private let collectionView: UICollectionView
    private var collectionViewBottomConstraint: NSLayoutConstraint?

    private lazy var datasource = UICollectionViewDiffableDataSource<Int,
                                                                     AccountViewModel<Account>>(collectionView: collectionView) { collectionView, indexPath, account in
                                                                         guard let cell = collectionView.dequeueReusableCell(
                                                                            withReuseIdentifier: "Test",
                                                                            for: indexPath) as? AccountCollectionViewCell else {
                                                                             return UICollectionViewCell()
                                                                         }

                                                                         cell.update(with: account)

                                                                         return cell
                                                                     }

    private var keyboardSubscriber: AnyCancellable?

    private let keyboardNotifications: [NSNotification.Name] = [
        UIResponder.keyboardWillShowNotification]


    // MARK: - Init
    init(viewModel: AccountListViewModel<Account>) {
        self.viewModel = viewModel

        self.collectionView = UICollectionView(frame: .zero,
                                               collectionViewLayout: AccountListViewController.createLayout())

        super.init(nibName: nil, bundle: nil)

        keyboardSubscriber = Publishers.MergeMany(
            keyboardNotifications.map { NotificationCenter.default.publisher(for: $0) }
        )
        .sink(receiveValue: { [weak self] notification in
            //            self?.handle(keyboardNotification: notification) // fIXME:
        })
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        Task {
            do {
                let accounts = try await viewModel.getAccountList()

                var snapshot = NSDiffableDataSourceSectionSnapshot<AccountViewModel<Account>>()
                snapshot.append(accounts)
                await datasource.apply(snapshot, to: 0, animatingDifferences: false)

            } catch {
                print("Encountered error when trying to load accounts: \(error)")
            }
        }
    }

    // MARK: Setup
    private func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.register(AccountCollectionViewCell.self,
                                forCellWithReuseIdentifier: "Test")
        collectionView.pinToSuperview(edges: [.leading, .top, .trailing])

        collectionViewBottomConstraint = collectionView.bottomAnchor.constraint(equalTo:
                                                                                    view.keyboardLayoutGuide.topAnchor)
        collectionViewBottomConstraint?.isActive = true
    }

    static private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}

