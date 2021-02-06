//
//  XibFigmaFileCell.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 02.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

enum FigmaFileType: String {
    case cell       = "figmaXib:Cell"
    case collection = "figmaXib:Collection"
    case view       = "figmaXib:View"
    case tableVC    = "figmaXib:TableVC"
    case button     = "figmaXib:Button"
}


extension String {
    
    func xibFilterName(type: FigmaFileType) -> String {
        
        let key = type.rawValue
        
        let removeKey       = findReplace(find: key, replace: "")
        let removeSpaces    = removeKey.removeSpaces()
        let firstUppercase  = removeSpaces.firstUppercase()
        let name_ = firstUppercase
        
        return name_
    }
}

extension FigmaNode {
    
    // MARK: - Generate Key File Swift/Xib
    
    func generateKeyFilesIOS(type: FigmaFileType) {
        
        // ---------------------------------------------------------------
        /// Имя
        var nameEnd = ""
        
        if type == .view {
            nameEnd = "View"
        } else if type == .tableVC {
            nameEnd = "TableVC"
        } else {
            nameEnd = "Cell"
        }
        
        let name_ = name.xibFilterName(type: type) + nameEnd
        // ---------------------------------------------------------------
        
        /// Создать папку
        let path = FigmaData.pathXib()
        guard let folder = FigmaData.createFolder(path: path, name: name_) else { return }
        // ---------------------------------------------------------------
        
        var swiftFileCode = ""
        
        if type == .view {
            swiftFileCode = xibGenFileView()
        } else if type == .cell {
            swiftFileCode = xibGenFileCell()
        } else if type == .collection {
            swiftFileCode = xibGenFileCollectionCell()
        } else if type == .tableVC {
            swiftFileCode = xibGenFileViewСontroller()
        }
        
        /// Сохранить файл swift
        let swiftName = (name_ + ".swift")
        
        FigmaData.save(text: swiftFileCode,
                       toDirectory: folder,
                       withFileName: swiftName)
        /// ---------------------------------------------------------------

        var xibFileCode = ""
        if type == .tableVC {
            xibFileCode = xibViewController(name: name_)
        } else {
            xibFileCode = xibNew(main: true, keyType: type)
        }
        
        // ---------------------------------------------------------------
        var xibName = ""
        if type == .tableVC {
            xibName = (name_ + ".storyboard")
        } else {
            xibName = (name_ + ".xib")
        }
        
        FigmaData.save(text: xibFileCode,
                       toDirectory: folder,
                       withFileName: xibName)
        // ---------------------------------------------------------------
    }
    
    // MARK: - Search Keys in SubViews ...
    
    func searchKeys()  {
        
        if name.find(find: FigmaFileType.cell.rawValue) {
            generateKeyFilesIOS(type: .cell)
            generateKeyFilesAndroid(type: .cell)
        }
        if name.find(find: FigmaFileType.collection.rawValue) {
            generateKeyFilesIOS(type: .collection)
        }
        if name.find(find: FigmaFileType.tableVC.rawValue) {
            generateKeyFilesIOS(type: .tableVC)
            generateKeyFilesAndroid(type: .tableVC)
        }
        if name.find(find: FigmaFileType.view.rawValue) {
            generateKeyFilesIOS(type: .view)
        }
        
        if type != .component {
            for node: FigmaNode in children {
                if node.visible,
                   node.type != .vector,
                   node.type != .booleanOperation {
                    
                    node.searchKeys()
                }
            }
        }
    }
    
    func genArr(_ arr: [String], _ spaceNumber: Int, _ firstSpace: Bool) -> String {
        
        var space_ = ""
        for _ in 1...spaceNumber {
            space_ += " "
        }
        
        var result: String = ""
        
        if !arr.isEmpty {
            
            var i = 0
            for a in arr {
                
                if i == 0, firstSpace {
                    result += "\(a)\n"
                } else {
                    result += "\(space_)\(a)\n"
                }
                
                if (i + 1) == arr.count {
                    result += space_
                }
                
                i += 1
            }
        }
        return result
    }
}



