//
//  FigmaDataCreateFolder.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 25.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension FigmaData {
    
    //MARK: - 📁 🆕 Create Folder
    
    class func createFolder(path: String, name: String) -> String? {
        
        // let localStrURL = FigmaData.pathTemporaryDocument()
        // let localStrURL = FigmaData.pathXibImages()
        
        let name_ = name.findReplace(find: "/", replace: ":")
        
        guard let url = URL(string: path) else { return nil }
        let pathName = url.appendingPathComponent(name_)
        let pathName_ = pathName.absoluteString
        
        if !FileManager.default.fileExists(atPath: pathName_) {
            do {
                let dataPathStr = path + "/" + name_ // dataPath.absoluteString
                try FileManager.default.createDirectory(atPath: dataPathStr, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error", error.localizedDescription)
            }
        }
        return pathName_
    }
    
    //    class func createFolder(path: String, name: String) -> Bool {
    //
    //        guard let pathURL = URL(string: path) else { return false }
    //        let pathNameURL = pathURL.appendingPathComponent(name)
    //        let filterPath = pathNameURL.absoluteString
    //
    //        let pathName = path + "/" + name
    //
    //        if !FileManager.default.fileExists(atPath: filterPath) {
    //
    //            FigmaData.createImageJsonFile(path: filterPath,
    //                                          path_: pathName,
    //                                          name: name)
    //
    //            return true
    //        } else {
    //            return false
    //        }
    //
    //    }
}
