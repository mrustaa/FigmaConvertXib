//
//  XibFigmaViewNew.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 30.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

extension FigmaNode {

    // MARK: Xib
    
  func currentTypeCell(keyType: FigmaFileType? = nil) -> Bool {
    
    if let keyType = keyType {
      if  ((keyType == .cell)       && name.find(find: FigmaFileType.cell.rawValue)) ||
          ((keyType == .collection) && name.find(find: FigmaFileType.collection.rawValue)) {
        return true
      }
    }
    return false
  }
  
  func xibNew(main: Bool = true, keyType: FigmaFileType? = nil, superFrame: CGRect = .zero) -> (view: String, constraints: String) {
        
        var view = ""
        var constraints = ""
        
        //// _________________________________________________
        
        switch type {
            
        case .star, .ellipse, .regularPolygon,              /// figure
             .document, .page, .frame, .group, .rectangle:  /// view
            
          let r = xibFigure(main: main, keyType: keyType, superFrame: superFrame)
          view = r.view
          constraints = r.constraints
          
        case .text:
            
          let r = xibLabel(superFrame: superFrame)
          view = r.view
          constraints = r.constraints
          
        case .component:
            
            view = xibComponent()
            
        default: break
        }
        
        /// _Main _________________________________________________
        
        var mHeader = ""
        var mEnd    = ""
        
        if main {
            
            var m = xibMain()
            if keyType == .view || keyType == .table {
                
                var name_ = name.xibFilterName(type: .view) + "View"
                
              if name_.find(find: "FigmaXib:Viper ") {
                name_ = name_.findReplace(find: "FigmaXib:Viper ", replace: "")
              }
              
              if keyType == .table {
                m = xibMain(customClass: name_, connections: getConnetctionsTable())
              } else {
                let cell = currentTypeCell(keyType: keyType)
                m = xibMain(customClass: name_, connections: getConnetctions(cell: cell))
              }
            }
            
            mHeader = m.header
            mEnd = m.resources + xibSearchImagesSize() + m.end
        }
        
        //// _________________________________________________
        
        let result = (mHeader + view + mEnd)
        
        return (result, constraints)
    }
    
    
}


