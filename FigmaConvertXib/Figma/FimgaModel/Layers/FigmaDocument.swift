//
//  Document.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 26.06.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

class FigmaDocument {
    
    let id, name: String
    let type: Type_
    var pages: [FigmaPage] = []
    
    init(_ d: [String:Any]) {
        
        id = dString(d, "id")
        name = dString(d, "name")
        
        let type = dString(d, "type")
        self.type = FigmaDocument.Type_.install(type)
        
        if let arrayPages = dArr(d, "children") {
            for page in arrayPages {
                pages.append( FigmaPage(page) )
            }
        }
    }
}

