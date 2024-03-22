//
//  RecipeCollectionViewCellViewModel.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/22/24.
//

import Foundation
class RecipeCollectionViewCellViewModel {
    var recipe: [Recipes] = []
    var ingredient: [Ingredient] = []
    var procedures: [Procedure] = []
    
    var creator: String = ""
    var publishedDate: String = ""
    var ingredients: [String: [String: String]] = [:]
    var category = ""
    var procedure: [[String: Any]] = []
    var rating: Int = 0
    var origin = ""
    var creatorImage: String = ""
    var recipeImage: String = ""
    var status: Bool = false
    
    func saveRecipes(recipe: Recipes) {
        RealmManager.shared.saveRecipe(recipe)
    }
    
    func updateRecipeStatus(withName recipeName: String) {
        DatabaseManager.shared.updateRecipeStatus(withName: recipeName)
    }
    
}
