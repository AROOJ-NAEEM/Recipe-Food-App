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
    
    func convertRecipe(recipe: Recipes) -> [String: Any] {
        var ingredients: [String: [String: String]] = [:]
             for ingredient in recipe.ingredients {
                 ingredients[ingredient.name] = [
                     ingredient.image: ingredient.quantity
                 ]
        }

        var procedure: [[String: Any]] = []
            for step in recipe.procedure {
                procedure.append([
                    "stepNumber": step.stepNumber,
                    "stepDetail": step.stepDetail
                ])
            }
        
        let recipeData: [String: Any] = [
            "name": recipe.name,
            "image": recipe.image,
            "requiredTime": recipe.requiredTime,
            "creator": recipe.creator,
            "publishedDate": recipe.publishedDate,
            "ingredients": ingredients,
            "category": recipe.category,
            "procedure": procedure,
            "rating": recipe.rating,
            "origin": recipe.origin,
            "creatorImage": recipe.creatorImage,
            "status": true
        ]
        return recipeData
    }
}
