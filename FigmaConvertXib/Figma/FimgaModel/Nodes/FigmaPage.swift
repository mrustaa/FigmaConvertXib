//
//  Page.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 26.06.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

class FigmaPage {
    
    let id: String
    let name: String
    let type: FigmaNode.Type_
    var children: [FigmaNode] = []
    var backgroundColor: UIColor
    var realFrame: CGRect = CGRect.zero
    
    
    init(_ d: [String:Any]) {
        
        id = dString(d, "id")
        name = dString(d, "name")
        
        let t = dString(d, "type")
        type = FigmaNode.Type_.install(t)
        
        children = []
        if let arrayPages = dArr(d, "children") {
            for page in arrayPages {
                children.append( FigmaNode(page) )
            }
        }
        
        let color = dDict(d, "backgroundColor")!
        backgroundColor = FigmaColor.color(color)
    }
    
}
