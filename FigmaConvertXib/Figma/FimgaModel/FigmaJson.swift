//
//  FigmaJson.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 26.06.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension DateFormatter {
  static let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'";// "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ" // 2010-11-19T
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}


struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

func dDouble(_ json: [String:Any], _ key: String) -> Double {
    if let value = json[key] as? Double {
        return value
    } else {
        return 0.0
    }
}

func dInt(_ json: [String:Any], _ key: String) -> Int {
    if let value = json[key] as? Int {
        return value
    } else {
        return 0
    }
}

func dString(_ json: [String:Any], _ key: String) -> String {
    if let value = json[key] as? String {
        return value
    } else {
        return ""
    }
}

func dURL(_ json: [String:Any], _ key: String) -> URL? {
    if let value = json[key] as? String {
        return URL(string: value)
    } else {
        return nil
    }
}


func dDate(_ json: [String:Any], _ key: String) -> Date? {
    if let value = json[key] as? String {
        return DateFormatter.formatter.date(from: value)
    } else {
        return nil
    }
}

func dDict(_ json: [String:Any], _ key: String) -> [String: Any]? {
    if let value = json[key] as? [String: Any] {
        return value
    } else {
        return nil
    }
}

func dArr(_ json: [String:Any], _ key: String) -> [ [String: Any] ]? {
    if let value = json[key] as? [ [String: Any] ] {
        return value
    } else {
        return nil
    }
}

