//
//  FilterCategoryCollectionViewCell.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/18/24.
//

import UIKit

class FilterCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if let buttonColor = UIColor(named: "buttonColor") {
            categoryButton.layer.borderWidth = 1.0
            categoryButton.layer.cornerRadius = 8.0
            categoryButton.layer.borderColor = buttonColor.cgColor
        } else {
            print("Error: Unable to retrieve color named 'buttonColor'")
        }
    }

    @IBAction func ctegoryBtnPressed(_ sender: UIButton) {
        //sender.backgroundColor = sender.backgroundColor == UIColor(named: "buttonColor") ? .white : UIColor(named: "buttonColor")
        UIView.animate(withDuration: 0.5) {
            sender.backgroundColor = UIColor(named: "buttonColor")
            sender.tintColor = .white
        }
        FilterManager.shared.filter.category = sender.currentTitle ?? ""
    }
   
}
