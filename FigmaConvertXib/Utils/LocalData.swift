//
//  LocalData.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 07.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

public class LocalData {
    
    static let key = "kdata"
    
    static let current = LocalData()
    
    var items: [ [String: String] ] = []
    
    init() {
        load()
    }
    
    func load() {
        let myarray = UserDefaults.standard.array(forKey: LocalData.key) as? [Data] ?? [Data]()
        var result: [ [String: String] ] = []
        for json: Data in myarray {
            let decodeItem = try! JSONDecoder().decode([String: String].self, from: json)
            result.append(decodeItem)
        }
        items = result
    }
    
    func save() {
        var arrayData: [Data] = []
        for item in items {
            let jsonData: Data = try! JSONEncoder().encode(item)
            arrayData.append(jsonData)
        }
        UserDefaults.standard.set(arrayData, forKey: LocalData.key)
    }
}
