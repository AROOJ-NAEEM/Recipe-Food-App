//
//  RateCollectionViewCell.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/18/24.
//

import UIKit

class RateCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var rateButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if let buttonColor = UIColor(named: "buttonColor") {
            rateButton.layer.borderWidth = 1.0
            rateButton.layer.cornerRadius = 8.0
            rateButton.layer.borderColor = buttonColor.cgColor
        } else {
            print("Error: Unable to retrieve color named 'buttonColor'")
        }
    }

    @IBAction func rateBtnPressed(_ sender: UIButton) {
        FilterManager.shared.filter.rate = sender.currentTitle ?? ""
        UIView.animate(withDuration: 0.5) {
            sender.backgroundColor = UIColor(named: "buttonColor")
            sender.tintColor = .white
        }
    }
}
