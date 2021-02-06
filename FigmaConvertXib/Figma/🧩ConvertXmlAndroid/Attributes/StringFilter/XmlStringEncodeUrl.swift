//
//  XmlStringEncodeUrl.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 22.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension String {
    
    var encodeUrl : String { encodeUrl() }
    
    func encodeUrl(_ c: CharacterSet = .urlQueryAllowed) -> String {
        self.addingPercentEncoding(withAllowedCharacters: c)!
    }
    
    var decodeUrl : String { self.removingPercentEncoding! }
}
