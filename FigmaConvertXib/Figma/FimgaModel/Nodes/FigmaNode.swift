//
//  View.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 26.06.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

class FigmaNode {
    
    var id, name: String
    let type: FigmaNode.Type_
    var children: [FigmaNode] = []
    
    var blendMode: BlendMode = .modeDefault
    
    var absoluteBoundingBox: CGRect = CGRect.zero
    var realFrame: CGRect = CGRect.zero
    
    var imageSize: CGSize?
    
    var realRadius: CGFloat = 0.0
    
    var visible: Bool = true
    var opacity: CGFloat = 1.0
    var clipsContent: Bool = false
    
    var backgroundColor: UIColor = .clear
    var fills: [FigmaFill] = []
    
    var strokeWeight: CGFloat = 0.0
    var strokeColor: UIColor = .clear
    var strokes: [FigmaFill] = []
    
    var cornerRadius: CGFloat = 0.0
    var text: String = ""
    var fontStyle: FigmaFont?
    
    var effects: [FigmaEffect] = []
    
    init(_ page: FigmaPage) {
        
        id = page.id
        name = page.name
        type = page.type
        backgroundColor = page.backgroundColor
        realFrame = page.realFrame
        children = page.children
    }
    
    
    
    init(_ dict: [String:Any]) {
        
        id = dString(dict, "id")
        
        let name = dString(dict, "name")
        self.name = name.findReplace(find: "/", replace: ":")
        
        let t = dString(dict, "type")
        type = FigmaNode.Type_.install(t)
        
        
        if let backgroundColor_ = dDict(dict, "backgroundColor") {
            backgroundColor = FigmaColor.color(backgroundColor_)
        }
        
        if let visible = dict["visible"] as? Bool {
            self.visible = visible
        }
        
        if let opacity = dict["opacity"] as? CGFloat {
            self.opacity = opacity
        }
        
        if let effects = dict["effects"] as? [ [String: Any] ] {
            self.effects = []
            for effect in effects {
                self.effects.append( FigmaEffect(effect) )
            }
        }
        
        if let arrayFills = dict["fills"] as? [ [String: Any] ] {
            self.fills = []
            for dictFill in arrayFills {
                self.fills.append( FigmaFill(dictFill) )
            }
        }
        
        if let arrayStrokes = dict["strokes"] as? [ [String: Any] ] {
            self.strokes = []
            for dict in arrayStrokes {
                self.strokes.append( FigmaFill(dict) )
            }
            for strokes in arrayStrokes {
                if let color = strokes["color"] as? [String: Any] {
                    self.strokeColor = FigmaColor.color(color)
                }
            }
        }
        
        if let strokeWeight = dict["strokeWeight"] as? CGFloat {
            self.strokeWeight = strokeWeight
        }
        
        if let blendMode = dict["blendMode"] as? String {
            self.blendMode = BlendMode.install(blendMode)
        }
        
        if let absoluteBoundingBox = dict["absoluteBoundingBox"] as? [String: Any] {
            self.absoluteBoundingBox = FigmaFrame.rect(absoluteBoundingBox)
        }
        
        if let clipsContent = dict["clipsContent"] as? Bool {
            self.clipsContent = clipsContent
        }
        
        if let cornerRadius = dict["cornerRadius"] as? CGFloat {
            self.cornerRadius = cornerRadius
        }
        
        if let characters = dict["characters"] as? String {
            self.text = characters
        }
        
        if let style = dict["style"] as? [String: Any] {
            self.fontStyle = FigmaFont(style)
        }
        
        if let arrayPages = dict["children"] as? [ [String: Any] ] {
            children = []
            for page in arrayPages {
                children.append( FigmaNode(page) )
            }
        }
        
    }
}


