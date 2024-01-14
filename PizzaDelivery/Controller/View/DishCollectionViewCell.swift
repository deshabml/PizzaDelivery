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

//    private lazy var cityLabel: UILabel = {
//        let cityLabel = UILabel()
//        cityLabel.text = ""
//        cityLabel.font =  UIFont.systemFont(ofSize: 17)
//        return cityLabel
//    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubviews([ImageView])
        installingСonstraints()
    }

    func setupSell(dish: Dish, image: UIImage) {
        ImageView.image = image
    }

}

extension DishCollectionViewCell {

    private func installingСonstraints() {
        NSLayoutConstraint.activate([
            ImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            ImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            ImageView.heightAnchor.constraint(equalToConstant: 132),
            ImageView.widthAnchor.constraint(equalToConstant: 132)])
    }
}
