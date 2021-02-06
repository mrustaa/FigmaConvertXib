//
//  FigmaDataClearFolder.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 25.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation
import UIKit

extension FigmaData {
    
    //MARK: 🏞📤 Image Load Local
    
    class func load(imageName: String, path: String? = nil) -> UIImage? {
        
        let pat = pathXibImages()
        let name_ = imageName + ".imageset"
        guard let localURL = URL(string: pat) else { return nil }
        let dataPath = localURL.appendingPathComponent(name_)
        let filterPath = dataPath.absoluteString
        
        let p = filterPath // FigmaData.pathXibImages()
        var a = "file://\(p)/"
        
        if let path = path {
            a = "file://\(path)/"
        }
        
        guard let url = URL(string: a) else { return nil }
        let urlPath = url.appendingPathComponent("\(imageName).png")
        
        do {
            let imageData = try Data(contentsOf: urlPath)
             print(" 📤 \(urlPath.absoluteString)")
            return UIImage(data: imageData)
            
        } catch {
            
        }
        return nil
    }
}
