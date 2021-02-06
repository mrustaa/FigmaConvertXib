//
//  XibFigmaKeyGenerateFileAndroid.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 25.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation


extension String {
    
    func xibFilterNameAndroid(type: FigmaFileType) -> String {
        
        let name   = self.xibFilterName(type: type)
        let filter = name.xmlFilter()
        // let name_  = filter.firstLowercase()
        
        return filter
    }
}

extension FigmaNode {
    
    // MARK: - Generate Key File Java/Xml
    
    func genNameFileJava(type: FigmaFileType) -> String {
        return name.xibFilterName(type: type) + genNameEnd(type:type).firstUppercase()
    }
    
    func genNameFileXML(type: FigmaFileType) -> String {
           let xml = genNameEnd(type:type) + "_" + name.xibFilterNameAndroid(type: type)
        return xml.findReplace(find: "__", replace: "_")
    }
    
    private func genNameEnd(type: FigmaFileType) -> String {
        if type == .cell {
            return "cell"
        } else if type == .tableVC {
            return "activity"
        }
        return ""
    }
    
    func generateKeyFilesAndroid(type: FigmaFileType) {
        
        // ---------------------------------------------------------------
        /// Путь
        var pathJava = ""
        if type == .cell {
            pathJava = FigmaData.pathXmlAndroidJavaUICell()
        } else if type == .tableVC {
            pathJava = FigmaData.pathXmlAndroidJavaUIScreen()
        }
        
        /// файл .java
        var fileCodeJava = ""
        if type == .cell {
            fileCodeJava = xmlGenFileCell()
        } else if type == .tableVC {
            fileCodeJava = xmlGenFileRecyclerActivity()
        }
        
        /// Имя .java
        let nameJava = genNameFileJava(type: type)
        let nameJava_ = (nameJava + ".java")
        
        FigmaData.save(text: fileCodeJava,
                toDirectory:     pathJava,
               withFileName:     nameJava_)
        
        /// ---------------------------------------------------------------
        /// путь .xml
        let pathXml = FigmaData.pathXmlAndroidLayout()
        
        /// файл .xml
        var fileCodeXml = ""
        if type == .tableVC {
            fileCodeXml = xmlRecyclerActivity(name: nameJava)
        } else {
            fileCodeXml = xmlAndroid()
        }
        
        /// Имя .xml
        let nameXml = genNameFileXML(type: type)
        let nameXml_ = (nameXml + ".xml")
        
        FigmaData.save(text: fileCodeXml,
                toDirectory:     pathXml,
               withFileName:     nameXml_)
        // ---------------------------------------------------------------
        
    }
    
}
