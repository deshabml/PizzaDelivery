//
//  CityTableViewCell.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 13.01.2024.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    static let id = "PostTableViewCell"

    private lazy var cityLabel: UILabel = {
        cityLabel = UILabel()
        cityLabel.text = ""
        cityLabel.font =  UIFont.systemFont(ofSize: 17)
        return cityLabel
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubviews([cityLabel])
        installingСonstraints()
    }

    func setupSell(text: String) {
        cityLabel.text = text
    }

}

extension CityTableViewCell {

    private func installingСonstraints() {
        NSLayoutConstraint.activate([
            cityLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor)])
    }
}
