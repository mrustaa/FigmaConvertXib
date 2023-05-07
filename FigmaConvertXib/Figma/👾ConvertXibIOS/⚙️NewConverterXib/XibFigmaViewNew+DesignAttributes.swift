//
//  XibFigmaViewNew+DesignAttributes.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 06.11.2021.
//  Copyright © 2021 mrusta. All rights reserved.
//

import UIKit

extension FigmaNode {
  
    // MARK: - Attributes == 1 FillColor
    
    func attributesOnlyFill(_ attrArr: [String]) -> String? {
        if attrArr.count == 1, attrArr[0].find(find: "fillColor"), let fill = xibSearch(fill: .solid) {
            return fill.colorA().xib("backgroundColor")
        }
        return nil
    }
    
    // MARK: - Attributes Arr[Str] Designbl
    
    func getAttributes() -> [String] {
        
        /// _Attributes ________________________________________
        
        var attrArr: [String] = []
        
        switch type {
        case .document, .page, .frame, .group, .rectangle:  /// view
            if realRadius != 0 {
                attrArr.append( xibAttr(number: realRadius, key: "cornerRadius") )
            }
            
        case .ellipse:
            attrArr.append( xibAttr(number: 1, key: "figureType") )
            
        case .regularPolygon:
            attrArr.append( xibAttr(number: 2, key: "figureType") )
            attrArr.append( xibAttr(number: 3, key: "starCount") )
            
        case .star:
            attrArr.append( xibAttr(number: 3, key: "figureType") )
            
        default: break
        }
        
        /// _Stroke _________________________________________________
        
        if let stroke = xibSearchStroke() {
            attrArr.append( xibAttr(color:  stroke.colorA(), key: "brColor") )
            attrArr.append( xibAttr(number: strokeWeight,    key: "brWidth") )
        }
        
        /// _ Fill _________________________________________________
        
        if let fill = xibSearch(fill: .solid) {
            attrArr.append( xibAttr(color: fill.colorA(), key: "fillColor") )
        }
        
        /// _ Image _
        if let image = xibSearch(fill: .image) {
            let contentMode: CGFloat = (image.scaleMode == .fill) ? 2 : 1
            attrArr.append( xibAttr(imageName: name.xibFilter(), key: "image") )
            attrArr.append( xibAttr(number:    contentMode,      key: "imageMode") )
        }
        
        /// _ Gradient _
        if let linear = xibSearch(fill: .gradientLinear) {
            attrArr.append( linear.xibGradient() )
        } else if let radial = xibSearch(fill: .gradientRadial) {
            attrArr.append( radial.xibGradient() )
        }
        
        /// _Effects _________________________________________________
        
        if let blur = xibSearch(effect: .layerBlur) {
            attrArr.append( blur.xib() )
        }
        if let shadow = xibSearch(effect: .dropShadow) {
            attrArr.append( shadow.xib() )
        }
        if let innerShadow = xibSearch(effect: .innerShadow) {
            attrArr.append( innerShadow.xib() )
        }
        return attrArr
    }
    
}
