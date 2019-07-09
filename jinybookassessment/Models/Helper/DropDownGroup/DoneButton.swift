//
//  DoneButton.swift
//  carbookPlus
//
//  Created by Manikandan on 16/02/16.
//  Copyright © 2016 Widas. All rights reserved.
//

import Foundation
import UIKit

open class DoneButton: UIButton {
    var selectedItem : DropDownEntity!
}

open class TargetButton: UIButton {
    open var selectedDate : Date!
    open var selectedItem : DropDownEntity!
}

open class DropDownEntity {
    var id : Double?
    var stringID : String?
    var name : String?
    var icon : String?
    var countrystrings : String?
    var lefticon : String?
    var leftItemtext : String?
    var isDeleted : Bool = false
    var userInfo:Any?
}
