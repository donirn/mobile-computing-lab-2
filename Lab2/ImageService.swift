//
//  ImageService.swift
//  Lab2
//
//  Created by Doni Ramadhan on 25/09/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class ImageService {
    static let shared = ImageService()
    private init(){}
    
    func getImage(id: String, link: String, completion: (image: UIImage) -> Void){
        if let image = loadImage(id){
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
            self.saveImage(image, id: id)
            completion(image: image)
            }.resume()
    }
    
    private func saveImage(image: UIImage, id: String){
        // Create path.
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        guard let firstPath = paths.first else {return}
        let filePath = "\(firstPath)/\(id).png"
        
        // Save image.
        UIImagePNGRepresentation(image)?.writeToFile(filePath, atomically: true)
    }
    
    private func loadImage(id: String) -> UIImage?{
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        guard let firstPath = paths.first else {return nil}
        let filePath = "\(firstPath)/\(id).png"
        
        return UIImage(contentsOfFile: filePath)
    }
}
