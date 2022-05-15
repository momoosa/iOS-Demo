//
//  UIView+Extensions.swift
//  iOS Demo
//
//  Created by Mo Moosa on 15/05/2022.
//

import UIKit

enum Edge: CaseIterable {
    case top
    case leading
    case bottom
    case trailing

    var layoutAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .top:
            return .top
        case .bottom:
            return .bottom
        case .leading:
            return .left
        case .trailing:
            return .right
        }
    }
}

extension UIView {
    func pinToSuperview(edges: [Edge] = Edge.allCases,
                        constant: CGFloat = 8,
                        priority: UILayoutPriority = UILayoutPriority.required) {
        guard let superview = self.superview else {
            preconditionFailure("view has no superview")
        }

        for edge in edges {
            switch edge {
            case .top:
                self.topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
            case .leading:
                self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
            case .bottom:
                self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
            case .trailing:
                self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant).isActive = true
            }
        }
    }
}
