//
//  MenuView.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 13.01.2024.
//

import UIKit

final class MenuView: UIView {

    var mainModel: MenuModel?

    lazy var cityTabelView: UITableView = {
        let cityTabelView = UITableView()
        cityTabelView.dataSource = self
        cityTabelView.delegate = self
        cityTabelView.sectionHeaderTopPadding = 0.2
        cityTabelView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.id)
        cityTabelView.isHidden = true
        return cityTabelView
    }()

    lazy var bannersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 16
        let bannersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        bannersCollectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.id)
        bannersCollectionView.dataSource = self
        bannersCollectionView.delegate = self
        bannersCollectionView.showsHorizontalScrollIndicator = false
        bannersCollectionView.backgroundColor = .clear
        return bannersCollectionView
    }()

    lazy var categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        let categoriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        categoriesCollectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.id)
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.showsHorizontalScrollIndicator = false
        categoriesCollectionView.backgroundColor = .clear
        return categoriesCollectionView
    }()

    private lazy var cityButton: UIButton = {
        let cityButton = UIButton()
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
                     cityTabelView,
                     imageSelectCity,
                     bannersCollectionView,
                     categoriesCollectionView])
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
            self.cityTabelView.isHidden = true
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
            cityTabelView.topAnchor.constraint(equalTo: cityButton.bottomAnchor),
            cityTabelView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cityTabelView.heightAnchor.constraint(equalToConstant: 300),
            cityTabelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            bannersCollectionView.topAnchor.constraint(equalTo: cityButton.bottomAnchor, constant: 24),
            bannersCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bannersCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bannersCollectionView.heightAnchor.constraint(equalToConstant: 112),
            categoriesCollectionView.topAnchor.constraint(equalTo: bannersCollectionView.bottomAnchor, constant: 24),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}

extension MenuView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannersCollectionView {
            return mainModel?.bannersImageName.count ?? 0
        } else {
            return mainModel?.categorys.categories.count ?? 0
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannersCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.id, for: indexPath) as! BannerCollectionViewCell
            cell.setupCell(photo: mainModel?.bannersImageName[indexPath.item] ?? "")
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.id, for: indexPath) as! CategoriesCollectionViewCell
            let cellID = mainModel?.categorys.categories[indexPath.row].id
            let selectedID = mainModel?.selectedCategoryID
            let isActive = cellID == selectedID
            let name = mainModel?.categorys.categories[indexPath.row].name ?? ""
            cell.setupCell(categoryName: name,
                           isActive: isActive)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bannersCollectionView {
            return CGSize(width: 300, height: 112)
        } else {
            return CGSize(width: 88, height: 32)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == bannersCollectionView {
            print(mainModel?.bannersImageName[indexPath.row] ?? "")
        } else {
            let id = mainModel?.categorys.categories[indexPath.row].id ?? 0
            mainModel?.setupSelectedCategoryID(id)
            categoriesCollectionView.reloadData()
            print(mainModel?.categorys.categories[indexPath.row].name ?? "")
        }
    }
}

extension MenuView {

    @objc private func btnFolderPress() {
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.cityTabelView.isHidden.toggle()
            self.imageSelectCity.image = UIImage(systemName: "chevron.up")
        })
    }
}
