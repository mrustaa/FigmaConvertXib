//
//  URLRequest.swift
//  PushSwift
//
//  Created by Рустам Мотыгуллин on 24.10.2021.
//

import Foundation
import UIKit

enum StatusCode {
  static let success = 200
  static let created = 201
  static let defaulErrorCode = 400
  static let sessionExpired = 401
  static let forbidden = 403
  static let resourceNotFound = 404
  static let forceUpdate = 412
  static let internalServerError = 500
  static let serverUnavailable = 503
  static let timeout = 504
  static let cancelled = -999
}


extension URLRequest {
  
  // MARK: - Print / Request
  
  func writeRequest() -> String {
    let text = """
     
      |------------------------------------------------------
      | 🔺 \(self.url?.absoluteString ?? .empty)
      |
      | ✨ Body: \(bodyPrint() ?? .empty)
      |
      | ⚙️ Headers: \(allHeaders(short: false, number: false))
      |
     """
    return text
  }
  
  func allHeaders(short: Bool = false, number: Bool = false) -> String {
    requestAllHeaders(dict: self.allHTTPHeaderFields ?? [:], short: short, number: number)
  }
  
  func bodyPrint() -> String? {
    
    var bodyDict: [String : Any] = [:]
    if let body = self.httpBody {
      if let value = try? JSONSerialization.jsonObject(with: body, options: .allowFragments) as? [String : Any] {
        bodyDict = value
      }
    } else {
      return nil
    }
    var bodyLinePrint: String = ""
    for (key, value) in bodyDict {
      bodyLinePrint += "\n | \(key) : \(value)"
    }
    return bodyLinePrint
  }
}

extension HTTPURLResponse {
  
  // MARK: - Print / Response
  
  func writeResponse(data: Data?) -> String {
    guard let data = data else { return "" }
    
    var headerLinePrint: String = ""
    let new = Dictionary(uniqueKeysWithValues: allHeaderFields.map { (String(describing: $0.key), String(describing: $0.value))})
    headerLinePrint = requestAllHeaders(dict: new, short: false, number: false)
    
    let code = statusCode
    
    var dataStr = convertJsonRU(to: data)
    if dataStr.isEmpty, code == StatusCode.success {
      dataStr = "Success"
    }
    
    let text = """
       |------------------------------------------------------
       | 🔻 \(self.url?.absoluteString ?? .empty)
       |
       |    StatusCode: \(code)
       | ✅ Responce: \(dataStr)
       |
       | ⚙️ Headers: \(headerLinePrint)
       |
       |------------------------------------------------------
      """
    return text
    
  }
}

extension String {
  
  func addTabs(_ number: Int, left: Bool = false) -> String {
    var add: Int = number - self.count
    if add < 0 {
      add = 0
    }
    var result = ""
    if left {
      result = self
    }
    for _ in 0..<add {
      result += " "
    }
    if !left {
      result += self
    }
    return result
  }
  
  func findRemove(find: [String]) -> String {
    var result = self
    find.forEach {
      result = result.findReplace(find: $0, replace: .empty)
    }
    return result
  }
}

func requestAllHeaders(dict: [String : String], short: Bool = false, number: Bool = false) -> String {
  
  var headerLinePrint: String = ""
  
  func sortWithKeys(_ dict: [String: String]) -> [String: String] {
    let sorted = dict.sorted(by: { $0.key.uppercased() < $1.key.uppercased() })
    var newDict: [String: String] = [:]
    for sortedDict in sorted {
      newDict[sortedDict.key] = sortedDict.value
    }
    return newDict
  }
  
  var keyMax = 0
  for (key, _) in dict {
    let value = key.count + 2
    if keyMax < value {
      keyMax = value
    }
  }
  
  var i = 0
  for (key, value) in dict {
    let newKey = short ? key : key.addTabs(keyMax, left: true)
    let numberKey = number ? emoji(number:i) : ""
    if short {
      if ((i % 3) == 0) { // || (i == 0) {
        headerLinePrint += "\n | \(numberKey)\(newKey):\(value)"
      } else {
        headerLinePrint += "|\(numberKey)\(newKey):\(value)"
      }
    } else {
      headerLinePrint += "\n | \(numberKey)\(newKey) : \(value)"
    }
    
    i += 1
  }
  return headerLinePrint
}

func emoji(number: Int) -> String {
  return {
    switch number {
    case -1: return "⬜️"
    case  0: return "0️⃣"
    case  1: return "1️⃣"
    case  2: return "2️⃣"
    case  3: return "3️⃣"
    case  4: return "4️⃣"
    case  5: return "5️⃣"
    case  6: return "6️⃣"
    case  7: return "7️⃣"
    case  8: return "8️⃣"
    case  9: return "9️⃣"
    case 10: return "🔟"
    default: return "\(number)"
    }
  }()
}
