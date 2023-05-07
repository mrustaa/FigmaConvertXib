//
//  XibFigmaViewNew+Component.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 06.11.2021.
//  Copyright © 2021 mrusta. All rights reserved.
//

import UIKit

extension FigmaNode {
    
    // MARK: - Component
    
    func xibComponent() -> String {
        
        let view = imageXib(comp: true)
        
        let rect = realFrame.xib()
        let arMask = addAutoresizingMask()
        
        //// _________________________________________________
        
        let result = view.header +
        rect +
        arMask +
        view.end
        
        return result
        
    }
}

