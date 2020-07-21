//
//  XibFigmaFill.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 10.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit
    

extension FigmaFill {
    
    func xib(view: FigmaNode, effect: FigmaEffect? = nil, effect2: FigmaEffect? = nil, blur: FigmaEffect? = nil) -> String {
        
        var name = "Color_Radius"
        if type == .gradientLinear {
            name = "Gradient"
        }
//        else if type == .image {
//            name = view.name
//        }
        
        var viewHEADER = "<view alpha=\"\(opacity)\" clipsSubviews=\"\(view.clipsContent.xib())\" contentMode=\"scaleToFill\" fixedFrame=\"YES\" translatesAutoresizingMaskIntoConstraints=\"NO\" userLabel=\"\(name)\" id=\"\(xibID())\" customClass=\"DesignView\" customModule=\"FigmaConvertXib\" customModuleProvider=\"target\">"
        
        var viewEND = "</view>"
        
        
        if type == .image {
            let headerEnd = view.designImageViewXib()
            
            viewHEADER = headerEnd.0
            viewEND    = headerEnd.1
        }
        
        
        let xibAttributes =
            xibAttrsClose(attributes:
                
                xibAttrImage(name: view.name) +
                xibFill() +
                view.xibCornerRadius() +
                xibGradientLinear() +
                xib(effect: effect) +
                xib(effect: effect2) +
                xib(effect: blur)
            )
        
        let viewResult =
          viewHEADER +
            view.realFrame.xibBound() +
            addAutoresizingMask() +
            xibAttributes +
          viewEND
        
        
        return viewResult
    }
    
    
    func xibAttrImage(name: String) -> String {
        
        if type != .image { return "" }
        
        return xibAttr(imageName: name, key: "image") +
                xibAttr(boolean: (scaleMode == .fill), key: "contModeFill")
        
    }
    
    
    func xibFill() -> String {
        
        if type != .solid { return "" }
        
        return xibAttr(color: color, key: "fillColor")
    }
    
    
    func xib(effect: FigmaEffect?) -> String {
        
        guard let effect = effect else { return "" }
        
        return effect.xib()
    }
    
    
    
}
