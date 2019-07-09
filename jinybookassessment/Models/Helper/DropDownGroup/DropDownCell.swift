//
//  DropDownCell.swift
//  webexpensesSwift
//
//  Created by Sakthi on 14/12/14.
//  Copyright (c) 2014 Twelve77. All rights reserved.
//

import UIKit

class DropDownCell: UITableViewCell {
    
    @IBOutlet var lblItemText: UILabel!
    @IBOutlet weak var lblLeftItemText: UILabel!
    
    @IBOutlet var imgItemIcon: UIImageView!
    @IBOutlet var imgIconleft: UIImageView!
    @IBOutlet weak var img_deleteInfo: UIImageView!
    @IBOutlet weak var imgItemIconHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgItemIconWidthConstraint: NSLayoutConstraint!
    
    var eventDelegate : ICustomCellDelegate!
    var RowID : Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblItemText.text = ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
        
    @IBAction func btnCellClick(_ sender: UIButton) {
        
        if(eventDelegate != nil)
        {
            eventDelegate.tableView(sender,selectedRow:RowID)
        }
        
    }
    
}
