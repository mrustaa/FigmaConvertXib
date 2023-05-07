//
//  XibFigmaFileCell.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 02.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

enum FigmaFileType: String, CaseIterable {
    case cell       = "figmaXib:Cell"
    case collection = "figmaXib:Collection"
    case view       = "figmaXib:View"
    case table      = "figmaXib:Table"
    case tableVC    = "figmaXib:TableVC"
    case viper      = "figmaXib:Viper"
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
            nameEnd = "ViewController"
        } else if type == .viper {
            nameEnd = "ViperVC"
        } else {
            nameEnd = "Cell"
        }
        
        var name_ = name.xibFilterName(type: type) + nameEnd
        // ---------------------------------------------------------------
        if type == .viper {
          name_ = name_.findReplace(find: "ViperVC", replace: "")
        }
      
        /// Создать папку
        let path = FigmaData.pathXib()
        guard let folder = FigmaData.createFolder(path: path, name: name_) else { return }
        // ---------------------------------------------------------------
        
        var swiftFileCode = ""
        
        if type == .view {
            swiftFileCode = xibGenFileView()
        } else if type == .cell {
            swiftFileCode = xibGenFileCellPlus()
        } else if type == .collection {
            swiftFileCode = xibGenFileCollectionCellPlus()
        } else if type == .tableVC {
            swiftFileCode = xibGenFileViewСontroller()
        } else if type == .viper {
            
        }
        
        if type == .viper {
            
            /// Сохранить файл swift
            let n = name.xibFilterName(type: type)
          
            FigmaData.save(text: xibGenFileViper_Configurator(),     toDirectory: folder, withFileName: (n + "Configurator" + ".swift"))
            FigmaData.save(text: xibGenFileViper_Controller(),       toDirectory: folder, withFileName: (n + "Controller"   + ".swift"))
            FigmaData.save(text: xibGenFileViper_Presenter(),        toDirectory: folder, withFileName: (n + "Presenter"    + ".swift"))
            FigmaData.save(text: xibGenFileViper_Interactor(),       toDirectory: folder, withFileName: (n + "Interactor"   + ".swift"))
            FigmaData.save(text: xibGenFileViper_Router(),           toDirectory: folder, withFileName: (n + "Router"       + ".swift"))
          
//            FigmaData.save(text: xibGenFileViper_Service(),         toDirectory: folder, withFileName: (n + "Service"      + ".swift"))
//            FigmaData.save(text: xibGenFileViper_Localization(),    toDirectory: folder, withFileName: (n                  + ".swift"))
            
          guard let viewFolder = FigmaData.createFolder(path: folder, name: "View") else { return }
          
            FigmaData.save(text: xibNew(main: true, keyType: .table).view ,toDirectory: viewFolder, withFileName: (n + "View"         + ".xib"  ))
            FigmaData.save(text: xibGenFileView(type: type),               toDirectory: viewFolder, withFileName: (n + "View"         + ".swift"))
            
            FigmaData.save(text: xibGenFileViper_Story(),                  toDirectory: folder, withFileName: (n + "Controller"   + ".storyboard"))
            
          return
          
        } else {
            
            /// Сохранить файл swift
            let swiftName = (name_ + ".swift")
            
            FigmaData.save(text: swiftFileCode,
                           toDirectory: folder,
                           withFileName: swiftName)
        }
        
        /// ---------------------------------------------------------------

        var xibFileCode = ""
        if type == .tableVC {
            xibFileCode = xibViewController(name: name_)
        } else {
          xibFileCode = xibNew(main: true, keyType: type).view
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
        if name.find(find: FigmaFileType.viper.rawValue) {
            generateKeyFilesIOS(type: .viper)
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
    
  func genArr(_ arr: [String], _ spaceNumber: Int, _ firstSpace: Bool, lastComma: Bool = false) -> String {
        
        var space_ = ""
        for _ in 1...spaceNumber {
            space_ += " "
        }
        
        var result: String = ""
        
        if !arr.isEmpty {
            
            var i = 0
            for a in arr {
                
              var aa = a
              if (i + 1) == arr.count, lastComma {
                aa = a.findReplace(find: ",", replace: .empty)
              }
              
                if i == 0, firstSpace {
                    result += "\(aa)\n"
                } else {
                    result += "\(space_)\(aa)\n"
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



