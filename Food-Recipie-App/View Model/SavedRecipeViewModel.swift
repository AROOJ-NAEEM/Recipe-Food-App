//
//  SavedRecipeViewModel.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/22/24.
//

import Foundation
import RealmSwift

class SavedRecipeViewModel {
    func fetchRecipes(completion: @escaping (Results<Recipes>?, (Error)?) -> Void) {
        completion(RealmManager.shared.realm.objects(Recipes.self), nil)
    }
}
