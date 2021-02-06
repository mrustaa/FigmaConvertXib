//
//  FigmaDataPathAndroid.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 25.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension FigmaData {
    
    // MARK: - Android Folders
    
    class func pathXmlAndroid(folder: String?) -> String {
        
        var replace = "/FigmaConvertAndroidXml"
        if let folder = folder {
            replace += ("/" + folder)
        }
        
         let pathFile2: String = #file
         let arrayFilesName2: [String] = #file.split(separator: "/").map({String($0)})
         
         var removePathArr: [String] = []
         
         var i = (arrayFilesName2.count - 1)
         
         for _ in 1...5 {
             removePathArr.append( arrayFilesName2[i] )
             i -= 1
         }
         
         var removePath: String = ""
         for name in removePathArr.reversed() {
             removePath += "/" + name
         }
         
         let resultPathFinal: String = pathFile2.findReplace(find: removePath, replace: replace)
         
         return resultPathFinal
         
    }
    
    class func pathXmlAndroidLayout() -> String {
        return pathXmlAndroid(folder: "app/src/main/res/layout")
    }
    
    class func pathXmlAndroidImages() -> String {
        
        // return pathXib(folder: "drawable")
        return pathXmlAndroid(folder: "app/src/main/res/drawable")
    }
    
    /// /Users/mrusta/Desktop/Figma/FigmaConvertXib/FigmaConvertAndroidXml/app/src/main/java/mrusta/FigmaConvertAndroidXml/ui/screen
    /// /Users/mrusta/Desktop/Figma/FigmaConvertXib/FigmaConvertXib/Figma/FigmaConvertAndroidXml/app/src/main/java/mrusta/FigmaConvertAndroidXml/ui/screen/
    
    class func pathXmlAndroidJavaUIScreen() -> String {
        return pathXmlAndroid(folder: "app/src/main/java/mrusta/FigmaConvertAndroidXml/ui/screen")
    }
    
    class func pathXmlAndroidJavaUICell() -> String {
        return pathXmlAndroid(folder: "app/src/main/java/mrusta/FigmaConvertAndroidXml/ui/cell")
    }
    
    
    
}
