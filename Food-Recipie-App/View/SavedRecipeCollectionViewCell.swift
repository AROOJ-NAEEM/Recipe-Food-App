//
//  SavedRecipeCollectionViewCell.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/18/24.
//

import UIKit

class SavedRecipeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var recipeRating: UILabel!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var creatorName: UILabel!
    @IBOutlet weak var timeToCook: UILabel!
    @IBOutlet weak var savedButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        background.layer.cornerRadius = background.frame.size.height / 5
        
        rateView.layer.cornerRadius = rateView.frame.size.height / 2
        rateView.layer.masksToBounds = true

    
    }
    
    func configure(with recipe: Recipes) {
        recipeName.text = recipe.name
        creatorName.text = "By \(recipe.creator )"
        timeToCook.text = "⏱ \(recipe.requiredTime )"
        recipeRating.text = "\(recipe.rating )"
        if let imageUrl = URL(string: recipe.image ) {
            print("Loading image from \(imageUrl)")
            recipeImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "Recipe's Image"))
    
        } else {
            print("Invalid image URL")
        }
    }

}
