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
      guard let first = first else { return "" }
      return String(first).uppercased() + dropFirst()
    }
    /// 1 Строчная
    func firstLowercase() -> String {
      guard let first = first else { return "" }
      return String(first).lowercased() + dropFirst()
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


//MARK: - Constants
extension String {
  static let empty: String = ""
  static let whitespace: String = " "
  static let slash: String = "/"
  static let newLine: String = "\n"
  static let endLine: String = "\r\n"
  static let colon: String = ":"
  static let semicolon: String = ";"
  static let equal: String = "="
  static let and: String = "&"
}
