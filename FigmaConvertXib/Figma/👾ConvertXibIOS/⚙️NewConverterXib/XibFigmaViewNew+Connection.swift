//
//  XibFigmaViewNew+Connection.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 06.11.2021.
//  Copyright © 2021 mrusta. All rights reserved.
//

import UIKit

extension FigmaNode {
    
    func getConnetctions(cell: Bool = false) -> String {
        
        var connections_ = propertyChildren(type: .xib).connections
        
        if cell {
            let buttonConnection = """
            <outlet property="button" destination="\(cellButtonId)" id="\(xibID())"/>
            """
            connections_.append(buttonConnection)
        }
        
        if !connections_.isEmpty {
            
            var result = ""
            for c in connections_ {
                result += c
            }
            
            return """
            <connections>
                \(result)
            </connections>
            """
        }
        return ""
    }
    
    func getConnetctionsTable() -> String {
        
        return """
            <connections>
                <outlet property="tableView" destination="\(tableId)" id="\(xibID())"/>
                <outlet property="tableTop" destination="\(tableTop)" id="\(xibID())"/>
                <outlet property="tableBottom" destination="\(tableBottom)" id="\(xibID())"/>
            </connections>
            """
    }
}
