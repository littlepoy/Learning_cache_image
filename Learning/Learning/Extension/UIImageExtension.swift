//
//  UIImageExtension.swift
//  Learning
//
//  Created by LivingMobile on 13/1/2563 BE.
//  Copyright © 2563 LivingMobile. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func getImageFromWeb(imageUrlString: String?) {
        if let imageUrlString = imageUrlString {
            let imageCache = NSCache<NSString, AnyObject>()
            let url: URL?
            
            if imageUrlString.hasPrefix("https://") || imageUrlString.hasPrefix("http://") {
                url = URL(string: imageUrlString)
            } else {
                url = URL(string: "https://" + imageUrlString)
            }
            
            guard let _url = url else {
                return
            }
            
            if let cachedImage = imageCache.object(forKey: imageUrlString as NSString) as? UIImage {
                self.image = cachedImage
            } else {
                URLSession.shared.dataTask(with: _url) { (data, response, error) in
                    guard error == nil else {
                        print("Error: \(String(describing: error))")
                        return
                    }
                    guard response != nil else {
                        print("no response")
                        return
                    }
                    guard let data = data else {
                        print("no data")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        let imageToCache = UIImage(data: data)
                        imageCache.setObject(imageToCache!, forKey: imageUrlString as NSString)
                        self.image = imageToCache
                    }
                }.resume()
            }
        }
    }
}
