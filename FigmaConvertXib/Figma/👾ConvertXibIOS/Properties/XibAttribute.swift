//
//  XibAttribute.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 20.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation
import UIKit

private var attrKey = "userDefinedRuntimeAttribute"
private var attrsKey = attrKey + "s"
private var subsKey = "subviews"

/// Size

func xibAttr(size: CGSize, key: String) -> String {
    return """
    <\(attrKey) type="size" keyPath="\(key)">
        \(xib(size: size))
    </\(attrKey)>
    """
}

/// Point

func xibAttr(point: CGPoint, key: String) -> String {
    return """
    <\(attrKey) type="point" keyPath="\(key)">
        \(xib(point: point))
    </\(attrKey)>
    """
}

/// Color

func xibAttr(color: UIColor, key: String) -> String {
    return """
    <\(attrKey) type="color" keyPath="\(key)">
        \(color.xib())
    </\(attrKey)>
    """
}

/// Number

func xibAttr(number: CGFloat, key: String) -> String {
    return """
    <\(attrKey) type="number" keyPath="\(key)">
        \(xib(number: number))
    </\(attrKey)>
    """
}

/// String

func xibAttr(string: String, key: String) -> String {
    return """
    <\(attrKey) type="string" keyPath="\(key)" value="\(string)"/>
    """
}

/// Image

func xibAttr(imageName: String, key: String) -> String {
    return """
    <\(attrKey) type="image" keyPath="\(key)" value="\(imageName)"/>
    """
}

/// Boolean

func xibAttr(boolean: Bool, key: String) -> String {
    return """
    <\(attrKey) type="boolean" keyPath="\(key)" value="\(boolean.xib())"/>
    """
}


//MARK: Close Attributes Subviews

func xibAttrsClose(attributes: String) -> String {
    return """
    <\(attrsKey)>\(attributes)
    </\(attrsKey)>
    """
}

func xibSubviewsClose(subviews: String) -> String {
    return """
    <\(subsKey)>\(subviews)
    </\(subsKey)>
    """
}

