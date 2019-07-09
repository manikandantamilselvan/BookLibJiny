//
//  BookDetail+CoreDataClass.swift
//  jinybookassessment
//
//  Created by Manikandan Tamilselvan on 09/07/19.
//  Copyright © 2019 widas. All rights reserved.
//
//

import Foundation
import CoreData

@objc(BookDetail)
public class BookDetail: NSManagedObject {
    class func newInstance(_ context:NSManagedObjectContext) -> BookDetail {
        return NSEntityDescription.insertNewObject(forEntityName: "BookDetail", into: context) as! BookDetail
    }
}
