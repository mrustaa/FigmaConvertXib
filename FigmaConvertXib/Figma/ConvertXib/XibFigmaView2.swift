//
//  XibFigmaView2.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 30.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

extension FigmaNode {

    func xib2() -> (String, String) {
        
        
        
        if type == .star {
            
        }
        
        
        var headerEnd  = ("", "")
        
        if type == .component {
            
            headerEnd = imageXib(comp: true)
            
        } else if type == .text {
            
            headerEnd = labelXib()
            
        } else if (realRadius != 0) || (strokes.count == 1) {
            
            headerEnd = designFigureXib()
            
        } else {
            
            headerEnd = viewXib()
        }
        
        
        
        return ("", "")
    }
}
