//
//  TableAdapterView+DataSource.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 05.06.2021.
//

import UIKit

// MARK: - DataSource

extension TableAdapterView: UITableViewDataSource {
  
  /// count
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if !items.isEmpty {
      return items.count
    }
    if let countCallback = countCallback {
      return countCallback()
    }
    return 0
  }
  
  /// cell
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if !items.isEmpty {
      let item = items[indexPath.row]
      let cell = cellAt(indexPath)
      cell?.fill(data: item.cellData)
      return cell ?? UITableViewCell()
    }
    if let cellIndexCallback = cellIndexCallback {
      return cellIndexCallback(indexPath.row)
    }
    return UITableViewCell()
  }
  
  
  public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    if !items.isEmpty {
      let item: TableAdapterItem = items[indexPath.row]
      return item.canEditing()
    }
    return false
  }
  
  public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
    if editingStyle == .delete {
      items.remove(at: indexPath.row)
      self.beginUpdates()
      self.deleteRows(at: [indexPath], with: .automatic)
      self.endUpdates()
      
      deleteIndexCallback?(indexPath.row)
    }
  }
  
}
