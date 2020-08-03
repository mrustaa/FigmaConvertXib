//
//  XibView.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 02.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

extension FigmaFill {
    
    func contentModeXib() -> String {
        var mode = "scaleAspectFit"
        switch scaleMode {
        case .fill: mode = "scaleAspectFill"
        case .fit: mode = "scaleAspectFit"
        default: break
        }
        return mode
    }
}

extension FigmaFont {
    
    func alignmentXib() -> String {
        var alignment = "left"
        switch textAlignHorizontal {
        case .left: alignment = "left"
        case .center: alignment = "center"
        case .right: alignment = "right"
        case .justified: alignment = "justified"
        }
        return alignment
    }
}

extension FigmaNode {
    
    func imageFill() -> FigmaFill? {
        for fill in fills {
            if fill.type == .image {
                return fill
            }
        }
        return nil
    }
    
    func strokeSolid() -> FigmaFill? {
        for stroke in strokes {
            if stroke.type == .solid {
                return stroke
            }
        }
        return nil
    }
    
    func fontStyleXib() -> String {
        if let fontStyle = fontStyle {
            return fontStyle.alignmentXib()
        }
        return "left"
    }
    
    func contentModeXib() -> String {
        if let imageFill = imageFill() {
            return imageFill.contentModeXib()
        }
        return "scaleAspectFit"
    }
    
    
    func xib(_ main: Bool = true) -> String {
        
        // MARK: - 🦄 Start (Header End)
        
        var headerEnd  = ("", "")
        
        if type == .component {
            
            headerEnd = imageXib(comp: true)
            
        } else if type == .text {
            
            headerEnd = labelXib()
            
        } else if (realRadius != 0) || (strokes.count == 1) {
            
//            headerEnd = designFigureXib()
            headerEnd = designViewXib()
            
        } else {
            
            headerEnd = viewXib()
        }
        // MARK: - Frame
        
        let xmlFrame = realFrame.xib()
        // MARK: - Fill Text Background Color
        
        var xmlTextColor = ""
        var xmlBackgroundColor = ""
        var xmlFillColor = ""
        var xmlFillSubviews = ""
        
        /// Цвет текста, 1 слой
        /// (он может иметь множество слоев цвета. но это уже не бред - когда речь идет о тексте. да и вьюшке тоже)
        /// (либо слои с градиентом - что тоже бред)
        if type == .text {
            
            for fill: FigmaFill in fills {
                if fill.visible {
                    
                    if fill.type == .solid {
                        
                        xmlTextColor = "\(fill.color.withAlphaComponent(fill.opacity).xib("textColor"))<nil key=\"highlightedColor\"/>"
                        
                    } else if fill.type == .gradientLinear ||
                              fill.type == .gradientRadial {
                        
                        xmlFillColor = fill.xibGradient()
                    }
                }
            }
            
            var textSolid = false; for fill: FigmaFill in fills { if fill.visible, fill.type == .solid { textSolid = true }}
            
            if !textSolid {
                xmlFillColor += xibAttr(number: 18, key: "grBlendMode")
                xmlTextColor = xibAttr(color: .clear, key: "textColor")
            }
            
        } else if type != .component {
            
            /// 1 слой цвета фона  (и все - можно наложить ее на текущую вьюху)
            if fills.count == 1 {
                
                let fill: FigmaFill = fills[0]
                if fill.visible {
                    
                    /// Background Color
                    if fill.type == .solid {
                        
                        let color = fill.color.withAlphaComponent(fill.opacity)
                        
                        /// View
                        if realRadius == 0, strokes.count == 0, effects.count == 0  {
                            
                            xmlBackgroundColor = color.xib("backgroundColor")
                            
                        /// DesigView
                        } else if !effects.isEmpty {
                            
                            let blur = xibSearch(effect: .layerBlur)
                            let shadow = xibSearch(effect: .dropShadow)
                            let innerShadow = xibSearch(effect: .innerShadow)
                                
                            xmlFillSubviews = fill.xib(view: self, effect: shadow, effect2: innerShadow, blur: blur)
                                
                        } else {
                            xmlFillColor = xibAttr(color: color, key: "fillColor")
                        }
                        
                    /// Gradient
                    } else if fill.type == .gradientLinear || fill.type == .image {
                        
                        let blur = xibSearch(effect: .layerBlur)
                        let shadow = xibSearch(effect: .dropShadow)
                        let innerShadow = xibSearch(effect: .innerShadow)
                        
                        xmlFillSubviews = fill.xib(view: self, effect: shadow, effect2: innerShadow, blur: blur)
                        
                    }
                }
                
            } else { /// если их много. это уже все слои сабвьюхи
                
                var i = 0
                
                var visibleCount = 0
                for fill: FigmaFill in fills {
                    if fill.visible {
                        visibleCount += 1
                    }
                }
                
                if visibleCount > 1 {
                    
                    for fill: FigmaFill in fills {
                        
                        if fill.visible {
                            
                                var result = ""
                                
                                let blur = xibSearch(effect: .layerBlur)
                                
                                if i == 0 { /// 1 слой
                                    
                                    if let effect = xibSearch(effect: .dropShadow) {
                                        result = fill.xib(view: self, effect: effect, blur: blur)
                                    } else {
                                        result = fill.xib(view: self, blur: blur)
                                    }
                                    
                                } else if i == (visibleCount - 1) { /// конечный слой
                                    
                                    if let effect = xibSearch(effect: .innerShadow) {
                                        result = fill.xib(view: self, effect: effect, blur: blur)
                                    } else {
                                        result = fill.xib(view: self, blur: blur)
                                    }
                                    
                                } else {
                                    
                                    result = fill.xib(view: self, blur: blur)
                                }
                                
                                xmlFillSubviews += result
                            }
                            i += 1
                        }
                    
                    
                } else {
                    
                    for fill: FigmaFill in fills {
                    
                        if fill.visible {

                            let blur = xibSearch(effect: .layerBlur)
                            let shadow = xibSearch(effect: .dropShadow)
                            let innerShadow = xibSearch(effect: .innerShadow)
                            
                            xmlFillSubviews = fill.xib(view: self, effect: shadow, effect2: innerShadow, blur: blur)
                        }
                    }
                }
            }
        }
        
        // MARK: - Radius
        
        /// Радиус
        let xmlCornerRadius = xibCornerRadius()
        
        // MARK: - Border
        
        /// Имется слои - толшины и цвета границ
        var xmlBorder = ""
        //if !strokes.isEmpty, strokes.count == 1 {
        if let stroke = strokeSolid() {
            if stroke.visible {
            
            /// такая же логика - зачем толщине границ - несколько цветов
            /// или градиент я просто не представляю как здесь сделать
            // let stroke: FigmaFill = strokes[0]
                if stroke.type == .solid {

                    xmlBorder += xibAttr(number: strokeWeight, key: "brWidth")
                    xmlBorder += xibAttr(color: stroke.color.withAlphaComponent(stroke.opacity), key: "brColor")
                }
            }
        }
        
        
        if type == .text {
            for effect: FigmaEffect in effects {
                if effect.visible {
                    if effect.type == .dropShadow {
                        xmlBorder += xibAttr(color:  effect.color,      key: "shColor")
                        xmlBorder += xibAttr(number: effect.radius / 2, key: "shRadius")
                        xmlBorder += xibAttr(size:   effect.offset,     key: "shOffset")
                    }
                }
            }
        }
        
        // MARK: - Subviews
        
        /// слои сабвьюшки
        var xmlViewSubviews = ""
        if !children.isEmpty, type != .component {
            for oneFigmaNode: FigmaNode in children {
                if oneFigmaNode.visible,
                    oneFigmaNode.type != .vector,
                    oneFigmaNode.type != .booleanOperation {
                    
                    xmlViewSubviews = xmlViewSubviews + oneFigmaNode.xib(false)
                }
            }
        }
        
        var xmlSubviews = ""
        if !xmlFillSubviews.isEmpty || !xmlViewSubviews.isEmpty {
            xmlSubviews = xibSubviewsClose(subviews: xmlFillSubviews + xmlViewSubviews)
        }
        
        // MARK: - FontName
        
        let xmlFontName = fontNameXib()
        
        // MARK: - DesignView Attributes
        
        var xmlDefinedRuntimeAttributes = ""
        if !xmlFillColor.isEmpty || !xmlCornerRadius.isEmpty || !xmlBorder.isEmpty {
            xmlDefinedRuntimeAttributes = xibAttrsClose(attributes: xmlFillColor + xmlCornerRadius + xmlBorder )
        }
        
//        <resources>
//            <image name="🎈" width="1130" height="1436"/>
//            <image name="👹👹👹" width="16" height="16"/>
//        </resources>
        
        // MARK: - MainView Attributes
        
        var xmlMainHeader = ""
        var xmlMainEnd = ""
        
        if main {
            let m = xibMain()
            xmlMainHeader = m.header
            
            xmlMainEnd += m.resources + xibSearchImagesSize() + m.end
        }
        
        let mainViewMetrics = (main ? "<freeformSimulatedSizeMetrics key=\"simulatedDestinationMetrics\"/>" : "")
        
        // MARK: - 💖 Result
        
        let result = """
        \(xmlMainHeader)\(headerEnd.0)
        \(xmlFrame)\(xmlFontName)\(xmlBackgroundColor)\(xmlDefinedRuntimeAttributes)
        \(addAutoresizingMask())\(mainViewMetrics)\(xmlSubviews)\(xmlTextColor)
        \(headerEnd.1)\(xmlMainEnd)
        """
        
        return result
    }
    
    

}
