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
    
    class func saveImageAndroid(image: UIImage, name: String) {
        
        let filterName = name.xmlFilter()
        
        let path = pathXmlAndroidImages()
        
        guard let localURL = URL(string: path) else { return }
        let filterPath = localURL.absoluteString
        
        
        if FileManager.default.fileExists(atPath: filterPath) {
            FigmaData.save(image: image, path: filterPath, name: filterName)
            
        } else {
            if let createdFolderPath = createFolder(path: path, name: "") {
                FigmaData.save(image: image, path: createdFolderPath, name: filterName)
            }
        }
    }
    
}
