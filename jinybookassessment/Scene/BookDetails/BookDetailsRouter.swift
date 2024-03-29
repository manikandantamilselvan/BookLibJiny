//
//  BookDetailsRouter.swift
//  jinybookassessment
//
//  Created by Manikandan Tamilselvan on 08/07/19.
//  Copyright (c) 2019 widas. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol BookDetailsRoutingLogic
{
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol BookDetailsDataPassing
{
    var dataStore: BookDetailsDataStore? { get }
}

class BookDetailsRouter: NSObject, BookDetailsRoutingLogic, BookDetailsDataPassing
{
    weak var viewController: BookDetailsViewController?
    var dataStore: BookDetailsDataStore?
    
}
