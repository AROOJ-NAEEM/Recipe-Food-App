//
//  NewRecipeCollectionViewCell.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/12/24.
//

import UIKit

class NewRecipeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var recipeRating: UILabel!
    @IBOutlet weak var newRecipeCard: UIView!
    @IBOutlet weak var timeToCook: UILabel!
    @IBOutlet weak var creatorName: UILabel!
    @IBOutlet weak var creatorImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        newRecipeCard.layer.cornerRadius = newRecipeCard.frame.size.height / 5
        recipeImage.layer.cornerRadius = recipeImage.frame.size.width / 2
        recipeImage.clipsToBounds = true

        creatorImage.layer.cornerRadius = creatorImage.frame.size.width / 2

    }
    func configure(with recipe: Recipe) {
        let stars = String(repeating: "⭐️", count: recipe.rating)
        recipeRating.text = stars
        recipeImage.sd_setImage(with: URL(string: recipe.image), placeholderImage: UIImage(named: "Recipe's Image"))
        creatorImage.sd_setImage(with: URL(string: recipe.image), placeholderImage: UIImage(named: "Creator's Image"))
        recipeName.text = recipe.name
        timeToCook.text = "⏱ \(recipe.requiredTime)"
        creatorName.text = "By \(recipe.creator)"
    }

}
