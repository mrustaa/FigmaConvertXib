//
//  TableAdapterView+AddGradient.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 05.06.2021.
//

import UIKit

private let gradientTopTag = 15125
private let gradientBottomTag = 15126

extension TableAdapterView {
  
  public func addGradientEdges(color: UIColor, top: CGFloat?, bottom: CGFloat?) {
    addGradientWhite(table: self, color: color, top: top, bottom: bottom)
  }
}

extension UIView {
  
  public func addGradientWhite(table: TableAdapterView, color: UIColor, top: CGFloat?, bottom: CGFloat?) { // .background 50
    
    let width: CGFloat = table.frame.width
    
    let topView = viewWithTag(gradientTopTag)
    if let height = top {
      if topView == nil {
        let topView = UIView(frame: CGRect(x: 0, y: table.frame.origin.y, width: width, height: height))
          topView.tag = gradientTopTag
          _ = topView.add(
            gradient: color.withAlphaComponent(1),
            color2: color.withAlphaComponent(0),
            pointStart: .zero,
            pointEnd: .init(x: 0, y: 1),
            cornerRadius: 0
          )
        
        addSubview(topView)
      }
    } else {
      topView?.removeFromSuperview()
    }
    
    let bottomView = viewWithTag(gradientBottomTag)
    if let height = top {
      if bottomView == nil {
        let bottomView = UIView(frame: CGRect(x: 0, y: table.frame.height - height, width: width, height: height))
          bottomView.tag = gradientBottomTag
          _ = bottomView.add(
            gradient: color.withAlphaComponent(0),
            color2: color.withAlphaComponent(1),
            pointStart: .zero,
            pointEnd: .init(x: 0, y: 1),
            cornerRadius: 0
          )
        
        addSubview(bottomView)
      }
    } else {
      bottomView?.removeFromSuperview()
    }
  }
}



