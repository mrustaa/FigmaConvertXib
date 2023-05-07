//
//  XibFigmaViewNew+Label.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 06.11.2021.
//  Copyright © 2021 mrusta. All rights reserved.
//

import UIKit

extension FigmaNode {
    
    // MARK: - Label
    
    func xibLabel(superFrame: CGRect) -> (view: String, constraints: String) {
        
        let rect = realFrame.xib()
        let arMask = addAutoresizingMask()
        
        var attr = ""
        
        let xmlFontName = fontNameXib()
        
        var textColor = ""
        
        /// _ Fill _________________________________________________
        
        if let fill = xibSearch(fill: .solid) {
            textColor = fill.colorA().xib("textColor")
        } else {
            attr += xibAttr(number: 18, key: "grBlendMode")
            textColor = xibAttr(color: .clear, key: "textColor")
        }
        
        /// _Gradient _________________________________________________
        
        if let linear = xibSearch(fill: .gradientLinear) {
            attr += linear.xibGradient()
        } else if let radial = xibSearch(fill: .gradientRadial) {
            attr += radial.xibGradient()
        }
        
        /// _Stroke _________________________________________________
        
        if let stroke = xibSearchStroke() {
            
            attr += xibAttr(color:  stroke.colorA(), key: "brColor")
            attr += xibAttr(number: strokeWeight,    key: "brWidth")
        }
        
        if let shadow = xibSearch(effect: .dropShadow) {
            attr += shadow.xib()
        }
        
        var constraintsCurrent: String = ""
        if let crId = creatorId {
//            let r = xibConstraintsAll(curId: xibId, mainId: crId, superFrame: superFrame)
//            constraintsCurrent += r.origin
        }
        
        let attrs = xibAttrsClose(attributes: attr)
        
        let view = labelXib(design: !attr.isEmpty)
        
        //// _________________________________________________
        
        let result = view.header +
        rect +
        arMask +
        xmlFontName +
        textColor +
        attrs +
        view.end
        
        return (result, constraintsCurrent)
    }
    
}

