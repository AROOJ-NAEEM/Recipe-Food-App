//
//  Ingredient.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/17/24.
//

import Foundation
import RealmSwift

class Ingredient: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var quantity: String = ""
    var parentRecipe = LinkingObjects(fromType: Recipes.self, property: "ingredients")
}
