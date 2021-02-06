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
        } catch {
            print("🚨 Error", error)
            return
        }
    }
    
    
}
