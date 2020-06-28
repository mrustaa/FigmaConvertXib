//
//  Response.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 26.06.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

class FigmaResponse {
    
    var document: FigmaDocument
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
        
    }
}
