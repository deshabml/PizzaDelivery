//
//  MenuView.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 13.01.2024.
//

import UIKit

class MenuView: UIView {

    var mainModel: MenuModel?

    lazy var cityTabeView: UITableView = {
        cityTabeView = UITableView()
        cityTabeView.dataSource = self
        cityTabeView.delegate = self
        cityTabeView.sectionHeaderTopPadding = 0.2
        cityTabeView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.id)
        cityTabeView.isHidden = true
        return cityTabeView
    }()

    private lazy var cityButton: UIButton = {
        cityButton = UIButton()
        cityButton.setTitle("", for: .normal)
        cityButton.setTitleColor(.black, for: .normal)
        cityButton.titleLabel?.font =  UIFont.systemFont(ofSize: 17)
        cityButton.contentHorizontalAlignment = .left
        cityButton.addTarget(self,
                             action: #selector(btnFolderPress),
                             for: .touchUpInside)
        return cityButton
    }()

    private lazy var imageSelectCity: UIImageView = {
        let imageSelectCity = UIImageView()
        imageSelectCity.image = UIImage(systemName: "chevron.down")
        imageSelectCity.tintColor = .black
        return imageSelectCity
    }()

    init() {
        super.init(frame: CGRect())
        backgroundColor = UIColor(named: "BackgraundColor")
        addSubviews([cityButton,
                     cityTabeView,
                     imageSelectCity])
        installingСonstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setContent(mainModel: MenuModel) {
        self.mainModel = mainModel
        cityButton.setTitle(mainModel.selectedCity, for: .normal)
    }
}

extension MenuView: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainModel?.cities.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.id, for: indexPath) as! CityTableViewCell
        cell.setupSell(text: mainModel?.cities[indexPath.row].name ?? "")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.cityTabeView.isHidden = true
            self.imageSelectCity.image = UIImage(systemName: "chevron.down")
        })
        mainModel?.setupSelectedCity(mainModel?.cities[indexPath.row].name ?? "")
        cityButton.setTitle(mainModel?.cities[indexPath.row].name, for: .normal)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }

}

extension MenuView {

    private func installingСonstraints() {
        NSLayoutConstraint.activate([
            cityButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            cityButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cityButton.heightAnchor.constraint(equalToConstant: 20),
            imageSelectCity.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageSelectCity.leadingAnchor.constraint(equalTo: cityButton.trailingAnchor, constant: 8),
            cityTabeView.topAnchor.constraint(equalTo: cityButton.bottomAnchor),
            cityTabeView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cityTabeView.heightAnchor.constraint(equalToConstant: 300),
            cityTabeView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)])
    }
}

extension MenuView {

    @objc private func btnFolderPress() {
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.cityTabeView.isHidden.toggle()
            self.imageSelectCity.image = UIImage(systemName: "chevron.up")
        })
    }
}
