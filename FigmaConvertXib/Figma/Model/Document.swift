//
//  Document.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 26.06.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

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

extension FigmaDocument {

    enum Type_: String {
        
        case boolean = "BOOLEAN" /// Bool
        case component = "COMPONENT"
        case ellipse = "ELLIPSE" /// Овал
        case vector = "VECTOR" ///
        case booleanOperation = "BOOLEAN_OPERATION"
        case document = "DOCUMENT" /// Главный Док
        case canvas = "CANVAS" /// Полотно Холст
        case frame = "FRAME" /// Фрейм
        case group = "GROUP" /// Группа - группа не удаляет x y
        case instance = "INSTANCE"
        case line = "LINE"
        case regularPolygon = "REGULAR_POLYGON"
        case slice = "SLICE"
        case star = "STAR"
        case text = "TEXT" /// Label
        case rectangle = "RECTANGLE" /// прямоугольник
        
        static func install(_ str: String) -> Type_ {
            var nType: Type_ = .boolean
            
            switch str {
            case "BOOLEAN": nType = .boolean
            case "CANVAS": nType = .canvas
            case "COMPONENT": nType = .component
            case "DOCUMENT": nType = .document
            case "ELLIPSE": nType = .ellipse
            case "FRAME": nType = .frame
            case "GROUP": nType = .group
            case "INSTANCE": nType = .instance
            case "LINE": nType = .line
            case "RECTANGLE": nType = .rectangle
            case "REGULAR_POLYGON": nType = .regularPolygon
            case "SLICE": nType = .slice
            case "STAR": nType = .star
            case "TEXT": nType = .text
            case "VECTOR": nType = .vector
            case "BOOLEAN_OPERATION": nType = .booleanOperation
            default: break
            }
            return nType
        }
    }
}
