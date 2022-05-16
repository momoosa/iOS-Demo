//
//  UICollectionViewCell.swift
//  iOS Demo
//
//  Created by Mo Moosa on 15/05/2022.
//

import UIKit

class AccountCollectionViewCell: UICollectionViewCell {
    private let stackview = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let titleStackView = UIStackView()
    private let amountLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupStackView()
        setupTitleStackView()
        setupTitleLabel()
        setupSubtitleLabel()
        stackview.addSpacer()
        setupAmountLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupStackView() {
        addSubview(stackview)
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.pinToSuperview()
    }

    private func setupTitleStackView() {
        titleStackView.axis = .vertical
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        stackview.addArrangedSubview(titleStackView)
    }

    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.addArrangedSubview(titleLabel)
    }

    private func setupSubtitleLabel() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.addArrangedSubview(subtitleLabel)
    }

    private func setupAmountLabel() {
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        stackview.addArrangedSubview(amountLabel)
    }

    // MARK: - Content
    func update(with account: AccountViewModel<Account>) {
        titleLabel.text = account.name
        subtitleLabel.text = account.number
        amountLabel.text = account.amount
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        for view in stackview.arrangedSubviews {
            view.removeFromSuperview()
        }
    }
}

extension UIStackView {
    func addSpacer() {
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(spacer)
    }
}


