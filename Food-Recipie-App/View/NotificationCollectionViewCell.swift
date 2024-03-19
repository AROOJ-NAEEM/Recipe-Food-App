//
//  NotificationCollectionViewCell.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/19/24.
//

import UIKit

class NotificationCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var statusBtn: UIButton!
    @IBOutlet weak var notiTitile: UILabel!
    @IBOutlet weak var notiDiscription: UILabel!
    @IBOutlet weak var notiTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        borderView.layer.cornerRadius = 10
        borderView.layer.masksToBounds = true
    }
    func configure(isRead: Bool) {
        if isRead {
            statusBtn.backgroundColor = UIColor(named: "buttonColor")
            statusBtn.setImage(UIImage(systemName: "square.fill"), for: .normal)
        } else {
            statusBtn.setImage(UIImage(systemName: "app.badge.fill"), for: .normal)
            statusBtn.backgroundColor = .red

        }
        statusBtn.setBackgroundImage(nil, for: .selected)
        statusBtn.setBackgroundImage(nil, for: .highlighted)

        statusBtn.layer.cornerRadius = 10
        statusBtn.layer.masksToBounds = true

    }

}
