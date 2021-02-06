//
//  XmlStringRemoveEmoji.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 22.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension String {
    
    func removeEmoji() -> String {
        return String(self.filter { !$0.isEmoji() })
    }
    
}

extension Character {
    
    fileprivate func isEmoji() -> Bool {
        return Character(UnicodeScalar(UInt32(0x1d000))!) <= self && self <= Character(UnicodeScalar(UInt32(0x1f77f))!)
            || Character(UnicodeScalar(UInt32(0x2100))!) <= self && self <= Character(UnicodeScalar(UInt32(0x26ff))!)
    }
    
}
