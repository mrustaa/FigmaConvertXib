//
//  FigmaDataClearFolder.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 25.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension FigmaData {
    
    //MARK: 🏞⁉️ Check File Exists Path
    
    class func checkImageExists(imageName: String) -> Bool {
        
        let path = FigmaData.pathXibImages() + "/" + imageName + ".imageset" + "/" + imageName + ".png"
        
        let pathAndroid = pathXmlAndroidImages() + "/" + imageName + ".png"
        
        if  FileManager.default.fileExists(atPath: path),
            FileManager.default.fileExists(atPath: pathAndroid) {
            return true
        } else {
            return false
        }
    }
    
    
}
