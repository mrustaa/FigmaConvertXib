//
//  Page.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 26.06.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

class F_Page {
    
    var backgroundColor: UIColor
    
//    var prototypeStartNodeID: JSONNull?
//    var prototypeDevice: PrototypeDevice
    
    let id, name: String
    let type: F_Document.Type_
    var subviews: [F_View] = []
    
    var realFrame: CGRect = CGRect.zero
    
    init(_ d: [String:Any]) {
        
        id = dString(d, "id")
        name = dString(d, "name")
        
        let t = dString(d, "type")
        type = F_Document.Type_.install(t)
        
        subviews = []
        if let arrayPages = dArr(d, "children") {
            for page in arrayPages {
                subviews.append( F_View(page) )
            }
        }
        
        let color = dDict(d, "backgroundColor")!
        backgroundColor = F_Color.color(color)
    }
    
}
