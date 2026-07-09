//
//  RealmManager.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/22/24.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    let realm = try! Realm()

    func saveRecipe(_ recipe: Recipes) {
        do {
            try realm.write {
                realm.add(recipe)
            }
        } catch {
            print("Error saving recipe, \(error)")
        }
    }
}
