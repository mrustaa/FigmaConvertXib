//
//  XibRect.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 03.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

extension CGRect {
    
    func xibAndroid(main: Bool = false) -> String {
        
        if main {
            // android:layout_width="match_parent"
            // android:layout_height="match_parent"
            return """
            
                android:layout_width="\(size.width)dp"
                android:layout_height="\(size.height)dp"
            """
        }
        
        return """
        
            android:layout_width="\(size.width)dp"
            android:layout_height="\(size.height)dp"
            android:layout_marginStart="\(origin.x)dp"
            android:layout_marginTop="\(origin.y)dp"
        """
    }
    
}

