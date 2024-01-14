//
//  Images.swift
//  PizzaDelivery
//
//  Created by Лаборатория on 15.01.2024.
//

import Foundation
import RealmSwift

final class Images: Object {

    @Persisted(primaryKey: true) var id: String?
    @Persisted var images: List<Data>

    convenience init(imagesList: List<Data>) {
        self.init()
        self.images = imagesList
    }

    convenience init(imagesArray: [Data]) {
        self.init()
        self.images.append(objectsIn: imagesArray)
    }
}
