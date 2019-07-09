//
//  BookListRepo.swift
//  jinybookassessment
//
//  Created by Manikandan Tamilselvan on 09/07/19.
//  Copyright © 2019 widas. All rights reserved.
//

import Foundation

class BookListRepo: BookListInterface {
    
    func getAllBooks(callback: @escaping ([BookDetailsEntity], NSError?) -> ()) {
        
        var pathComponents = URLComponents()
        pathComponents.scheme = "http"
        pathComponents.host = "android.jiny.mockable.io"
        pathComponents.path = "/getAll"
        
        var request = URLRequest(url: pathComponents.url!)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request){data,response,error in
            guard let data = data else{
                callback([], error as NSError?)
                return
            }
            //            debugPrint("response data",data)
            do {
                if((response as! HTTPURLResponse).statusCode == 200) {
                    let decoder = JSONDecoder()
                    let decoderData = try decoder.decode(BookListEntity.self, from: data)
                    //                    print("decode Data",decoderData)
                    BookDetailRepo().bulkUpdateBookData(decoderData.list, context: nil, callback: { (res) in })
                    DispatchQueue.main.async {
                        callback(decoderData.list, nil)
                    }
                }else {
                    DispatchQueue.main.async {
                        callback([], error as NSError?)
                    }
                }
            }
            catch let err {
                print("catch error",err as NSError)
                DispatchQueue.main.async {
                    callback([], err as NSError)
                }
            }
        }
        dataTask.resume()
    }
}
