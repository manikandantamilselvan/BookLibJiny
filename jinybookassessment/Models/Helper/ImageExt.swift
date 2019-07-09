//
//  ImageExt.swift
//  jinybookassessment
//
//  Created by Manikandan Tamilselvan on 09/07/19.
//  Copyright © 2019 widas. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func cacheImage(urlString: String){
        let url = URL(string: urlString)
        
        if urlString.count > 0 {
            image = nil
            
            if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
                self.image = imageFromCache
                return
            }
            
            URLSession.shared.dataTask(with: url!) {
                data, response, error in
                if let response = data {
                    DispatchQueue.main.async {
                        let imageToCache = UIImage(data: response)
                        imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                        DispatchQueue.main.async {
                            self.image = imageToCache
                        }
                    }
                }
                }.resume()
        }else {
            DispatchQueue.main.async {
                self.image = #imageLiteral(resourceName: "cover")
            }
        }
    }
}
