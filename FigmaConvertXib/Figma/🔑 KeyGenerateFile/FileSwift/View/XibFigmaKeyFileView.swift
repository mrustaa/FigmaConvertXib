//
//  XibFigmaKeyFileView.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 23.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension FigmaNode {
    
    // MARK: - Gen Swift View
    
    func xibGenFileView() -> String {
        
        let name_ = name.xibFilterName(type: .view)
        
        let connections = propertyChildren(type: .cellProperty).connections
        
        let connsNames = genArr(connections, 4, true)
        
        return """
        import UIKit

        // typealias \(name_)ButtonActionCallback = () -> Void

        class \(name_)View: XibView {
            
            // MARK: - IBOutlets
            
            \(connsNames)
            // @IBOutlet weak var button: DesignButton!
            
            override func loadedFromNib() {
                
            }
            
            // @IBAction func buttonClickAction(_ sender: DesignButton) {
            // }
        }
        """
    }
    
}
