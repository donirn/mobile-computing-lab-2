//
//  UIImageView+Download.swift
//  Lab2
//
//  Created by Doni Ramadhan on 25/09/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

extension UIImageView {
    func getImage(id: String, link: String){
        if let image = UIImage(id: id){
            // retrieved locally
            dispatch_async(dispatch_get_main_queue(), {
                self.image = image
            })
        } else {
            downloadedFrom(link, id: id)
        }
    }
    
    
    private func downloadedFrom(link: String, id: String) {
        guard let url = NSURL(string: link) else {return}
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            guard
                let httpURLResponse = response as? NSHTTPURLResponse where httpURLResponse.statusCode == 200,
                let mimeType = response?.MIMEType where mimeType.hasPrefix("image"),
                let data = data where error == nil,
                let image = UIImage(data: data)
                else { return }
            image.saveImage(id)
            dispatch_async(dispatch_get_main_queue(), {
                self.image = image
            })
            }.resume()
    }
}
