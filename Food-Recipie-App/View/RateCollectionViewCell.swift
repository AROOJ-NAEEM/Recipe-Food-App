//
//  RateCollectionViewCell.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/18/24.
//

import UIKit

class RateCollectionViewCell: UICollectionViewCell {
    
    var viewModel = RateCollectionViewModel()
    @IBOutlet private weak var rateLabel: UILabel!
    override var isSelected: Bool {
        didSet{
            toggleBackgroundColor()
            if let rateLabel = self.rateLabel.text {
                viewModel.setCategoryLabelValue(category: rateLabel)
            }
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
            rateLabel.textColor = .white
        }else {
            self.backgroundColor = .white
        }
    }
    
    func configureColor(label: String) {
        self.rateLabel.text = label
    }

}
