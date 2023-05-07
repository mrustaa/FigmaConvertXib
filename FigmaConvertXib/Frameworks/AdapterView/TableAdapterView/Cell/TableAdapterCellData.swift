//
//  TableAdapterCellData.swift
//  PatternsSwift
//
//  Created by mrustaa on 17/04/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit


open class TableAdapterCellData: NSObject {

    // MARK: Properties

    open var separatorVisible: Bool = false
    open var touchAnimationHide: Bool = false
    open var editing: Bool = false
    open var cellClickCallback: (() -> ())?

    // MARK: Init
    
    init(_ separator: Bool? = false,
         _ touchAnimationHide: Bool? = false,
         _ editing: Bool? = false,
         _ clickCallback: (() -> ())? = nil) {
    
        self.separatorVisible = separator ?? false
        self.touchAnimationHide = touchAnimationHide ?? false
        self.editing = editing ?? false
        self.cellClickCallback = clickCallback
        // self.cellClickCallback = state.handlers.onClickAt
    }

    // MARK: Methods
  
    open func calculateLabel(text: String?, font: UIFont? = nil, x: CGFloat = 16.0) -> CGFloat {
      type(of: self).classCalculateLabel(text: text, font: font, x: x).height
    }
    
    open class func classCalculateLabel(text: String?, font: UIFont? = nil, lines: Int = 99, x: CGFloat = 16.0) -> CGRect {
      if let text = text {
          let lbl = UILabel(frame: CGRect(x: x, y: 0, width: (Device.width - (x * 2)), height: 10))
          lbl.tag = 0
          lbl.font = font ?? UIFont.systemFont(ofSize: 18) //TTNorms.regular.size(.subtitle)
          lbl.text = text
          lbl.numberOfLines = lines
          lbl.textAlignment = .center
          lbl.sizeToFit()
          return lbl.frame
      } else {
        return .zero
      }
    }
  
    open func cellHeight() -> CGFloat {
        return UITableView.automaticDimension
      // let calcHeight = calculateLabel(
      //   text: state.titleText,
      //   padding: 16,
      //   titleFont: SFProText.regular.size(.headline)
      // )
    }

    open func canEditing() -> Bool {
        return false
    }
    
    open func equals(compareTo data: TableAdapterCellData) -> Bool {
        return false
    }
    
    open func dataStr() -> String {
      return ""
    }
}
