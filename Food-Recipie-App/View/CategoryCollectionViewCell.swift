//
//  CategoryCollectionViewCell.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/13/24.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryButton: UIButton!
    weak var delegate: CategoryCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func categoryBtnPressed(_ sender: UIButton) {
        guard let origin = sender.currentTitle else {
           return
       }
        delegate?.categoryButtonPressed(withOrigin: origin)
    }
    
    func configure(with origin: String) {
        categoryButton.setTitle(origin, for: .normal)
    }
}
