//
//  XibNameFilter.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 22.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension String {
    
    
    func xmlFilter() -> String {
        
        let flt1 = self.xibFilter()
        
        let flt2 = flt1.removeEmoji()
        
        let flt3 = flt2.convertCyrillicToLatin // flt2.encodeUrl
        
        let flt4 = flt3.lowercased()
        
        let flt5 = flt4.findReplace(find: " " , replace: "_")
        
        return flt5
    }
    
}
