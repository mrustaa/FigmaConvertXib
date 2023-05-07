//
//  XibConstraints.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 15.08.2021.
//  Copyright © 2021 mrusta. All rights reserved.
//

import UIKit

extension FigmaNode {
  
  func xibConstraintsClose(value: String) -> String {
    return """
    
    <constraints>
        \(value)
    </constraints>
    
    """
  }
  
    func xibConstraintsAll(curId: String? = nil, mainId: String? = nil, first: Bool = false, superFrame: CGRect = .zero) -> (origin: String, size: String) {
        
    let cID    = curId  ?? xibId
    let mainID = mainId ?? Self.mainId
    
    let superFr = superFrame
    let realFr  = realFrame
    
    let w = superFr.size.width  == realFr.size.width
    let h = superFr.size.height == realFr.size.height
    let equal = w && h
    
    
    if equal || first {
      
      return ("""
          <constraint firstItem="\(cID)" firstAttribute="leading"  secondItem="\(mainID)" secondAttribute="leading"  id="\(xibID())"/>
          <constraint firstItem="\(cID)" firstAttribute="top"      secondItem="\(mainID)" secondAttribute="top"      id="\(xibID())"/>
          <constraint                    firstAttribute="trailing" secondItem="\(cID)"    secondAttribute="trailing" id="\(xibID())"/>
          <constraint                    firstAttribute="bottom"   secondItem="\(cID)"    secondAttribute="bottom"   id="\(xibID())"/>
      """, "")
    }
    
    let finalLeading = realFr.origin.x
    let leading      = finalLeading != 0 ? "constant=\"\(finalLeading)\"" : ""
    
    let finalTop     = realFr.origin.y
    let top          =    finalTop  != 0 ? "constant=\"\(finalTop)\"" : ""
    
    let resultWidth   = superFr.size.width - realFr.size.width
    let finalTrailing = resultWidth - realFr.origin.x
    let trailing      = resultWidth  != 0 ? "constant=\"\(finalTrailing)\"" : ""
    
    let resultHeight = superFr.size.height - realFr.size.height
    let finalBottom  = resultHeight - realFr.origin.y
    let bottom       = resultHeight != 0 ? "constant=\"\(finalBottom)\"" : ""
    
    if type == .text {
      
      if finalLeading < finalTrailing {
        return ("""
          <constraint firstItem="\(cID)" firstAttribute="leading"  secondItem="\(mainID)" secondAttribute="leading"  \(leading)  id="\(xibID())"/>
          <constraint firstItem="\(cID)" firstAttribute="top"      secondItem="\(mainID)" secondAttribute="top"      \(top)      id="\(xibID())"/>
      """, "")
      } else {
        return ("""
          <constraint                    firstAttribute="trailing" secondItem="\(cID)"    secondAttribute="trailing" \(trailing) id="\(xibID())"/>
          <constraint firstItem="\(cID)" firstAttribute="top"      secondItem="\(mainID)" secondAttribute="top"      \(top)      id="\(xibID())"/>
      """, "")
      }
      
    }
    
      var constraintsSize = ""
      
      var resultA = ""
        var resultLeadTral = finalLeading - finalTrailing
        if resultLeadTral < 0 {
            resultLeadTral = resultLeadTral * -1
        }
      if resultLeadTral < 10 {
          resultA = """
          <constraint firstItem="\(cID)" firstAttribute="leading"  secondItem="\(mainID)" secondAttribute="leading"  \(leading)  id="\(xibID())"/>
          <constraint                    firstAttribute="trailing" secondItem="\(cID)"    secondAttribute="trailing" \(trailing) id="\(xibID())"/>
        """
      } else {
          
          if finalLeading < finalTrailing {
              resultA = """
                <constraint firstItem="\(cID)" firstAttribute="leading"  secondItem="\(mainID)" secondAttribute="leading"  \(leading)  id="\(xibID())"/>
              """
          } else {
              resultA = """
                <constraint                    firstAttribute="trailing" secondItem="\(cID)"    secondAttribute="trailing" \(trailing) id="\(xibID())"/>
              """
          }
          
          
          constraintsSize = """
          <constraint firstAttribute="width" constant="\(realFr.size.width)" id="\(xibID())"/>
        """
      }
      
      var resultB = ""
        
        var resultTopBottom = finalTop - finalBottom
        if resultTopBottom < 0 {
            resultTopBottom = resultTopBottom * -1
        }
      if resultTopBottom < 10 {
          resultB = """
          <constraint firstItem="\(cID)" firstAttribute="top"      secondItem="\(mainID)" secondAttribute="top"      \(top)      id="\(xibID())"/>
          <constraint                    firstAttribute="bottom"   secondItem="\(cID)"    secondAttribute="bottom"   \(bottom)   id="\(xibID())"/>
        """
      } else {
          
          if finalTop < finalBottom {
              resultB = """
                <constraint firstItem="\(cID)" firstAttribute="top"      secondItem="\(mainID)" secondAttribute="top"      \(top)      id="\(xibID())"/>
              """
          } else {
              resultB = """
                <constraint                    firstAttribute="bottom"   secondItem="\(cID)"    secondAttribute="bottom"   \(bottom)   id="\(xibID())"/>
              """
          }
          
          constraintsSize += """
          <constraint firstAttribute="height" constant="\(realFr.size.height)" id="\(xibID())"/>
        """
      }
      
      return (resultA + resultB, constraintsSize)
      
  }
  
}
