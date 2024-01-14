//
//  CategoriesCollectionViewCell.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 14.01.2024.
//

import UIKit

final class CategoriesCollectionViewCell: UICollectionViewCell {

    static let id = "CategoriesCollectionViewCell"

    private lazy var backgroundImageCell: UIImageView = {
        let backgroundImageCell = UIImageView()
        backgroundImageCell.backgroundColor = .white
        backgroundImageCell.layer.cornerRadius = 16
        backgroundImageCell.layer.borderWidth = 1
        backgroundImageCell.layer.borderColor = UIColor(named: "backgroundImageCellColor")?.cgColor
        backgroundImageCell.clipsToBounds = true
        backgroundImageCell.backgroundColor = .clear
        return backgroundImageCell
    }()

    private lazy var categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.text = ""
        categoryLabel.font =  UIFont.boldSystemFont(ofSize: 13)
        categoryLabel.textColor = UIColor(named: "TabBarActiveColor")
        return categoryLabel
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        addSubviews([backgroundImageCell,
                     categoryLabel])
        installingСonstraints()
    }
}

extension CategoriesCollectionViewCell {

    private func installingСonstraints() {
        NSLayoutConstraint.activate([
            backgroundImageCell.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageCell.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImageCell.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageCell.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoryLabel.centerYAnchor.constraint(equalTo: backgroundImageCell.centerYAnchor),
            categoryLabel.centerXAnchor.constraint(equalTo: backgroundImageCell.centerXAnchor)
        ])
    }

    func setupCell(categoryName: String, isActive: Bool) {
        categoryLabel.text = categoryName
        backgroundImageCell.backgroundColor = isActive ? UIColor(named: "backgroundImageCellColor") : .clear
        backgroundImageCell.layer.borderWidth = isActive ? 0 : 1
    }
}
