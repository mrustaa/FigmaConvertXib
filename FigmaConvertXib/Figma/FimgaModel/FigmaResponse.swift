//
//  Response.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 26.06.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

//class FigmaComponent {
//    var key: String
//    var name: String
//    var description: String
//
//    init(_ d: [String:Any]) {
//
//    }
//}

class FigmaResponse {
    
    var document: FigmaDocument
    var components: [ String ]
    var schemaVersion: Double
    var thumbnail: URL
    var lastModified: Date
    var name, version, role: String
    
    init(_ d: [String:Any]) {
        
        schemaVersion = dDouble(d, "schemaVersion")
        thumbnail = dURL(d, "thumbnailUrl")!
        lastModified = dDate(d, "lastModified")!
        
        name = dString(d, "name")
        version = dString(d, "version")
        role = dString(d, "role")
        
        let doc = dDict(d, "document")!
        document = FigmaDocument(doc)
        
        if let components = d["components"] as? [ String: Any ] {
            var compsStr: [String] = []
            for key in components.keys {
                compsStr.append(key)
            }
            self.components = compsStr
        } else {
            self.components = [ ]
        }
    }
}
