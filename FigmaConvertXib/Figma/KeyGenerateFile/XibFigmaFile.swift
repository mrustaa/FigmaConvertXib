//
//  XibFigmaFileCell.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 02.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

enum FigmaFileType: String {
    case cell = "figmaXib:Cell"
    case view = "figmaXib:View"
    case button = "figmaXib:Button"
}


extension String {
    
    func xibFilterName(type: FigmaFileType) -> String {
        
        let key = type.rawValue
        
        let removeKey       = findReplace(find: key, replace: "")
        let removeSpaces    = removeKey.removeSpaces()
        let firstUppercase  = removeSpaces.firstUppercase()
        let name_ = firstUppercase
        
        return name_
    }
}

extension FigmaNode {
    
    func searchKeys()  {
        
        if name.find(find: FigmaFileType.cell.rawValue) {
            
            let path = FigmaData.pathXib()
            let name_ = name.xibFilterName(type: .cell)
            
            guard let folder = FigmaData.createFolder(path: path, name: name_) else { return }
            // ---------------------------------------------------------------
            let swiftFileCode = xibGenFileCell()
            let swiftName = name_ + ".swift"
            
            FigmaData.save(text: swiftFileCode,
                           toDirectory: folder,
                           withFileName: swiftName)
            // ---------------------------------------------------------------
            
            let xibFileCode = xibNew(main: true, cell: true)
            let xibName = name_ + ".xib"
            
            FigmaData.save(text: xibFileCode,
                           toDirectory: folder,
                           withFileName: xibName)
            // ---------------------------------------------------------------
        }
        
        if type != .component {
            for node: FigmaNode in children {
                if node.visible,
                   node.type != .vector,
                   node.type != .booleanOperation {
                    
                    node.searchKeys()
                }
            }
        }
    }
    
    
    func xibGenFileCell() -> String {
        
        let name_ = name.xibFilterName(type: .cell)
        
        return """
        import UIKit
        
        // MARK: - Item

        class \(name_)Item: TableAdapterItem {
            
            init(title: String? = nil,
                 subtitle: String? = nil,
                 separator: Bool = false,
                 touchAnimationHide: Bool = false,
                 editing: Bool = false,
                 clickCallback: (() -> ())? = nil) {
                
                let cellData = \(name_)CellData(title, subtitle, separator, touchAnimationHide, editing, clickCallback)
                
                super.init(cellClass: \(name_)Cell.self, cellData: cellData)
            }
        }

        // MARK: - Data

        class \(name_)CellData: TableAdapterCellData {
            
            // MARK: Properties
            
            var title: String?
            var subtitle: String?
        
            var separatorVisible: Bool
            var touchAnimationHide: Bool
            var editing: Bool
            
            // MARK: Inits
            
            init(_ title: String? = nil,
                 _ subtitle: String? = nil,
                 _ separator: Bool,
                 _ touchAnimationHide: Bool,
                 _ editing: Bool,
                 _ clickCallback: (() -> ())?) {
                
                self.title = title
                self.subtitle = subtitle
                
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
            
            @IBOutlet private weak var titleLabel: UILabel?
            @IBOutlet private weak var subtitleLabel: UILabel?

            @IBOutlet override var selectedView: UIView? { didSet { } }
            @IBOutlet private weak var separatorView: UIView?
            @IBOutlet private weak var separatorHeightConstraint: NSLayoutConstraint?
            
            // MARK: Initialize
            
            override func awakeFromNib() {
                separatorView?.backgroundColor = .clear
                separatorHeightConstraint?.constant = 0.5
            }
            
            override func fill(data: TableAdapterCellData?) {
                guard let data = data as? \(name_)CellData else { return }
                self.data = data
                
                self.hideAnimation = data.touchAnimationHide
                separatorView?.isHidden = !data.separatorVisible
                
                titleLabel?.text = data.title
                subtitleLabel?.text = data.subtitle
                
            }
        }
        """
    }
    
}



