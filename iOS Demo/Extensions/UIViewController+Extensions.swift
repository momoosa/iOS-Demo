//
//  UIViewController+Extensions.swift
//  iOS Demo
//
//  Created by Mo Moosa on 15/05/2022.
//

import UIKit

extension UIViewController {
    func add(child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
}
