//
//  TableAdapterView+Delegate.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 05.06.2021.
//

import UIKit

// MARK: - Delegate

extension TableAdapterView: UITableViewDelegate {
  
  /// height
  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if !items.isEmpty {
      return items[indexPath.row].height()
    }
    if let heightIndexCallback = heightIndexCallback {
      return heightIndexCallback(indexPath.row)
    }
    return 0
  }
  
  /// select
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    selectIndexCallback?(indexPath.row)
  }
  
}
