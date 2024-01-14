//
//  BannerCollectionViewCell.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 14.01.2024.
//

import UIKit

final class BannerCollectionViewCell: UICollectionViewCell {

    static let id = "BannerCollectionViewCell"

    private lazy var ImageView: UIImageView = {
        let ImageView = UIImageView()
        ImageView.layer.cornerRadius = 10
        ImageView.clipsToBounds = true
        return ImageView
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        addSubviews([ImageView])
        installingСonstraints()
    }
}

extension BannerCollectionViewCell {

    private func installingСonstraints() {
        NSLayoutConstraint.activate([
            ImageView.topAnchor.constraint(equalTo: topAnchor),
            ImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            ImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func setupCell(photo: String) {
        ImageView.image = UIImage(named: photo)
    }
}
