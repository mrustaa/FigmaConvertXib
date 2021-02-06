//
//  FigmaDataClearFolder.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 25.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation
import UIKit

extension FigmaData {
    
     class func saveImage(image: UIImage, name: String) {
         saveImageXcassets(image: image, name: name)
         saveImageAndroid(image: image, name: name)
     }

}
