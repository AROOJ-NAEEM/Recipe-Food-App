//
//  Recipes.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/17/24.
//

import Foundation
import RealmSwift

class Recipes: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var requiredTime: String = ""
    @objc dynamic var creator: String = ""
    @objc dynamic var publishedDate: String = ""
    let ingredients = List<Ingredient>()
    @objc dynamic var category: Category.RawValue = ""
    let procedure = List<Procedure>()
    @objc dynamic var rating: Int = 0
    @objc dynamic var origin: Origin.RawValue = ""
    @objc dynamic var creatorImage: String = ""
}
