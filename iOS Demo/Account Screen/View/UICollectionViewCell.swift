//
//  UICollectionViewCell.swift
//  iOS Demo
//
//  Created by Mo Moosa on 15/05/2022.
//

import UIKit

class AccountCollectionViewCell: UICollectionViewCell {
    private let stackview = UIStackView()
    private let textLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackview)
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.pinToSuperview()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        stackview.addArrangedSubview(textLabel)
        textLabel.numberOfLines = 3
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with account: AccountViewModel<Account>) {
        textLabel.text = "Test"
        textLabel.numberOfLines = 3
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        for view in stackview.arrangedSubviews {
            view.removeFromSuperview()
        }
    }
}



