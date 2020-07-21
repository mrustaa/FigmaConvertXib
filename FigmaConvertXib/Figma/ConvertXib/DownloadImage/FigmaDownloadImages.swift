//
//  FigmaDownloadImages.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 10.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

extension FigmaNode {
    
    func downloadImages(URLs: [String: String]) {
        
        if let imageFill = imageFill() {
            
            if let imageURL = URLs[imageFill.imageRef] {
                let url = URL(string: imageURL)!
                
                FigmaData.downloadImage(url: url, completion: { [weak self] (image: UIImage) in
                    guard let _self = self else { return }
                    FigmaData.saveImage(image: image, imageRef: _self.name)
                })
            }
        }
        
        if !subviews.isEmpty {
            for oneFigmaNode: FigmaNode in subviews {
                if oneFigmaNode.visible,
                    oneFigmaNode.type != .vector,
                    oneFigmaNode.type != .booleanOperation {
                    
                    oneFigmaNode.downloadImages(URLs: URLs)
                }
            }
        }
        
    }

}
