//
//  TableCell.swift
//  webexpensesSwift
//
//  Created by Sakthi on 28/11/14.
//  Copyright (c) 2014 Twelve77. All rights reserved.
//

import Foundation
import UIKit

@objc protocol ICustomCellDelegate{
    @objc  func tableView(_ sender:UIButton,selectedRow : Int)
    @objc  optional func tableView(_ sender:UIButton,indexPath : IndexPath )
     @objc optional func tableViewObject(_ sender:AnyObject,selectedRow : Int)
    @objc optional func tableView(_ sender:UIButton,selectedRow : Int,value : Bool)
}
