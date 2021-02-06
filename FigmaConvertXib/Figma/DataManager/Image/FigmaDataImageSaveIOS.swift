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
    
    class func saveImageXcassets(image: UIImage, name: String) {
        
        let path = pathXibImages()
        let name_ = name + ".imageset"
        
        guard let localURL = URL(string: path) else { return }
        let dataPath = localURL.appendingPathComponent(name_)
        let filterPath = dataPath.absoluteString
        
        let path_ = path + "/" + name_
        
        if FileManager.default.fileExists(atPath: filterPath) {
            
            FigmaData.createImageJsonFile(path: filterPath, path_: path_, name: name)
            FigmaData.save(image: image, path: filterPath, name: name)
            
        } else {
            if let createdFolderPath = createFolder(path: path, name: name_) {
                
                FigmaData.createImageJsonFile(path: createdFolderPath, path_: path_, name: name)
                FigmaData.save(image: image, path: createdFolderPath, name: name)
            }
        }
    }
    
    
    //MARK: - 💾📄 Save Local .json
    
    class func createImageJsonFile(path: String, path_: String, name: String) {
        
        let text = """
        {
          "images" : [
            {
              "filename" : "\(name).png",
              "idiom" : "universal",
              "scale" : "1x"
            },
            {
              "idiom" : "universal",
              "scale" : "2x"
            },
            {
              "idiom" : "universal",
              "scale" : "3x"
            }
          ],
          "info" : {
            "author" : "xcode",
            "version" : 1
          }
        }
        """
        
        FigmaData.save(text: text,
                       toDirectory: path,
                       path_: path_ + "/Contents.json",
                       withFileName: "Contents.json")
        
    }
    
    //MARK: 🏞💾 Image Save Local
    
    class func save(image: UIImage, path: String? = nil, name: String) {
        
        guard let data = image.pngData() else { return }
        
        let p = FigmaData.pathXibImages()
        var a = "file://\(p)/"
        
        if let path = path {
            a = "file://\(path)/"
        }
        
        guard let urlPathA = URL(string: a) else { return }
        let urlPath = urlPathA.appendingPathComponent("\(name).png")
        
        do {
            try data.write(to: urlPath)
            print(" 🏞 \(urlPath.absoluteString)")
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
