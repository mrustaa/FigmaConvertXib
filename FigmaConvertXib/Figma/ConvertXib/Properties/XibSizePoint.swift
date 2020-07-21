//
//  XibSize.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 19.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

func xib(size: CGSize) -> String {
    return "<size key=\"value\" width=\"\(size.width)\" height=\"\(size.height)\"/>"
}

func xib(point: CGPoint) -> String {
    return "<point key=\"value\" x=\"\(point.x)\" y=\"\(point.y)\"/>"
}
