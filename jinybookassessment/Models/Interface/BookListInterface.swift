//
//  BookListInterface.swift
//  jinybookassessment
//
//  Created by Manikandan Tamilselvan on 08/07/19.
//  Copyright © 2019 widas. All rights reserved.
//

import Foundation

protocol BookListInterface {
    func getAllBooks(callback: @escaping ([BookDetailsEntity], NSError?) -> ())
}
