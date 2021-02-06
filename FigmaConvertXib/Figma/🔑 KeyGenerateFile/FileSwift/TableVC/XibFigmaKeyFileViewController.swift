//
//  XibFigmaKeyFileViewController.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 23.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension FigmaNode {
    
    // MARK: - Gen Swift ViewController
    
    func xibGenFileViewСontroller() -> String {
        
        let name_ = name.xibFilterName(type: .tableVC)
        
        return """
        import UIKit

        class \(name_)ViewController: StoryboardController {
            
            @IBOutlet weak var tableView: TableAdapterView!
            
            override func viewDidLoad() {
                super.viewDidLoad()
                
                title = "\(name_)"
                
                var items: [TableAdapterItem] = []
                // items.append( BankCollectionItem() )
                tableView.set(items: items, animated: true)
            }
        }
        """
    }
    
}
