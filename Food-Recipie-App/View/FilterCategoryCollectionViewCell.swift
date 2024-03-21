//
//  FilterCategoryCollectionViewCell.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/18/24.
//

import UIKit

class FilterCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    override var isSelected: Bool {
        didSet{
            toggleBackgroundColor()
            FilterManager.shared.filter.category = self.categoryLabel.text ?? ""
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if let buttonColor = UIColor(named: "buttonColor") {
            self.layer.borderWidth = 1.0
            self.layer.cornerRadius = 8.0
            self.layer.borderColor = buttonColor.cgColor
        } else {
            print("Error: Unable to retrieve color named 'buttonColor'")
        }
    }
    private func toggleBackgroundColor() {
        if isSelected {
            self.backgroundColor = UIColor(named: "buttonColor")
            categoryLabel.textColor = .white
        }else {
            self.backgroundColor = .white
        }
    }
    
    func configureColor(label: String) {
        self.categoryLabel.text = label
    }
   
}
