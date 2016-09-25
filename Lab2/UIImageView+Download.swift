//
//  UIImageView+Download.swift
//  Lab2
//
//  Created by Doni Ramadhan on 25/09/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

extension UIImageView {
    func getImage(id: String, link: String, completion: (image: UIImage) -> Void){
        if let image = UIImage(id: id){
            // retrieved locally
            completion(image: image)
        } else {
            downloadedFrom(link, id: id, completion: completion)
        }
    }
    
    
    private func downloadedFrom(link: String, id: String, completion: (image: UIImage) -> Void) {
        guard let url = NSURL(string: link) else {return}
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            guard
                let httpURLResponse = response as? NSHTTPURLResponse where httpURLResponse.statusCode == 200,
                let mimeType = response?.MIMEType where mimeType.hasPrefix("image"),
                let data = data where error == nil,
                let image = UIImage(data: data)
                else { return }
            image.saveImage(id)
            completion(image: image)
            }.resume()
    }
}
