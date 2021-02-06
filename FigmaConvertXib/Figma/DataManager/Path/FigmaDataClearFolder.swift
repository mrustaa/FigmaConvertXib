//
//  FigmaDataClearFolder.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 25.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension FigmaData {
    
    //MARK: - 📁 Paths 🗑 Clear Temp
    
    func clearTempFolder() {
        
        let fileManager = FileManager.default
        let tempFolderPath = FigmaData.pathTemporaryDocument()
        do {
            let filePaths = try fileManager.contentsOfDirectory(atPath: tempFolderPath)
            for filePath in filePaths {
                let resultPath = "\(tempFolderPath)/\(filePath)"
                try fileManager.removeItem(atPath: resultPath)
            }
        } catch {
            print("Could not clear temp folder: \(error)")
        }
    }
    
    
}
