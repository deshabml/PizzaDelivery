//
//  UIView+AddSudviews.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 14.01.2024.
//

import UIKit

extension UIView {

    func addSubviews(_ arrayView: [UIView]) {
        arrayView.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
}
