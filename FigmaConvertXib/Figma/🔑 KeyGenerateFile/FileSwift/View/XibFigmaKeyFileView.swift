//
//  XibFigmaKeyFileView.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 23.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension FigmaNode {
    
    // MARK: - Gen Swift View
    
    func xibGenFileView(type: FigmaFileType? = nil) -> String {
        
        let name_ = name.xibFilterName(type: type ?? .view)
        
        let connections = propertyChildren(type: .cellProperty).connections
        
        let connsNames = genArr(connections, 4, true)
        
        if type == .viper {
            
            return """
            import UIKit
            
            class \(name_)View: XibView {
              
              // MARK: - IBOutlets

              @IBOutlet weak var tableView: TableAdapterView?
              @IBOutlet weak var tableTop: NSLayoutConstraint?
              @IBOutlet weak var tableBottom: NSLayoutConstraint?
            
              /// State
              var state: State? {
                didSet { stateDidChange(from: oldValue) }
              }
              
              /// Handlers
              var handlers: Handlers = .init() {
                didSet {
                  handlersDidChange()
                }
              }

              private func stateDidChange(from oldState: State?) {
                guard state != oldState else { return }
                guard let state = state else { return }
              
                if let tableItems = state.tableItems {
                
                  var tItems: [TableAdapterItem] = []
                  for item in tableItems {
                    tItems.append( item )
                  }
                  
                  if oldState?.tableItems != nil {
                    tableView?.set(rows: tItems, with: .automatic)
                  } else {
                    tableView?.set(items: tItems, animated: true)
                  }
                }
              }
              
              //MARK: Handlers Did Change
            
              public func handlersDidChange() {
                tableView?.selectIndexCallback = handlers.onItemAt
              }
            
              \(connsNames)
              
              override func setup() {
                
                backgroundColor = .clear
            
                tableTop?.constant = 0
                tableBottom?.constant = 0
                tableView?.updateInsetsTabbar()
            
                tableView?.didScrollCallback = {
                  if let cells = self.tableView?.visibleCells {
                    for cell in cells {
                      if let btnCell = cell as? MainCollectionCell {
                        btnCell.didScroll()
                      } else if let btnCell = cell as? TableAdapterCell {
                        btnCell.deselectedCell()
                      }
                    }
                  }
                }
            
              }
            }
            
            extension \(name_)View {
              
              struct State: Equatable {
                var tableItems: [TableAdapterItem]?
              }
              struct Handlers {
                var onItemAt: ((Int) -> Void)?
              }
            }

            """
            
        } else {
            
        return """
        import UIKit

        // typealias \(name_)ButtonActionCallback = () -> Void

        class \(name_)View: XibView {
            
            // MARK: - IBOutlets
            
            \(connsNames)
            // @IBOutlet weak var button: DesignButton!
            
            override func setup() {
                
            }
            
            // @IBAction func buttonClickAction(_ sender: DesignButton) {
            // }
        }
        """
        }
        
      
    }
    
}
