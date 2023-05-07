//
//  XibFigmaKeyFileCell.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 23.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation


extension FigmaNode {
  
  func xibGenFileCellPlus() -> String {
    
    
    let name_ = name.xibFilterName(type: .cell)
    
    let connections  = propertyChildren(type: .cellProperty).connections
    let connsNames    = genArr(connections,  2, true)
    
//    let initItem     = propertyChildren(type: .initItem).connections
//    let initItem_     = genArr(initItem,     9, true)
    
//    let initData     = propertyChildren(type: .initData).connections
//    let initData_     = genArr(initData,    36, true)
    
    let dataProperty = propertyChildren(type: .dataProperty).connections
    let dataProperty_ = genArr(dataProperty, 4, true)
    
//    let dataSet      = propertyChildren(type: .dataSet).connections
//    let dataSet_      = genArr(dataSet,      8, true)
    
    let cellSet      = propertyChildren(type: .cellState).connections
    let cellSet_      = genArr(cellSet,      4, true)
    
    
    let new = """
           import UIKit
           
           // MARK: - State
           
           extension \(name_)Item {
             struct State {
               \(dataProperty_)var handlers: Handlers = .init()
             }
             struct Handlers {
               var onClickAt: (()->(Void))?
             }
           }
           
           // MARK: - Item
           
           class \(name_)Item: TableAdapterItem {
             init(state: \(name_)Item.State) {
               let cellData =  \(name_)CellData(state: state)
               super.init(cellClass: \(name_)Cell.self, cellData: cellData)
             }
           }
           
           // MARK: - Data
           
           class \(name_)CellData: TableAdapterCellData {
           
             var state: \(name_)Item.State
           
             init(state: \(name_)Item.State) {
               self.state = state
               super.init()
               // self.cellClickCallback = state.handlers.onClickAt
             }
             
             override public func cellHeight() -> CGFloat {
               // let calcHeight = calculateLabel(
               //   text: state.titleText,
               //   padding: 16,
               //   titleFont: SFProText.regular.size(.headline)
               // )
               return Self.cHeight()
             }
             
             public static func cHeight() -> CGFloat  {
               return \(realFrame.height)
             }
           
             override public func canEditing() -> Bool {
               return editing
             }
           }
           
           // MARK: - Cell
           
           class \(name_)Cell: TableAdapterCell {
             
             public var data: \(name_)CellData?
             
             \(connsNames)
             @IBOutlet override var selectedView: UIView? { didSet { } }
             @IBOutlet var cardView: UIView?
             @IBOutlet var button: UIButton?
             
             override func awakeFromNib() {
               separator(hide: true)
               button?.tapHideAnimation(
                 view: cardView,
                 type: .alpha(0.5),
                 callback: { [weak self] type in
                   if type == .touchUpInside {
                     self?.data?.state.handlers.onClickAt?()
                   }
                 }
               )
             }
             
             override func fill(data: TableAdapterCellData?) {
               guard let data = data as? \(name_)CellData else { return }
               self.data = data
               \(cellSet_)
             }
           }
           """
    
    let old = """
           import UIKit
           
           // MARK: - State
           
           extension \(name_)Item {
             struct State: Equatable {
               \(dataProperty_)
             }
           }
           
           // MARK: - Item
           
           class \(name_)Item: TableAdapterItem {
           
             init(state: \(name_)Item.State,
                  clickCallback: (() -> ())? = nil) {
           
               let cellData =  \(name_)CellData(state: state,
                                             clickCallback: clickCallback)
               super.init(cellClass: \(name_)Cell.self, cellData: cellData)
             }
           }
           
           // MARK: - Data
           
           class \(name_)CellData: TableAdapterCellData {
           
             // MARK: Properties
           
             var state: \(name_)Item.State
             var clickCallback: (() -> ())?
             
             // MARK: Inits
           
             init(state: \(name_)Item.State,
                  clickCallback: (() -> ())?) {
               self.state = state
               self.clickCallback = clickCallback
           
               super.init()
               // self.cellClickCallback = clickCallback
             }
             
             override public func cellHeight() -> CGFloat {
           
             // let calcHeight = calculateLabel(
             //   text: state.titleText,
             //   padding: 16,
             //   titleFont: SFProText.regular.size(.headline)
             // )
           
               return Self.cHeight() // \(realFrame.height)
             }
             
             public static func cHeight() -> CGFloat  {
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
             
             @IBOutlet var cardView: DesignFigure! // UIView
             @IBOutlet var button: UIButton?
           
             // MARK: Initialize
             
             override func awakeFromNib() {
               separator(hide: true)
           
               button?.tapHideAnimation(
                 view: cardView,
                 type: .alpha(0.5),
                 callback: { [weak self] type in
                   if type == .touchUpInside {
                     self?.data?.clickCallback?()
                   }
                 }
               )
             }
             
             override func fill(data: TableAdapterCellData?) {
               guard let data = data as? \(name_)CellData else { return }
               self.data = data
               
               \(cellSet_)
             }
           }
           """
    return new
  }
  
}

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
