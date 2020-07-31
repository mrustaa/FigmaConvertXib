//
//  String.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 25.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension String {
    
    // поиск в тексте  слова
    func find(find: String) -> Bool{
        return range(of: find) != nil
    }
    
    // поиск в тексте  слова и замена
    func findReplace(find: String, replace: String) -> String {
        return replacingOccurrences(of: find, with: replace)
    }
    
    // поиск слова в тексте    ингнорирование заглавных сточных
    func containsIgnoringCase(_ find: String) -> Bool{
        return range(of: find, options: .caseInsensitive) != nil
    }
    
    // получение (Int) понятного индекса из (String.Index)
    func mydistance(_ index: String.Index) -> String.IndexDistance {
        return distance(from: startIndex, to: index)
    }
    
    
}

