//
//  TimeCollectionViewCell.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/18/24.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var timeButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if let buttonColor = UIColor(named: "buttonColor") {
            timeButton.layer.borderWidth = 1.0
            timeButton.layer.cornerRadius = 8.0
            timeButton.layer.borderColor = buttonColor.cgColor
        } else {
            print("border not set")
        }
    }

    @IBAction func timeBtnPressed(_ sender: UIButton) {
        FilterManager.shared.filter.time = sender.currentTitle ?? ""
        UIView.animate(withDuration: 0.5) {
            sender.backgroundColor = UIColor(named: "buttonColor")
            sender.tintColor = .white
        }
    }
}
