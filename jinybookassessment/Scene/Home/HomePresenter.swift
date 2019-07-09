//
//  HomePresenter.swift
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

protocol HomePresentationLogic
{
    func presentBookListToUI(res:[BookDetailsEntity])
}

class HomePresenter: HomePresentationLogic
{
    weak var viewController: HomeDisplayLogic?
    
    // MARK: Display Books
    
    func presentBookListToUI(res: [BookDetailsEntity]) {
        res.count > 0 ? self.viewController?.showBooksData(viewModel: res) : self.viewController?.showFailureData()
    }
}
