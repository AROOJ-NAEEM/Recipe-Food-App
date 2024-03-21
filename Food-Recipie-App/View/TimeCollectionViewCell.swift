//
//  TimeCollectionViewCell.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/18/24.
//

// Todos
/*
- Auth state
- SDWebimage to load images in cells
- Tweak UI where ever is needed.
- Add loader while user is being loggin in.
*/
import UIKit

class TimeCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var timeLabel: UILabel!
    
    override var isSelected: Bool {
        didSet{
            toggleBackgroundColor()
            FilterManager.shared.filter.time = self.timeLabel.text ?? ""
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
