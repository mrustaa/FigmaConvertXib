//
//  XibFigmaViews.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 21.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

private var customModule = "FigmaConvertXib"
private var customClassImage = "DesignImageView"
private var customClassView = "DesignView"

extension FigmaNode {
    
    enum XibViewType {
        case image
        case imageComp
        case imageDesign
        case view
        case viewDesign
        case viewDesignComp
        case label
    }
    
    
    func xib(viewType: XibViewType) -> (String, String) {
        
        switch viewType {
        case .image:          return imageXib()
        case .imageComp:      return imageXib(comp: true)
        case .imageDesign:    return designImageViewXib()
        case .view:           return viewXib()
        case .viewDesign:     return designViewXib()
        case .viewDesignComp: return designViewXib(comp: true)
        case .label:          return labelXib()
        }
    }
    
    func imageXibReady() -> String {
        
        let imageHeaderEnd = imageXib()
        
        return """
        \(imageHeaderEnd.0)
        \(realFrame.xibBound())
        \(addAutoresizingMask())
        \(imageHeaderEnd.1)
        """
    }
    
    func imageXib(comp: Bool = false) -> (String, String) {
        
        // let fileNameType = "\(imageFill.imageRef).png"
        // let fileNameType = "\(page.name).png"
        
        let contentMode = comp ? "scaleAspectFill" : contentModeXib()
        
        let header = "<imageView clipsSubviews=\"YES\" userInteractionEnabled=\"NO\" alpha=\"\(opacity)\" contentMode=\"\(contentMode)\" horizontalHuggingPriority=\"251\" verticalHuggingPriority=\"251\" fixedFrame=\"YES\" image=\"\(name)\" translatesAutoresizingMaskIntoConstraints=\"NO\" userLabel=\"\(name)\" id=\"\(xibID())\">"
        
        let end = "</imageView>"
        
        return (header, end)
    }
    
    func designImageViewXib() -> (String, String) {
        
        let header = """
        <view contentMode="scaleToFill" fixedFrame="YES" translatesAutoresizingMaskIntoConstraints="NO" id="\(xibID())" userLabel="\(name)" customClass="\(customClassImage)" customModule="\(customModule)" customModuleProvider="target">
        """
        
        let end = "</view>"
        
        return (header, end)
    }
    
    func labelXib() -> (String, String) {
        
        let header = "<label opaque=\"NO\" userInteractionEnabled=\"NO\" alpha=\"\(opacity)\" contentMode=\"left\" horizontalHuggingPriority=\"251\" verticalHuggingPriority=\"251\" fixedFrame=\"YES\" text=\"\(text)\" textAlignment=\"\(fontStyleXib())\" lineBreakMode=\"tailTruncation\" numberOfLines=\"100\" baselineAdjustment=\"alignBaselines\" adjustsFontSizeToFit=\"NO\" translatesAutoresizingMaskIntoConstraints=\"NO\" userLabel=\"\(name)\" id=\"\(xibID())\">"
        
        let end = "</label>"
        
        return (header, end)
    }
    
    func designViewXib(comp: Bool = false) -> (String, String) {
        
        let clipsSubviews = comp ? "YES" : clipsContent.xib()
        
        let header = "<view clipsSubviews=\"\(clipsSubviews)\" alpha=\"\(opacity)\" contentMode=\"scaleToFill\" fixedFrame=\"YES\" translatesAutoresizingMaskIntoConstraints=\"NO\" userLabel=\"\(name)\" id=\"\(xibID())\" customClass=\"\(customClassView)\" customModule=\"\(customModule)\" customModuleProvider=\"target\">"
        
        let end = "</view>"
        
        return (header, end)
    }
    
    func viewXib() -> (String, String) {
        
        let header = "<view clipsSubviews=\"\(clipsContent.xib())\" alpha=\"\(opacity)\" contentMode=\"scaleToFill\" fixedFrame=\"YES\" translatesAutoresizingMaskIntoConstraints=\"NO\" userLabel=\"\(name)\" id=\"\(xibID())\">"
        
        let end = "</view>"
        
        return (header, end)
    }
    
    // let viewHEADER = "<view alpha=\"\(fill.opacity)\" clipsSubviews=\"\(page.clipsContent.string())\" contentMode=\"scaleToFill\" fixedFrame=\"YES\" translatesAutoresizingMaskIntoConstraints=\"NO\" id=\"\(randId)\" customClass=\"DesignView\" customModule=\"FigmaConvertXib\" customModuleProvider=\"target\">"
    // let viewEND = "</view>"
    
        
    
}
