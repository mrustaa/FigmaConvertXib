//
//  XibAndroidFigmaViewNew.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 18.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation


extension FigmaNode {
    
    static var imageCount: Int = 0
    static var textCount: Int = 0
    static var viewCount: Int = 0
    static var cardCount: Int = 0
    
    // MARK: Xib
    
    func xmlAndroid(main: Bool = true, keyType: FigmaFileType? = nil) -> String {
         
        if main {
            FigmaNode.imageCount = 0
            FigmaNode.textCount = 0
            FigmaNode.viewCount = 0
            FigmaNode.cardCount = 0
        }
        
        var view = ""
        
        //// _________________________________________________
        
        switch type {
            
        case .star, .ellipse, .regularPolygon,            /// figure
             .document, .page, .frame, .group, .rectangle,  /// view
            .text:
            
            view = xmlAndroidView(main: main, keyType: keyType)
        
        case .component:
            
            view = xibAndroidComponent()
        
        default: break
        }
            
        return view
    }
    
    
    // MARK: - Component
    
    private func xibAndroidComponent() -> String {
        
        var view: (header: String, end_settings: String, end: String) = ("", "", "")
        
        view = imageXmlAndroid(index: FigmaNode.imageCount)            /// Image
        FigmaNode.imageCount += 1;
        
        let rect = realFrame.xibAndroid(main: false)
        let attrs = xmlImageCompnent()
        
        //// _________________________________________________
        
        let result = view.header +
            rect +
            attrs +
            view.end_settings +
            view.end
        
        return result
        
    }
    
    // MARK: - Rect Image Figure
    
    private func xmlAndroidView(main: Bool, keyType: FigmaFileType? = nil) -> String {
        
        var view: (header: String, end_settings: String, end: String) = ("", "", "")
        
        
        /// _Stroke Gradient _________________________________________________
        
        var drawableName: String?
        
        if !image() && type != .text {
            
            if (xibSearchStroke() != nil) ||
                (xibSearch(fill: .gradientLinear) != nil) ||
                (xibSearch(fill: .gradientRadial) != nil) {
                
                let drawable = xmlAndroidDrawable()
                
                let filterName = name.xmlFilter()
                
                let pathXml = FigmaData.pathXmlAndroidImages()
                
                /// Имя .xml
                let nameXml_ = (filterName + ".xml")
                
                FigmaData.save(text:         drawable,
                               toDirectory:  pathXml,
                               withFileName: nameXml_)
                
                drawableName = filterName
            }
        }
        
        /// _Views _________________________________________________
        
        if image() {
            view = imageXmlAndroid(index: FigmaNode.imageCount)            /// Image
            FigmaNode.imageCount += 1;
        } else if type == .text {
            view = labelXmlAndroid(index: FigmaNode.textCount)            /// Text
            FigmaNode.textCount += 1;
        } else {
            
            if drawableName != nil {
                view = viewXmlAndroid(main: main, index: FigmaNode.viewCount)   /// View
                FigmaNode.viewCount += 1;
                
            } else {
                if realRadius != 0 {
                    view = cardViewXmlAndroid(radius: realRadius, index: FigmaNode.cardCount)   /// CardView
                    FigmaNode.cardCount += 1;
                } else {
                    view = viewXmlAndroid(main: main, index: FigmaNode.viewCount)   /// View
                    FigmaNode.viewCount += 1;
                }
            }
        }
        
        var attrs = ""
        
        /// _Frame ________________________________________
        
        let rect = realFrame.xibAndroid(main: main)
        
        /// _Background/Text Color ________________________________________
        
        if let name = drawableName {
            attrs = """

            android:background="@drawable/\(name)"
            """
        } else {
            attrs = xmlColor()
        }
        
        /// _Text ________________________________________
        
        attrs += xmlText()
        
        /// _Image ________________________________________
        
        attrs += xmlImage()
        
        /// _Subviews _________________________________________________
        
        var subviews = ""
        
        if type != .component, !image(), type != .text {
            for node: FigmaNode in children {
                if node.visible,
                    node.type != .vector,
                    node.type != .booleanOperation {
                    
                    switch type {
                    case //.star, .ellipse, .regularPolygon,            /// figure
                         .document, .page, .frame, .group, .rectangle,  /// view
                         .component,
                         .text:

                        let view_ = node.xmlAndroid(main: false, keyType: keyType)
                        subviews += view_
                        
                    default: break
                    }
                }
            }
        }
        
        //// _________________________________________________
        
        let result = view.header +
                        rect +
                        attrs +
                      view.end_settings +
                        subviews +
                    view.end
        
        return result
        
    }
    
}
