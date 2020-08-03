//
//  String.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 25.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension String {
    
    /// Найти
    func find(find: String) -> Bool{
        return range(of: find) != nil
    }
    
    /// Найти Заменить
    func findReplace(find: String, replace: String) -> String {
        return replacingOccurrences(of: find, with: replace)
    }
    
    /// 1 Заглавная
    func firstUppercase() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    // поиск слова в тексте    ингнорирование заглавных сточных
    func containsIgnoringCase(_ find: String) -> Bool {
        return range(of: find, options: .caseInsensitive) != nil
    }
    
    // получение (Int) понятного индекса из (String.Index)
    func mydistance(_ index: String.Index) -> String.IndexDistance {
        return distance(from: startIndex, to: index)
    }
    
    /// Удаление пробелов
    func removeSpaces() -> String  {
        return trimmingCharacters(in: .whitespaces)
    }
}

