//
//  FigmaDocumentType.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 15.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

extension FigmaNode {

    enum Type_: String {
        
        case document = "DOCUMENT"              /// Главный Док
        case page = "CANVAS"                    /// Страница                        View
        case frame = "FRAME"                    /// Фрейм                           View
        case group = "GROUP"                    /// Группа - группа не удаляет x y  View
        case rectangle = "RECTANGLE"            /// Прямоугольник                   View
        
        case vector = "VECTOR"                  /// Вектор Стрелка                          Vector
        case line = "LINE"                      /// Линия                                   Vector
        case ellipse = "ELLIPSE"                /// Овал                                    Vector
        case star = "STAR"                      /// Звезда                                  Vector
        case regularPolygon = "REGULAR_POLYGON" /// Треугольник                             Vector
        
        case text = "TEXT"                      /// Лейбл
        case component = "COMPONENT"
        case instance = "INSTANCE"
        case slice = "SLICE"
        case boolean = "BOOLEAN"
        case booleanOperation = "BOOLEAN_OPERATION"
        
        static func install(_ str: String) -> Type_ {
            var nType: Type_ = .boolean
            
            switch str {
            case "BOOLEAN": nType = .boolean
            case "CANVAS": nType = .page
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
