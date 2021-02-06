//
//  XibFigmaSearchEffects.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 01.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

extension FigmaNode {
    
    // MARK: Search Attributes
    
    /// Effect
    
    func xibSearch(effect type: FigmaEffect.Type_) -> FigmaEffect? {
        for effect: FigmaEffect in effects {
            if effect.type == type {
                if effect.visible {
                    return effect
                }
            }
        }
        return nil
    }
    
    /// Fill
    
    func xibSearch(fill type: FigmaFill.Type_) -> FigmaFill? {
        for fill: FigmaFill in fills {
            if fill.type == type {
                if fill.visible {
                    return fill
                }
            }
        }
        return nil
    }
    
    func image() -> Bool {
        return xibSearch(fill: .image) != nil
    }
    
    /// Stroke
    
    func xibSearchStroke() -> FigmaFill? {
        if !strokes.isEmpty {
            let stroke: FigmaFill = strokes[strokes.count - 1]
            if stroke.visible {
                return stroke
            }
        }
        return nil
    }
    
    // MARK: - Search Images Size
    
    private func xibImageSize(name: String, size: CGSize) -> String {
        return "<image name=\"\(name)\" width=\"\(size.width)\" height=\"\(size.height)\"/>"
    }
    
    func xibSearchImagesSizeChildren() -> String {
        
        var attr = ""
        
        if let size = imageSize {
            attr += xibImageSize(name: name, size: size)
//            print( "🦄" + attr)
        }
        
        if type != .component {
            for node: FigmaNode in children {
                if node.visible,
                    node.type != .vector,
                    node.type != .booleanOperation {
                    
                    let result = node.xibSearchImagesSizeChildren()
                    
                    if !attr.find(find: result) {
                        attr += result
                    }
                    
//                    print( "🔥" + attr)
                }
            }
        }
        return attr
    }
    
    func xibSearchImagesSize() -> String {
        
        let attr = xibSearchImagesSizeChildren()
        

//        let filter = attr.findReplace(find: attr, replace: "")
        
        if !attr.isEmpty {
            
            return """
            <resources>
                \(attr)
            </resources>
            """
            
        } else {
            return ""
        }
        
        /**
         <resources>
             <image name="Component 1" width="715" height="471"/>
             <image name="Rectangle 1" width="1130" height="1436"/>
             <image name="ИЗОБРАЖЕНИЕ🖼" width="360" height="270"/>
             <image name="🖼arrow" width="63" height="63"/>
         </resources>
         */
    }
    
    
//    func xibSearch(stroke type: FigmaFill.Type_) -> FigmaFill? {
//        return searchFill(arr: strokes, type: type)
//    }
    
//    private func searchFill(arr: [FigmaFill], type: FigmaFill.Type_) -> FigmaFill?  {
//        for f: FigmaFill in arr {
//            if f.type == type {
//                return f
//            }
//        }
//        return nil
//    }
    
}


