//
//  XibFigmaViewNew+ViewRectImage.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 06.11.2021.
//  Copyright © 2021 mrusta. All rights reserved.
//

import UIKit

extension FigmaNode {
  
    // MARK: - Rect Image Figure
    
    func xibFigure(main: Bool, keyType: FigmaFileType? = nil, superFrame: CGRect) -> (view: String, constraints: String) {
        
        var view = designFigureXib()
        
        //MARK: - Frame
        
        let bounds = realFrame.getBounds()
        //      print(" main \(main) | mainRect:\(Self.mainFrame) = curRect:\(bounds.description) | \(name) \(Self.mainFrame.equalTo(bounds)) ")
        
        var frameEqualMain: Bool = false
        if main {
            Self.mainFrame = bounds
            Self.mainId    = xibId
        } else {
            if Self.mainFrame.equalTo(bounds) {
                frameEqualMain = true
            }
        }
        
        var rect = realFrame.xib()
        
        //MARK: - Cell Key
        
        var connections: String = ""
        var constraintsCurrent: String = ""
        var constraintsSize: String = ""
        var constraints: String = ""
        
        var findKey: FigmaFileType? = nil
        
        if let keyType = keyType, keyType == .cell || keyType == .collection {
            let r = viewCellFilter(keyType: keyType, curView: view)
            view = r.view
            findKey = r.findKey
            rect = r.rect
            connections = r.connections
        }
        if name.find(find: FigmaFileType.button.rawValue) {
            findKey = .button
            view = designButtonXib()
        }
        
        
        let arMask = addAutoresizingMask()
        
        //MARK: - Attributes
        
        var attrArr: [String] = getAttributes()
        
        var attrs = ""
        var backgroundColor = ""
        
        if currentTypeCell(keyType: keyType) {
            
            if let bcolor = attributesOnlyFill(attrArr) {
                backgroundColor = bcolor
                attrArr.removeLast()
                //              attrs = xibAttrsClose(attributes: attrArr.joined())
                view = viewXib()
                
                let nr = viewCellFilter(keyType: keyType, curView: view)
                view = nr.view
                findKey = nr.findKey
                rect = nr.rect
                connections = nr.connections
                
            } else {
                attrs = xibAttrsClose(attributes: attrArr.joined())
            }
            
            //      if let key = findKey, key == .cell || key == .collection {
            
        } else {
            if keyType != .table {
                if attrArr.count != 0 {
                    
                    if let bcolor = attributesOnlyFill(attrArr) {
                        backgroundColor = bcolor
                        view = viewXib()
                    } else {
                        attrs = xibAttrsClose(attributes: attrArr.joined())
                    }
                    
                } else {
                    if findKey == nil {
                        view = viewXib()
                    }
                }
            }
        }
        
        //MARK: - Subviews
        
        var subviews_ = ""
        
        if keyType == .table {
            let table = tableAdapterViewXib()
            subviews_ += (table.header + table.end)
            constraints += table.constraints
        } else {
            if type != .component {
                for node: FigmaNode in children {
                    if node.visible,
                       node.type != .vector,
                       node.type != .booleanOperation {
                        
                        var creatorId = xibId
                        if xibId == Self.tableCellId || xibId == Self.tableCellContentId {
                            creatorId = Self.tableCellViewId
                        }
                        node.creatorId = creatorId
                        let realFr = realFrame
                        let result_ = node.xibNew(main: false, keyType: keyType, superFrame: realFr)
                        constraints += result_.constraints
                        subviews_ += result_.view
                    }
                }
                
                if main,
                   currentTypeCell(keyType: keyType) {
                    // let key = findKey, key == .cell || key == .collection {
                    
                    let button = cellButtonXib()
                    subviews_ += (button.header + button.end)
                    
                    //              constraints += xibConstraintsAll(
                    //                curId: cellButtonId,
                    //                mainId: Self.tableCellViewId
                    //              )
                }
            }
        }
        
        if frameEqualMain, keyType != .table {
//            let r = xibConstraintsAll(first: true, superFrame: superFrame)
//            constraintsCurrent += r.origin
//            constraintsSize = r.size
        } else if let crId = creatorId {
            if crId == Self.tableCellId || crId == Self.tableCellContentId {
                //          crId = Self.tableCellViewId
                constraintsCurrent = ""
            } else {
                
//                let r = xibConstraintsAll(curId: xibId, mainId: crId, superFrame: superFrame)
//                constraintsCurrent += r.origin
//                constraintsSize = r.size
            }
        }
        
        var subvs = ""
        if !subviews_.isEmpty {
            subvs = xibSubviewsClose(subviews: subviews_)
        }
        
        var constraintClose: String = ""
        if !constraints.isEmpty || !constraintsSize.isEmpty { //}, !subvs.isEmpty {
            constraintClose = xibConstraintsClose(value: constraints + constraintsSize)
        }
        
        //MARK: - Connections
        // if !connections.isEmpty connections += getConnetctions()
        
        if let key = findKey {
            if currentTypeCell(keyType: key) {
                // if key == .cell || key == .collection {
                connections += getConnetctions(cell: true)
            } else if keyType == .table {
                connections += getConnetctionsTable()
            }
        }
        
        //MARK: - Main
        
        let mMetrics = (main ? "<freeformSimulatedSizeMetrics key=\"simulatedDestinationMetrics\"/>" : "")
        
        //// _________________________________________________
        
        if let key = findKey, key == .cell || key == .collection {
            if !attrArr.isEmpty {
                attrs = xibAttrsClose(attributes: attrArr.joined())
            }
        }
        
        //MARK: Result9
        
        let result = view.header +
        rect +
        backgroundColor +
        arMask +
        mMetrics +
        subvs +
        constraintClose +
        attrs +
        connections +
        view.end
        
        return (result, constraintsCurrent)
    }
}
