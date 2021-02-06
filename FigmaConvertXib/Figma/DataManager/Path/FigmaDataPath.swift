//
//  FigmaDataManagerPath.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 25.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension FigmaData {
    
    //    public enum FigmaPathType: String {
    //        case imageXcassets = "images.xcassets"
    //        case imageAndroid = "drawable"
    //        case xib = "Xib"
    //    }
        
        
        //MARK: - 📁 Paths
        
    //    class func pathXib(type: FigmaPathType) -> String {
    //
    //        switch type {
    //        case .xib: return pathXib()
    //        case .imageXcassets: return pathXib(folder: type.rawValue)
    //        case .imageAndroid: return pathXib(folder: type.rawValue)
    //        }
    //    }
        
    
    class func pathXib(folder: String?) -> String {
                
        var replace = "Xib"
        if let folder = folder {
            replace += ("/" + folder)
        }

        let pathFile: String = #file
        let arrayFileNames: [String] = #file.split(separator: "/").map({String($0)})
        
        let last = (arrayFileNames.count - 1)
        let find = arrayFileNames[last - 2] + "/" + arrayFileNames[last - 1] + "/" + arrayFileNames[last]
        
        let resultPathFinal: String = pathFile.findReplace(find: find, replace: replace)
        
        // print( "\n" + pathFile + "\n" + find + "\n" + "\(arrayFileNames)" + "\n" + resultPathFinal )
        
        return resultPathFinal
    }
    
    /// path: /FigmaConvertXib/FigmaConvertXib/Figma/Xib
    
    class func pathXib() -> String {
        return pathXib(folder: nil)
    }
    
    /// path: /FigmaConvertXib/FigmaConvertXib/Figma/Xib/images.xcassets
    
    class func pathXibImages() -> String {
        return pathXib(folder: "images.xcassets")
    }
    
    /// path: TEMP
    /// /Users/mrusta/Library/Developer/CoreSimulator/Devices/FC70BFBD-0AA2-4BBF-AB10-A450BE6EED79/data/Containers/Data/Application/963AFA02-49CE-475D-AE9E-44D407355067/Documents
    
    class func pathTemporaryDocument() -> String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return documentDirectory[0]
    }
    

}
