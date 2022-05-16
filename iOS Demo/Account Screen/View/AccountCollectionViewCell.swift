//
//  UICollectionViewCell.swift
//  iOS Demo
//
//  Created by Mo Moosa on 15/05/2022.
//

import UIKit

class AccountCollectionViewCell: UICollectionViewCell {
    private let stackview = UIStackView.autoLayout()
    private let titleLabel = UILabel.autoLayout()
    private let subtitleLabel = UILabel.autoLayout()
    private let titleStackView = UIStackView.autoLayout()
    private let amountLabel = UILabel.autoLayout()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
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
        stackview.spacing = Constants.padding
        stackview.pinToSuperview()
    }

    private func setupTitleStackView() {
        titleStackView.axis = .vertical
        titleStackView.spacing = Constants.padding
        stackview.addArrangedSubview(titleStackView)
    }

    private func setupTitleLabel() {
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.textColor = UIColor.accent
        titleStackView.addArrangedSubview(titleLabel)
    }

    private func setupSubtitleLabel() {
        amountLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        titleStackView.addArrangedSubview(subtitleLabel)
    }

    private func setupAmountLabel() {
        amountLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        amountLabel.textColor = UIColor.accent
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
        let spacer = UIView.autoLayout()
        addArrangedSubview(spacer)
    }
}


