//
//  IngredientTableViewCell.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/14/24.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientImage: UIImageView!
    @IBOutlet weak var ingredientName: UILabel!
    @IBOutlet weak var ingredentWeight: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with ingredientItem: (String, String, String)) {
        let (name, imageURLString, weight) = ingredientItem
        ingredientName.text = name
        ingredentWeight.text = weight
        if let imageURL = URL(string: imageURLString) {
            ingredientImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "Recipe's Image"))
        }
    }
}
