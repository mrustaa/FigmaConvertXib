//
//  XibFigmaViewConnectionsAndroid.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 29.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension FigmaNode {
    
    /// Label | ImageView
    
    enum XmlHolderPropertyType {
        case holderSet
        case holderProperty
        case holderFindId
        case cellProperty
        case cellInit
        case cellSet
    }
    
    // MARK: - Connections Xib <-> Swift
    
    func propertyChildrenAndroid(type: XmlHolderPropertyType, addedCount: Int = 0) -> (connections: [String], addedCount: Int) {
        
        var connections: [String] = []
        var count = addedCount
        
        if self.type == .component {
            
            let result = propertyAndroid(type: type, typeLabel: false, id: xibId, count: count)
            connections.append(result)
            count += 1
            
        } else if !children.isEmpty,
            self.type != .component {
            
            for node: FigmaNode in self.children {
                
                if node.visible,
                    node.type != .vector,
                    node.type != .booleanOperation {
                    
                    
                    if let _ = node.xibSearch(fill: .image) {
                        
                        let result = propertyAndroid(type: type, typeLabel: false, id: node.xibId, count: count)
                        connections.append(result)
                        count += 1
                    }
                    
                    if node.type == .text {
                        
                        let result = propertyAndroid(type: type, typeLabel: true, id: node.xibId, count: count)
                        connections.append(result)
                        count += 1
                    }
                    
                    let result = node.propertyChildrenAndroid(type: type, addedCount: count)
                    
                    connections += result.0
                    count = result.1
                }
            }
        }
        return (connections, count)
    }
    
        
        func propertyAndroid(type: XmlHolderPropertyType, typeLabel: Bool, id: String, count: Int) -> String {
            
            let      name_: String = typeLabel ? "text"     : "image"
            let classType_: String = typeLabel ? "TextView" : "ImageView"
            let valueType_: String = typeLabel ? "String"   : "int"
            let  setValue_: String = typeLabel ? "setText"  : "setImageResource"
            
            let  prName: String = (name_ + "\(count)")
            
            var outlet: String = ""
            
            
            switch type {
            case .holderSet:
                
                outlet = "holder.\(prName).\(setValue_)(\(prName));"
                
    //            holder.title.setText(title);
    //            holder.image.setImageResource(image);
                
                break
            case .holderProperty:

                outlet = "public \(classType_) \(prName);"
                
    //            public TextView  title;
    //            public ImageView image;
                
                break
            case .holderFindId:

                outlet = "\(prName) = (\(classType_)) itemView.findViewById(R.id.\(prName));"
                
    //            image = (ImageView) itemView.findViewById(R.id.image);
    //            title = (TextView)  itemView.findViewById(R.id.title);
                
                break
            case .cellProperty:
                
                outlet = "private \(valueType_) \(prName);"
                
    //            private String title;
    //            private int    image;
                
                break
            case .cellInit:
                
                outlet = "\(valueType_) \(prName),"
                
    //            Cell(String title,
    //                 int    image)
                
                break
            case .cellSet:

                outlet = "this.\(prName) = \(prName);"
                
    //            this.title = title;
    //            this.image = image;
                
                break
            }
            
            return outlet
        }
        
        
    
}
