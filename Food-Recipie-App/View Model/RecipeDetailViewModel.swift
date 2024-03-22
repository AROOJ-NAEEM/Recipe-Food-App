//
//  RecipeDetailViewModel.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/15/24.
//

import Foundation

class RecipeDetailViewModel {
    var img: URL?
    var name = ""
    var time = ""
    var count = 0
    var ingredient: [String: [String: String]]?
    var procedure: [[String: Any]]?
    
    func configure(with recipe: Recipe) {
        name = recipe.name
        if let imageUrl = URL(string: recipe.image) {
            print("Loading image from \(imageUrl)")
           img = imageUrl
        } else {
            print("Invalid image URL")
        }
        time = recipe.requiredTime
        count = recipe.ingredients.count
        ingredient = recipe.ingredients
        procedure = recipe.procedure
    }
}
