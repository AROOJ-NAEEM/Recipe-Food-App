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
    
}
