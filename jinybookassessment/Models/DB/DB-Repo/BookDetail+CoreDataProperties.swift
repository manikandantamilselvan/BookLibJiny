//
//  BookDetail+CoreDataProperties.swift
//  jinybookassessment
//
//  Created by Manikandan Tamilselvan on 09/07/19.
//  Copyright © 2019 widas. All rights reserved.
//
//

import Foundation
import CoreData


extension BookDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookDetail> {
        return NSFetchRequest<BookDetail>(entityName: "BookDetail")
    }

    @NSManaged public var id: String?
    @NSManaged public var book_title: String?
    @NSManaged public var author_name: String?
    @NSManaged public var genre: String?
    @NSManaged public var publisher: String?
    @NSManaged public var author_country: String?
    @NSManaged public var sold_count: Int64
    @NSManaged public var image_url: String?
    
    // MARK: Convert Attributes
    
    func setAttributesFrom(entity : BookDetailsEntity,with context:NSManagedObjectContext) {
        
        self.book_title = entity.book_title
        self.author_country = entity.author_country
        self.author_name = entity.author_name
        self.genre = entity.genre
        self.id = entity.id
        self.publisher = entity.publisher
        self.image_url = entity.image_url
        self.sold_count = entity.sold_count
    }

}
