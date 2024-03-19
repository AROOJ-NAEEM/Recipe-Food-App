//
//  ProcedureTableViewCell.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/14/24.
//

import UIKit

class ProcedureTableViewCell: UITableViewCell {

    @IBOutlet weak var stepNumber: UILabel!
    @IBOutlet weak var stepDetail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
