//
//  UIImageView+loadImage.swift
//  BambuserTest
//
//  Created by test on 22/01/2024.
//

import UIKit

// TODO: Needs fixing and enhancement
extension UIImageView {
    
    static let imageCache: NSCache = NSCache<AnyObject, UIImage>()
    
    func setImage(url: String) {
        
        if let cachedImage = Self.imageCache.object(forKey: url as AnyObject) {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
            return
        }
        
        DispatchQueue.global().async {
            if let imageUrl = URL(string: url), let data = try? Data(contentsOf: imageUrl), let image = UIImage(data: data) {
                Self.imageCache.setObject(image, forKey: url as AnyObject)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
        
    }
    
}
