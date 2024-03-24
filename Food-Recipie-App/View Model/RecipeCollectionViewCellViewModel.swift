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
    
    func createNewRecipe(withName name: String, imageURL: String, requiredTime: String, creator: String, publishedDate: String, category: String, rating: Int, origin: String, creatorImage: String, ingredients: [String: [String: String]], procedures: [[String: Any]]) -> Recipes {
        let newRecipe = Recipes()
        let newIngredient = Ingredient()
        let newProcedure = Procedure()
        newRecipe.name = name
        newRecipe.image = imageURL
        newRecipe.requiredTime = requiredTime
        newRecipe.creator = creator
        newRecipe.publishedDate = publishedDate
        newRecipe.category = category
        newRecipe.rating = rating
        newRecipe.origin = origin
        newRecipe.creatorImage = creatorImage
        for (ingredientName, _) in ingredients {
            let newIngredient = Ingredient()
            newIngredient.name = ingredientName

            if let ingredientData = ingredients[ingredientName] {
                for (ingredientImage, ingredientQuantity) in ingredientData {
                    newIngredient.image = ingredientImage
                    newIngredient.quantity = ingredientQuantity
                }
            }
            ingredient.append(newIngredient)
        }
        newRecipe.ingredients.append(objectsIn: ingredient)

        for stepDict in procedure {
            let newProcedure = Procedure()
            if let stepDetail = stepDict["stepDetail"] as? String,
               let stepNumber = stepDict["stepNumber"] as? Int {
                newProcedure.stepDetail = stepDetail
                newProcedure.stepNumber = stepNumber
                newRecipe.procedure.append(newProcedure)
            }
        }
        recipe.append(newRecipe)
        ingredient.append(newIngredient)
        //procedures.append(newProcedure)

        return newRecipe
    }
        
}
