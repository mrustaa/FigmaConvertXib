//
//  XibFigmaKeyFileCellCollection.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 23.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension FigmaNode {
    
    // MARK: - Gen Swift Cell Collection
    
    func xibGenFileCollectionCell() -> String {
        
        let name_ = name.xibFilterName(type: .collection)
        
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
        
        class \(name_)Item: CollectionAdapterItem {
            
            init(\(initItem_)clickCallback: (() -> Void)? = nil) {
                
                let cellData = \(name_)CellData(\(initData_)clickCallback: clickCallback)
                
                super.init(cellClass: \(name_)Cell.self, cellData: cellData)
            }
        }


        class \(name_)CellData: CollectionAdapterCellData {
            
            // MARK: Properties
            
            \(dataProperty_)
            public var clickCallback: (() -> Void)?
            
            // MARK: Inits
            
            public init (\(initItem_)
                         clickCallback: (() -> Void)?) {
                
                \(dataSet_)
                self.clickCallback = clickCallback
                
                super.init()
            }
            
            override public func size() -> CGSize {
                return CGSize(width: \(realFrame.width), height: \(realFrame.height))
            }
        }

        class \(name_)Cell: CollectionAdapterCell {
            
            // MARK: Properties
            
            public var data: \(name_)CellData?
            
            // MARK: Outlets
        
            \(connsNames)
            
            override func awakeFromNib() { }
            
            override func fill(data: Any?) {
                guard let data = data as? \(name_)CellData else { return }
                self.data = data
        
                \(cellSet_)
            }
        }
        
        """
    }
    
}
