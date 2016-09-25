//
//  UIImage+Store.swift
//  Lab2
//
//  Created by Doni Ramadhan on 25/09/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

extension UIImage{
    func saveImage(id: String){
        // Create path.
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        guard let firstPath = paths.first else {return}
        let filePath = "\(firstPath)/\(id).png"
        
        // Save image.
        UIImagePNGRepresentation(self)?.writeToFile(filePath, atomically: true)
    }
    
    convenience init?(id: String) {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        guard let firstPath = paths.first else {return nil}
        let filePath = "\(firstPath)/\(id).png"
        
        self.init(contentsOfFile: filePath)
    }
}
