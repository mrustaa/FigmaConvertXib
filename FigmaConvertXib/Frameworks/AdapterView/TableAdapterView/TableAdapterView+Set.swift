//
//  TableAdapterView+Set.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 05.06.2021.
//

import UIKit

extension TableAdapterView {
  
  // MARK: Set Items
  
  public func set(items: [TableAdapterItem], animated: Bool = false, reload: Bool = true) {
    self.clear()
    items.forEach {
      self.unsafeAdd(item: $0)
    }
    if reload { reloadData(animated: animated) }
  }
  
  // MARK: - Set Rows
  
  public func set(rows items: [TableAdapterItem], with animation: UITableView.RowAnimation = .fade) {
    _ = setFull(rows: items, with: animation)
  }
  
  // MARK: Reload Data
  
  public func reloadData(animated: Bool = false) {
    animated
      ? reloadSections(IndexSet(integer: 0), with: .automatic)
      : reloadData()
  }
  
  // MARK: Clear
  
  public func clear() {
    items.removeAll()
  }
  
  // MARK: Scroll To Top
  
  public func scrollToTop() {
    self.setContentOffset(.zero, animated: true)
  }
  
}
