//
//  BookListRouter.swift
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

@objc protocol BookListRoutingLogic
{
    func routerToBookDetailPage(bookId:String)
}

protocol BookListDataPassing
{
    var dataStore: BookListDataStore? { get }
}

class BookListRouter: NSObject, BookListRoutingLogic, BookListDataPassing
{
    weak var viewController: BookListViewController?
    var dataStore: BookListDataStore?
    
    // MARK: Routing
    
    func routerToBookDetailPage(bookId:String)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let bookDetailPage = storyboard.instantiateViewController(withIdentifier: "BookDetailsViewController") as! BookDetailsViewController
        bookDetailPage.bookId = bookId
        self.navigateToBookDetail(source: viewController!, destination: bookDetailPage)
    }
    
    // MARK: Navigating
    
    func navigateToBookDetail(source: BookListViewController, destination: BookDetailsViewController)
    {
        source.show(destination, sender: nil)
    }
    
}
