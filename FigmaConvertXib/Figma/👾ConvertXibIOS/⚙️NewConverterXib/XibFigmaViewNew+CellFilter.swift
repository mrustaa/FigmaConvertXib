//
//  XibFigmaViewNew+CellFilter.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 06.11.2021.
//  Copyright © 2021 mrusta. All rights reserved.
//

import UIKit

extension FigmaNode {
    
    // MARK: - Cell Filter
    
    func viewCellFilter(
        keyType: FigmaFileType? = nil,
        curView: (header: String, end: String)
    ) -> (
        view: (header: String, end: String),
        findKey: FigmaFileType?,
        rect: String,
        connections: String
    ) {
        
        var view = curView
        var connections: String = ""
        var rect: String = realFrame.xib()
        var findKey: FigmaFileType? = nil
        
        if let keyType = keyType {
            
            if keyType == .cell, name.find(find: FigmaFileType.cell.rawValue) {
                findKey = .cell
                
                let cell = cellXib(rect: realFrame)
                
                view.header = cell.header
                view.end    = cell.end
                
                connections = cell.connections
                
                rect = realFrame.xibBound()
                
            } else if keyType == .collection, name.find(find: FigmaFileType.collection.rawValue) {
                findKey = .collection
                
                let cell = collectionCellXib(rect: realFrame)
                
                view.header = cell.header
                view.end    = cell.end
                
                connections = cell.connections
                
                rect = realFrame.xibBound()
            }
            
        }
        return (view, findKey, rect, connections)
    }
    
    
    
}

