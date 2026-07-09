//
//  RecipeDetailViewModel.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/15/24.
//

import Foundation

class RecipeDetailViewModel {
    private var recipe: Recipe?
        
    func configure(with recipe: Recipe) {
        self.recipe = recipe
    }
    
    var img: URL? {
        guard let recipe = recipe else { return nil }
        return URL(string: recipe.image)
    }
    
    var name: String {
        return recipe?.name ?? ""
    }
    
    var time: String {
        return recipe?.requiredTime ?? ""
    }
    
    var count: Int {
        return recipe?.ingredients.count ?? 0
    }
    
    var ingredient: [String: [String: String]]? {
        return recipe?.ingredients
    }
    
    var procedure: [[String: Any]]? {
        return recipe?.procedure
    }
    
    func ingredientItem(at index: Int) -> (String, String, String)? {
        guard let ingredient = recipe?.ingredients else { return nil }
        let ingredientKeys = Array(ingredient.keys)
        let ingredientValues = Array(ingredient.values)
        
        guard index < ingredientKeys.count else { return nil }
        
        let ingredientName = ingredientKeys[index]
        let ingredientDetail = ingredientValues[index]
        
        if let imageURLString = ingredientDetail.keys.first,
           let weight = ingredientDetail.values.first {
            return (ingredientName, imageURLString, weight)
        }
        
        return nil
    }
    
    func procedureItem(at index: Int) -> (Int, String)? {
        guard let procedure = recipe?.procedure else { return nil }
        let sortedProcedure = procedure.sorted { ($0["stepNumber"] as? Int ?? 0) < ($1["stepNumber"] as? Int ?? 0) }
        
        guard index < sortedProcedure.count else { return nil }
        
        let step = sortedProcedure[index]
        if let stepNumber = step["stepNumber"] as? Int, let stepDetail = step["stepDetail"] as? String {
            return (stepNumber, stepDetail)
        }
        
        return nil
    }
}
