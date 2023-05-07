//
//  TableAdapterView+ScrollDelegate.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 05.06.2021.
//

import UIKit

extension TableAdapterView: UIScrollViewDelegate {
  
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    didScrollCallback?()
  }
}

