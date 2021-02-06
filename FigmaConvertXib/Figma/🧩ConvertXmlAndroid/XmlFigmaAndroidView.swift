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
    
    // MARK: Xib
    
    func xmlAndroid(main: Bool = true, keyType: FigmaFileType? = nil) -> String {
         
        if main {
            FigmaNode.imageCount = 0
            FigmaNode.textCount = 0
            FigmaNode.viewCount = 0
        }
        
        var view = ""
        
        //// _________________________________________________
        
        switch type {
            
        case //.star, .ellipse, .regularPolygon,            /// figure
             .document, .page, .frame, .group, .rectangle,  /// view
            .text:
            
            view = xmlAndroidView(main: main, keyType: keyType)
        
        default: break
        }
            
        return view
    }
    
    // MARK: - Rect Image Figure
    
    private func xmlAndroidView(main: Bool, keyType: FigmaFileType? = nil) -> String {
        
        var view: (header: String, end_settings: String, end: String) = ("", "", "")
        
        if image() {
            view = imageXmlAndroid(index: FigmaNode.imageCount)            /// Image
            FigmaNode.imageCount += 1;
        } else if type == .text {
            view = labelXmlAndroid(index: FigmaNode.textCount)            /// Text
            FigmaNode.textCount += 1;
        } else {
            view = viewXmlAndroid(main: main, index: FigmaNode.viewCount)   /// View
            FigmaNode.viewCount += 1;
        }
        
        /// _Frame ________________________________________
        
        let rect = realFrame.xibAndroid(main: main)
        
        /// _Background/Text Color ________________________________________
        
        var attrs = xmlColor()
        
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
