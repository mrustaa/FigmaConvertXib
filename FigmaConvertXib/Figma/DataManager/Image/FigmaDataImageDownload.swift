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
    
    //MARK: - 🏞⬇️ Image Download
    
    class func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    class func downloadImage(url: URL, completion: ((_ image: UIImage) -> Void)? = nil) {

        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            if let image = UIImage(data: data) {
                //  DispatchQueue.main.async() {
                    completion?(image)
                // }
            }
        }
    }
    
}
