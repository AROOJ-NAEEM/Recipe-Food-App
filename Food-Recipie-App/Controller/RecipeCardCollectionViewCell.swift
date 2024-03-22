//
//  RecipeCardCollectionViewCell.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/11/24.
//

import UIKit

class RecipeCardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var timeRequiredToCook: UILabel!
    @IBOutlet weak var recipeName: UILabel!

    func configure(with recipe: Recipe) {
        recipeName.text = recipe.name
        timeRequiredToCook.text = "Time: \(recipe.requiredTime)"
         if let imageUrl = URL(string: recipe.image) {
             print("Loading image from \(imageUrl)")
             recipeImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "Recipe's Image"))
         
         } else {
             print("Invalid image URL")
         }
    }
}
