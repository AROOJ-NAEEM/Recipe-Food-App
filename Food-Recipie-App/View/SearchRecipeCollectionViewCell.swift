//
//  SearchRecipeCollectionViewCell.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/15/24.
//

import UIKit

class SearchRecipeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var recipeRating: UILabel!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var creatorName: UILabel!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var gradient: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if let gradientConfigurationBounds = gradient?.bounds {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = gradientConfigurationBounds
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            gradientLayer.locations = [0.0, 1.0]
            recipeImage.layer.addSublayer(gradientLayer)
            
            rateView.layer.cornerRadius = rateView.frame.size.height / 2
            rateView.layer.masksToBounds = true
        } else {
            print("Gradient configuration is nil or its bounds are nil.")
        }
    }

}
