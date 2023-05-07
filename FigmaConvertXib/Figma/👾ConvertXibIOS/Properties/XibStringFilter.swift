//
//  XibNameFilter.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 22.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation


extension String {
    
  
  func xibFilterRemoveKey() -> String {
    var name = xibFilter()
    for key in FigmaFileType.allCases {
      name = name.findReplace(find: key.rawValue, replace: "")
    }
    return name
  }
  
    func xibFilter() -> String {
        
        let flt1 = self.findReplace(find: "&" , replace: "&amp;" )
        let flt2 = flt1.findReplace(find: "<" , replace: "&lt;"  )
        let flt3 = flt2.findReplace(find: ">" , replace: "&gt;"  )
        let flt4 = flt3.findReplace(find: "\"", replace: "&quot;")
        let flt5 = flt4.findReplace(find: "/" , replace: ":"     )
        
        return flt5
    }
    
}
