//
//  titleViewCell.swift
//  jinybookassessment
//
//  Created by Manikandan Tamilselvan on 09/07/19.
//  Copyright © 2019 widas. All rights reserved.
//

import UIKit

class titleViewCell: UITableViewCell {

    // MARK: Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
