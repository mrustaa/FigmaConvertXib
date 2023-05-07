//
//  TableAdapterItem.swift
//  PatternsSwift
//
//  Created by mrustaa on 17/04/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

open class TableAdapterItem: NSObject {

    // MARK: Properties
    
    public let cellClass: AnyClass
    public let cellData: TableAdapterCellData?

    // MARK: Init
    
    public init(cellClass: AnyClass, cellData: TableAdapterCellData? = nil) {
        self.cellClass = cellClass
        self.cellData = cellData
    }

    // MARK: Methods

    public var cellReuseIdentifier: String {
        return String(describing: cellClass)
    }
    
    public func height() -> CGFloat {
        return cellData?.cellHeight() ?? UITableView.automaticDimension
    }

    public func canEditing() -> Bool {
        return cellData?.canEditing() ?? false
    }
    public func equals(compareTo item: TableAdapterItem) -> Bool {
      guard let itemData = item.cellData,
            let cellData = self.cellData else { return false }
      return cellData.equals(compareTo: itemData)
    }
  
    public func search(toArray: [TableAdapterItem]) -> Int? {
      for i in 0..<toArray.count {
        if let item = toArray[i] as? Self {
          if equals(compareTo: item) { return i }
        }
      }
      return nil
    }
}
