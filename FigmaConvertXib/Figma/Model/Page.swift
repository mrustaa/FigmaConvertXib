//
//  Page.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 26.06.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

class FigmaPage {
    
    var backgroundColor: UIColor
    
//    var prototypeStartNodeID: JSONNull?
//    var prototypeDevice: PrototypeDevice
    
    let id, name: String
    let type: FigmaDocument.Type_
    var subviews: [FigmaView] = []
    
    var realFrame: CGRect = CGRect.zero
    
    init(_ d: [String:Any]) {
        
        id = dString(d, "id")
        name = dString(d, "name")
        
        let t = dString(d, "type")
        type = FigmaDocument.Type_.install(t)
        
        subviews = []
        if let arrayPages = dArr(d, "children") {
            for page in arrayPages {
                subviews.append( FigmaView(page) )
            }
        }
        
        let color = dDict(d, "backgroundColor")!
        backgroundColor = FigmaColor.color(color)
    }
    
}
