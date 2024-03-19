//
//  Procedure.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/17/24.
//

import Foundation
import Realm
import RealmSwift

class Procedure: Object {
    @objc dynamic var stepDetail: String = ""
    @objc dynamic var stepNumber: Int = 0
    var parentRecipe = LinkingObjects(fromType: Recipes.self, property: "procedure")
}
