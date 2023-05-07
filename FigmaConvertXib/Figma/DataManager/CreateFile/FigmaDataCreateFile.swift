//
//  FigmaDataClearFolder.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 25.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension FigmaData {
    
    //MARK: - 💾📄 Save Local File.xib
    
    class func save(text: String, toDirectory directory: String, path_: String? = nil, withFileName fileName: String) {
        
        func append(toPath path: String, withPathComponent pathComponent: String) -> String? {
            if var pathURL = URL(string: path) {
                pathURL.appendPathComponent(pathComponent)
                return pathURL.absoluteString
            }
            return nil
        }
        
        guard var filePath: String = append(toPath: directory, withPathComponent: fileName) else {
            print("🚨 Error")
            return
        }
        
        if let path_ = path_ {
            filePath = path_
        }
        
        do {
            
            try text.write(toFile: filePath, atomically: true, encoding: .utf8)
            print("🧩  Write Succes \(filePath)")
        } catch {
            print("🚨 Error", error)
            return
        }
    }

  
  class func saveTest(text: String, toDirectory directory: String, path_: String? = nil, withFileName fileName: String) {
    
    func append(toPath path: String, withPathComponent pathComponent: String) -> String? {
      if var pathURL = URL(string: path) {
        pathURL.appendPathComponent(pathComponent)
        return pathURL.absoluteString
      }
      return nil
    }
    
    //      if let filepath = Bundle.main.path(forResource: "TTNorms-Regular", ofType: "ttf") {
    //        print(filepath)
    //      }
    //
    //      let fileManager = FileManager.default
    //      let currentPath = fileManager.currentDirectoryPath
    //      print("Current path: \(currentPath)")
    
    guard var filePath: String = append(toPath: directory, withPathComponent: fileName) else {
      print("🚨 Error")
      return
    }
    
    if let path_ = path_ {
      filePath = path_
    }
    
    
    
    //      var newPath = #file.replacingOccurrences(of: "FigmaConvertXib/Figma/DataManager/CreateFile/FigmaDataCreateFile.swift", with: "")
    //      filePath = filePath.findReplace(find: "/Users/mrusta/Desktop/FigmaConvertXib/", replace: "")
    //      newPath += filePath
    
    let URL_PATH = URL(fileURLWithPath: directory)
    let URL_FILE = URL_PATH.appendingPathComponent(fileName)
    do {
      try text.write(to: URL_FILE, atomically: true, encoding: .utf8)
      print("🧩 NEW URL Write Succes \(URL_FILE)")
    } catch {
      print("🚨 NEW Error", error)
    }
    
    
    func getDocumentsDirectory() -> URL {
      let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      return paths[0]
    }
    let filename = getDocumentsDirectory().appendingPathComponent(fileName)
    do {
      try text.write(to: filename, atomically: true, encoding: .utf8)
      print("🧩 OTHER Write Succes \(filename)")
    } catch {
      print("🚨 OTHER Error", error)
    }
    
    do {
      try text.write(toFile: filePath, atomically: true, encoding: .utf8)
      print("🧩  Write Succes \(filePath)")
    } catch {
      print("🚨 Error", error)
      return
    }
  }
  
  
    
    
}
