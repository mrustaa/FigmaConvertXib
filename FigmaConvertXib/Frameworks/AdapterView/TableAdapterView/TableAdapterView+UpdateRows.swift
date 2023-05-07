//
//  TableAdapterView+UpdateRows.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 31.05.2021.
//

import UIKit

extension TableAdapterView {
  
  // MARK: - Set Rows
  
  public func setFull(rows items: [TableAdapterItem], with animation: UITableView.RowAnimation = .fade) -> (insert: [IndexPath], delete: [IndexPath]) {
    
    let newItems = items
    let oldItems = self.items
    
    set(items: items, animated: false, reload: false)
    
    var insertRows: [IndexPath] = []
    var deleteRows: [IndexPath] = []
    
    var i = 0
    for old in oldItems {
      
      let findIndex = old.search(toArray: newItems)
      if findIndex == nil {
        deleteRows.append( IndexPath(row: i, section: 0) )
      }
      i += 1
    }
    
    i = 0
    for new in newItems {
      let findIndex = new.search(toArray: oldItems)
      if findIndex == nil {
        insertRows.append( IndexPath(row: i, section: 0) )
      }
      i += 1
    }
    
    let delete = (0 < deleteRows.count)
    let insert = (0 < insertRows.count)
    
    if (delete && insert) {
      self.reloadSections(IndexSet(integersIn: 0...0), with: animation)
    } else {
      if delete {
        self.deleteRows(at: deleteRows, with: animation)
      } else if insert {
        self.insertRows(at: insertRows, with: animation)
      }
    }
    
    return (insertRows, deleteRows)
  }
  
}
