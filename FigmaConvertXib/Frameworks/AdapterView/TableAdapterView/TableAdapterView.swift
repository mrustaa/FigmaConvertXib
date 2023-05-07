//
//  TableAdapterView.swift
//  PatternsSwift
//
//  Created by mrustaa on 16/04/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

open class TableAdapterView: UITableView {
    
    @IBInspectable var separatorClr: UIColor?
    
    // MARK: Callbacks
  
    public var countCallback: TableAdapterCountCallback?
    public var cellIndexCallback: TableAdapterCellIndexCallback?
    public var heightIndexCallback: TableAdapterHeightIndexCallback?
    public var selectIndexCallback: TableAdapterSelectIndexCallback?
    public var deleteIndexCallback: TableAdapterDeleteIndexCallback?
    public var didScrollCallback: TableAdapterDidScrollCallback?
    public var touchBeganCallback: (() -> ())?
    public var didRefreshCallback: (() -> ())?
  
    var canEditing: Bool = false
    
    public var items: [TableAdapterItem] = []
    
  // MARK: - Init
  
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        update()
    }
    
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        update()
    }
    
    open override func draw(_ rect: CGRect) {
        if let color = separatorClr {
            separatorColor = color
        }
    }
    
    public func update() {
        delegate = self
        dataSource = self
        
        tableFooterView = UIView()
        backgroundColor = .clear
    }
    
  // MARK: Touches Began Event
  
  open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    
    touchBeganCallback?()
  }
  
  // MARK: Bussines Logic
  
    public func unsafeAdd(item: TableAdapterItem) {
        items.append(item)
        registerNibIfNeeded(for: item)
    }
    
    public func registerNibIfNeeded(for item: TableAdapterItem) {
        let nib = UINib(nibName: item.cellReuseIdentifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: item.cellReuseIdentifier)
    }
    
    public func cellAt(_ indexPath: IndexPath) -> TableAdapterCell? {
        let item = items[indexPath.row]
        let cellIdentifier = item.cellReuseIdentifier
        let cell = self.dequeueReusableCell(withIdentifier: cellIdentifier) as? TableAdapterCell
        cell?.cellData = item.cellData
        return cell
    }
  
    func searchTable(cellClass: AnyClass) -> (indxPath: IndexPath, cell: TableAdapterCell, data: TableAdapterCellData)? {
      var index = 0
      for cell in self.visibleCells {
        if let adCell = cell as? TableAdapterCell, let data = adCell.cellData {
          if type(of: adCell) == cellClass {
            let path = IndexPath(row: index, section: 0)
            return (path, adCell, data)
          }
        }
        index += 1
      }
      return nil
    }
}

