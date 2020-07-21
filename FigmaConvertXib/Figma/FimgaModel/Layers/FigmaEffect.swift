//
//  FigmaEffect.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 15.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

class FigmaEffect {
    
    var type: Type_
    var visible: Bool = true
    var color: UIColor = .clear
    var blendMode: FigmaNode.BlendMode = .modeDefault
    var offset: CGSize = .zero
    var radius: CGFloat = 0.0
    
    init(_ dict: [String:Any]) {
        
        let type = dString(dict, "type")
        self.type = Type_.install(type)
        
        if let visible = dict["visible"] as? Bool {
            self.visible = visible
        }
        
        if let color = dict["color"] as? [String: Any] {
            self.color = FigmaColor.color(color)
        }
        
        if let blendMode = dict["blendMode"] as? String {
            self.blendMode = FigmaNode.BlendMode.install(blendMode)
        }
        
        if let offset = dict["offset"] as? [String: Any] {
            self.offset = FigmaOffset.install(offset)
        }
        
        if let radius = dict["radius"] as? CGFloat {
            self.radius = radius
        }
    }
}


