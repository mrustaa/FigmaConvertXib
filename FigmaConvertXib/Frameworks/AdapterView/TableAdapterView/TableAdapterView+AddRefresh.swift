//
//  TableAdapterView+AddRefresh.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 05.06.2021.
//

import UIKit

extension TableAdapterView {
    
  // MARK: Refresh Add/Did/End
  
  public func addRefreshControl() {
    let refresh = UIRefreshControl()
    refresh.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
    self.refreshControl = refresh
  }
  
  @objc func didRefresh() {
    didRefreshCallback?()
  }
  
  public func endRefreshing() {
    refreshControl?.endRefreshing()
  }
  
}
