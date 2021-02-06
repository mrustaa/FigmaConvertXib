//
//  XibBool.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 03.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

extension Bool {
    
    func xib() -> String {
        return (self ? "YES" : "NO")
    }
}
