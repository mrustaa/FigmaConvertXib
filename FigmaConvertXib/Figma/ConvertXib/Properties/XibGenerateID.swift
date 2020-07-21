//
//  XibRandomID.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 03.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

func xibID() -> String {
    
    let randomCharFirst = randomString(length: 3)
    let randomCharSecond = randomString(length: 2)
    let randomCharLast = randomString(length: 3)
    
    return "\(randomCharFirst)-\(randomCharSecond)-\(randomCharLast)"
}

private func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
}
