//
//  BookDetailRepo.swift
//  jinybookassessment
//
//  Created by Manikandan Tamilselvan on 09/07/19.
//  Copyright © 2019 widas. All rights reserved.
//

import Foundation
import CoreData

class BookDetailRepo {
    
    open func createOrUpdateBookData(_ bookDetail:BookDetailsEntity, context:NSManagedObjectContext?, callback:@escaping (Bool)->()) {
        
        let tempContext:NSManagedObjectContext?
        if context != nil{
            tempContext = context
        }else{
            tempContext = CoreDataManager.shared.temporaryWorkerContext()
        }
        
        let newInstance = BookDetail.newInstance(tempContext!)
        
        tempContext?.perform({
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookDetail")
            let predicate = NSPredicate(format: "id == %@",bookDetail.id)
            fetchRequest.predicate = predicate
            fetchRequest.fetchLimit = 1
            if let fetchResults = (try? tempContext!.fetch(fetchRequest)) as? [BookDetail] {
                if(fetchResults.count > 0){
                    if let v = fetchResults.first{
                        v.setAttributesFrom(entity: bookDetail, with: tempContext!)
                    }
                }else {
                    newInstance.setAttributesFrom(entity: bookDetail, with: tempContext!)
                }
            }
            CoreDataManager.shared.saveTempContext(tempContext!)
            callback(true)
        })
    }
    
    open func bulkUpdateBookData(_  bookDetail:[BookDetailsEntity], context:NSManagedObjectContext?,callback:@escaping (Bool)->()) {
        
        var taskFinishedCount = 0
        
        autoreleasepool(invoking: {
            
            for (_, book) in bookDetail.enumerated() {
                
                taskFinishedCount += 1
                self.createOrUpdateBookData(book, context: CoreDataManager.shared.temporaryWorkerContext(), callback: { (res) in })
                if taskFinishedCount == bookDetail.count {
                    DispatchQueue.main.async {
                        callback(true)
                    }
                }
            }
        })
    }
    
    open func fetchBookList(_ type:FilterType.RawValue = FilterType.author.rawValue, query: String, callback:@escaping ([BookDetailsEntity])->()) {
        
        let context = CoreDataManager.shared.temporaryWorkerContext()
        
        context.performAndWait {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"BookDetail")
            
            var predicate = NSPredicate(format: "author_name == %@",query)
            if type == FilterType.country.rawValue {
                predicate = NSPredicate(format: "author_country == %@",query)
            }else if type == FilterType.genre.rawValue {
                predicate = NSPredicate(format: "genre == %@",query)
            }
            fetchRequest.predicate = predicate
            
            do {
                if let fetchResults = (try? context.fetch(fetchRequest)) as? [BookDetail] {
                    if fetchResults.count > 0 {
                        callback(fetchResults.map({self.convertAttributes(entity: $0)}))
                    }else {
                        callback([])
                    }
                }
            }
        }
    }
    
    open func fetchBookDetailBy(_ id:String, callback:@escaping (BookDetailsEntity?)->()) {
        
        let context = CoreDataManager.shared.temporaryWorkerContext()
        
        context.performAndWait {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"BookDetail")
            let predicate = NSPredicate(format: "id == %@",id)
            fetchRequest.predicate = predicate
            
            do {
                if let fetchResults = (try? context.fetch(fetchRequest)) as? [BookDetail] {
                    if fetchResults.count > 0 {
                        callback(self.convertAttributes(entity: fetchResults.first!))
                    }else {
                        callback(nil)
                    }
                }
            }
        }
    }
    
    private func convertAttributes(entity:BookDetail) -> BookDetailsEntity {
        var bookEntity = BookDetailsEntity()
        bookEntity.author_country = entity.author_country ?? ""
        bookEntity.author_name = entity.author_name ?? ""
        bookEntity.book_title = entity.book_title ?? ""
        bookEntity.genre = entity.genre ?? ""
        bookEntity.id = entity.id ?? ""
        bookEntity.image_url = entity.image_url ?? ""
        bookEntity.publisher = entity.publisher ?? ""
        bookEntity.sold_count = entity.sold_count
        return bookEntity
    }
}
