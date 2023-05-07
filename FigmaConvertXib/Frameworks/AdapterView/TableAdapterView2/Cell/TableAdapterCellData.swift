//
//  TableAdapterCellData.swift
//  PatternsSwift
//
//  Created by mrustaa on 17/04/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

open class TableAdapterCellData: NSObject {
    
    open var cellClickCallback: (() -> ())?
    
    public init(_ cellClickCallback: (() -> ())? = nil) {
        self.cellClickCallback = cellClickCallback
    }
    
    open func cellHeight() -> CGFloat {
        return UITableView.automaticDimension
    }
    
    open func canEditing() -> Bool {
        return false
    }
    
}
