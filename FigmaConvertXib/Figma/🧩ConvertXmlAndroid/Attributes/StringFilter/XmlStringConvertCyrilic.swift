//
//  XmlStringConvertCyrilicToLatin.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 22.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension String {

    var convertCyrillicToLatin: String {
        return XmlStringConvertCyrilic.getLatin(wordInCyrillic: self)
    }
}

class XmlStringConvertCyrilic {

    public static func getLatin(wordInCyrillic: String) -> String {
        
        if wordInCyrillic.isEmpty { return wordInCyrillic }
    
        let characters = Array(wordInCyrillic)
        var wordInLatin: String = ""
        for i in 0...characters.capacity-1 {
            
            let char: Character = characters[i]
            let charStr: String = "\(char)"
            
            if isCyrillic(characters: char) {                   /// 1. (Character Cyrillic ❓) => (Add) Convert Latin
                wordInLatin += cyrillicToLatinMap[char] ?? ""
            } else if charStr.isLatin {                         /// 2. (Character Latin ❓) => (Add)
                if char.isUppercase {
                    wordInLatin += "_\(char.lowercased())"      /// 3. (Character Uppercase ❓) => (Add) _ + lowercase
                } else {
                    wordInLatin += "\(char)"
                }
            } else if char.isNumber {                           /// 4. (Character Number ❓) => (Add)
                wordInLatin += "\(char)"
            }
        }
        return wordInLatin
    }
    
    public static func isCyrillic(characters: Character) -> Bool {
        var isCyrillic: Bool = true;
        for (key,_) in cyrillicToLatinMap {
            isCyrillic = (key == characters)
            if isCyrillic {
                break
            }
        }
        return isCyrillic
    }
    
}


let cyrillicToLatinMap: [Character : String] = [
//  Uppercase   Lowercase
    " ":" ",
    "А":"A",    "а":"a",
    "Б":"B",    "б":"b",
    "В":"V",    "в":"v",
    "Г":"G",    "г":"g",
    "Д":"D",    "д":"d",
    "Е":"E",    "е":"e",
    "Ж":"Zh",   "ж":"zh",
    "З":"Z",    "з":"z",
    "И":"I",    "и":"i",
    "Й":"Y",    "й":"y",
    "К":"K",    "к":"k",
    "Л":"L",    "л":"l",
    "М":"M",    "м":"m",
    "Н":"N",    "н":"n",
    "О":"O",    "о":"o",
    "П":"P",    "п":"p",
    "Р":"R",    "р":"r",
    "С":"S",    "с":"s",
    "Т":"T",    "т":"t",
    "У":"U",    "у":"u",
    "Ф":"F",    "ф":"f",
    "Х":"H",    "х":"h",
    "Ц":"Ts",   "ц":"ts",
    "Ч":"Ch",   "ч":"ch",
    "Ш":"Sh",   "ш":"sh",
    "Щ":"Sht",  "щ":"sht",
    "Ь":"Y",    "ь":"y",
    "Ъ":"A",    "ъ":"a",
    "Ы":"I",    "ы":"i",
    "Ю":"Yu",   "ю":"yu",
    "Я":"Ya",   "я":"ya",
]


extension String {
    
    var isLatin: Bool {
        
        let upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let lower = "abcdefghijklmnopqrstuvwxyz"

        for c in self.map({ String($0) }) {
            if !upper.contains(c) && !lower.contains(c) {
                return false
            }
        }

        return true
    }

    var isCyrillic: Bool {
        let upper = "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЮЯ"
        let lower = "абвгдежзийклмнопрстуфхцчшщьюя"

        for c in self.map({ String($0) }) {
            if !upper.contains(c) && !lower.contains(c) {
                return false
            }
        }

        return true
    }

    var isBothLatinAndCyrillic: Bool {
        
        
        
        return self.isLatin && self.isCyrillic
    }
}
