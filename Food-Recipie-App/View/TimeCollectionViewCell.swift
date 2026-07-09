//
//  TimeCollectionViewCell.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/18/24.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {
    var viewModel = TimeCollectionViewModel()
    @IBOutlet private weak var timeLabel: UILabel!
    
    override var isSelected: Bool {
        didSet{
            toggleBackgroundColor()
            if let timeLabel = self.timeLabel.text {
                viewModel.storeTimeLabelVlaue(timeLabel: timeLabel)
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
            print("border not set")
        }
    }
    
    private func toggleBackgroundColor() {
        if isSelected {
            self.backgroundColor = UIColor(named: "buttonColor")
            timeLabel.textColor = .white
        }else {
            self.backgroundColor = .white
        }
    }
    
    func configure(title: String) {
        self.timeLabel.text = title
    }
}
