//
//  XibFigmaKeyFileCell.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 23.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension FigmaNode {
    
    // MARK: - Gen Swift Cell
    
    func xibGenFileCell() -> String {
        
        let name_ = name.xibFilterName(type: .cell)
        
        let connections  = propertyChildren(type: .cellProperty).connections
        let connsNames    = genArr(connections,  4, true)
        
        let initItem     = propertyChildren(type: .initItem).connections
        let initItem_     = genArr(initItem,     9, true)
        
        let initData     = propertyChildren(type: .initData).connections
        let initData_     = genArr(initData,    36, true)
        
        let dataProperty = propertyChildren(type: .dataProperty).connections
        let dataProperty_ = genArr(dataProperty, 4, true)
        
        let dataSet      = propertyChildren(type: .dataSet).connections
        let dataSet_      = genArr(dataSet,      8, true)
        
        let cellSet      = propertyChildren(type: .cellSet).connections
        let cellSet_      = genArr(cellSet,      8, true)
        
        
        return """
        import UIKit
        
        // MARK: - Item

        class \(name_)Item: TableAdapterItem {
            
            init(\(initItem_)separator: Bool = false,
                 touchAnimationHide: Bool = false,
                 editing: Bool = false,
                 clickCallback: (() -> ())? = nil) {
                
                let cellData = \(name_)CellData(\(initData_)separator: separator,
                                                touchAnimationHide: touchAnimationHide,
                                                editing: editing,
                                                clickCallback: clickCallback)
                
                super.init(cellClass: \(name_)Cell.self, cellData: cellData)
            }
        }

        // MARK: - Data

        class \(name_)CellData: TableAdapterCellData {
            
            // MARK: Properties
            
            \(dataProperty_)
            var separatorVisible: Bool
            var touchAnimationHide: Bool
            var editing: Bool
            
            // MARK: Inits
            
            init(\(initItem_)
                 separator: Bool,
                 touchAnimationHide: Bool,
                 editing: Bool,
                 clickCallback: (() -> ())?) {
                
                \(dataSet_)
                self.separatorVisible = separator
                self.touchAnimationHide = touchAnimationHide
                self.editing = editing
                
                super.init(clickCallback)
            }
            
            override public func cellHeight() -> CGFloat {
                return \(realFrame.height)
            }
            
            override public func canEditing() -> Bool {
                return editing
            }
        }

        // MARK: - Cell

        class \(name_)Cell: TableAdapterCell {
            
            // MARK: Properties
            
            public var data: \(name_)CellData?
            
            // MARK: Outlets
            
            \(connsNames)
            @IBOutlet override var selectedView: UIView? { didSet { } }
            
            // MARK: Initialize
            
            override func awakeFromNib() {
                separator(hide: true)
            }
            
            override func fill(data: TableAdapterCellData?) {
                guard let data = data as? \(name_)CellData else { return }
                self.data = data
                
                self.hideAnimation = data.touchAnimationHide
                separator(hide: !data.separatorVisible)
                
                \(cellSet_)
            }
        }
        """
    }
    
}
