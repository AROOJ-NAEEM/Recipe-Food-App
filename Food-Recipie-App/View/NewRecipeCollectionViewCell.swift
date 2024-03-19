//
//  NewRecipeCollectionViewCell.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/12/24.
//

import UIKit

class NewRecipeCollectionViewCell: UICollectionViewCell {

    //var noOfstar: Int = 0
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
    func cofigureRating(noOfStar: Int) {
        let stars = String(repeating: "⭐️", count: noOfStar)
        recipeRating.text = stars
    }

}
