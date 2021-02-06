//
//  LocalData.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 07.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

public class LocalData {
    
    static let kToken   = "kToken"
    static let kProject = "kProject"
    
    static let current = LocalData()
    
    var token: String?
    var projects: [ [String: String] ] = []
    
    init() {
        load()
    }
    
    func load() {
        
        if let token = UserDefaults.standard.string(forKey: LocalData.kToken) {
            self.token = token
        }
        
        if let myarray = UserDefaults.standard.array(forKey: LocalData.kProject) as? [Data] {
            
            var result: [ [String: String] ] = []
            for data: Data in myarray {
                if let decodeItem = try? JSONDecoder().decode([String: String].self, from: data) {
                    result.append(decodeItem)
                }
            }
            projects = result
        }
    }
    
    func tokenSave() {
        if token != nil {
            UserDefaults.standard.set(token, forKey: LocalData.kToken)
        }
    }
    
    func projectsSave() {
        var arrayData: [Data] = []
        for item in projects {
            let jsonData: Data = try! JSONEncoder().encode(item)
            arrayData.append(jsonData)
        }
        UserDefaults.standard.set(arrayData, forKey: LocalData.kProject)
    }
}
