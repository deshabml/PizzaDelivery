//
//  DishCollectionViewCell.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 14.01.2024.
//

import UIKit

final class DishCollectionViewCell: UITableViewCell {

    static let id = "DishCollectionViewCell"

    private lazy var ImageView: UIImageView = {
        let ImageView = UIImageView()
        return ImageView
    }()

    private lazy var dishLabel: UILabel = {
        let dishLabel = UILabel()
        dishLabel.text = ""
        dishLabel.font =  UIFont.boldSystemFont(ofSize: 17)
        dishLabel.textColor = .black
        return dishLabel
    }()

    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = ""
        descriptionLabel.font =  UIFont.systemFont(ofSize: 13)
        descriptionLabel.textColor = UIColor(named: "DescriptionColor")
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()

    private lazy var purchaseButton: UIButton = {
        let purchaseButton = UIButton()
        purchaseButton.setTitle("", for: .normal)
        purchaseButton.setTitleColor(UIColor(named: "TabBarActiveColor"), for: .normal)
        purchaseButton.setTitleColor(.red, for: .highlighted)
        purchaseButton.titleLabel?.font =  UIFont.systemFont(ofSize: 13)
        purchaseButton.contentHorizontalAlignment = .center
        purchaseButton.layer.cornerRadius = 6
        purchaseButton.layer.borderWidth = 1
        purchaseButton.layer.borderColor = UIColor(named: "TabBarActiveColor")?.cgColor
        purchaseButton.clipsToBounds = true
        purchaseButton.addTarget(self,
                             action: #selector(purchaseButtonAction),
                             for: .touchUpInside)
        return purchaseButton
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubviews([ImageView,
                     dishLabel,
                     descriptionLabel,
                     purchaseButton])
        installingСonstraints()
    }

    func setupSell(dish: Dish, image: UIImage) {
        ImageView.image = image
        dishLabel.text = dish.name
        descriptionLabel.text = dish.description
        purchaseButton.setTitle("от \(dish.price) р", for: .normal)
    }

}

extension DishCollectionViewCell {

    private func installingСonstraints() {
        NSLayoutConstraint.activate([
            ImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            ImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            ImageView.heightAnchor.constraint(equalToConstant: 132),
            ImageView.widthAnchor.constraint(equalToConstant: 132),
            dishLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            dishLabel.leadingAnchor.constraint(equalTo: ImageView.trailingAnchor, constant: 32),
            descriptionLabel.topAnchor.constraint(equalTo: dishLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: ImageView.trailingAnchor, constant: 32),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            purchaseButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            purchaseButton.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            purchaseButton.heightAnchor.constraint(equalToConstant: 32),
            purchaseButton.widthAnchor.constraint(equalToConstant: 87)])
    }

    @objc private func purchaseButtonAction() {
        print("Add to cart")
    }
}
