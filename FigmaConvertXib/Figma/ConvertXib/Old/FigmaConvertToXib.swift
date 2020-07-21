

import Foundation
import UIKit




class FigmaConvertToXib: NSObject {
    
    var figmaImagesURLs: [String: String] = [:]
    
    
    
    func add(page: FigmaNode, imagesURLs: [String: String]) {
        
        figmaImagesURLs = imagesURLs
        
        let result = createView(page: page, level: 1, mainView: true)
//        print(result)
        
        clearTempFolder()
        
        let fileName = "result.xib"
        
        
        let docDirectory = FigmaData.current.pathXib()
//        print("\n\(docDirectory)")
        
        self.save(text: result,
                  toDirectory: docDirectory,
                  withFileName: fileName)
        
        
        
//        for _ in 1...5 { print("\n") }
        
    }
    
    private func documentDirectory() -> String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return documentDirectory[0]
    }
    
    private func append(toPath path: String, withPathComponent pathComponent: String) -> String? {
        if var pathURL = URL(string: path) {
            pathURL.appendPathComponent(pathComponent)
            
            return pathURL.absoluteString
        }
        
        return nil
    }
    
    private func save(text: String, toDirectory directory: String, withFileName fileName: String) {
        guard let filePath = self.append(toPath: directory, withPathComponent: fileName) else { return }
        do {
            try text.write(toFile: filePath, atomically: true, encoding: .utf8)
        } catch {
            print("Error", error)
            return
        }
    }
    
    
    func saveImage(image: UIImage, imageRef: String) {
        
        
        let data = image.pngData()!
        
        let p = FigmaData.current.pathXibImages()
        let a = "file://\(p)/"
        
        guard let urlPathA = URL(string: a) else { return }
        let urlPath = urlPathA.appendingPathComponent("\(imageRef).png")
        
        do {
            try data.write(to: urlPath)
            print("\n 🏞 \(urlPathA.absoluteString)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func clearTempFolder() {
        let fileManager = FileManager.default
        let tempFolderPath = documentDirectory()//NSTemporaryDirectory()
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
    
    func tabsString(level: Int) -> String {
        
        var tabs = ""
        for _ in 0...level {
            tabs = tabs + "    "
        }
        return tabs
    }
    
    func addAutoresizingMask() -> String {
        return "<autoresizingMask key=\"autoresizingMask\" flexibleMaxX=\"YES\" flexibleMaxY=\"YES\"/>"
    }
    
    
    //MARK: - Create Fills
    
    func createViewFills(page: FigmaNode, fill: FigmaFill, level: Int) -> String {
        
        let tabs = tabsString(level: level)
        
        
        let randId = xibID()
        let viewHEADER = "<view alpha=\"\(fill.opacity)\" clipsSubviews=\"\(page.clipsContent.xib())\" contentMode=\"scaleToFill\" fixedFrame=\"YES\" translatesAutoresizingMaskIntoConstraints=\"NO\" id=\"\(randId)\" customClass=\"DesignView\" customModule=\"PatternsSwift\" customModuleProvider=\"target\">"
        let viewEND = "</view>"
        
        
        var bound: CGRect = page.realFrame
        bound.origin = CGPoint.zero
        let xmlBound = bound.xib()
        
        
        var xmlFillColor = ""
        var xmlGradient = ""
        
        if fill.type == .solid {
            xmlFillColor = """
            \n\(tabs)\(tabsString(level: 1))<userDefinedRuntimeAttribute type="color" keyPath="fillColor">
            \(tabs)\(tabsString(level: 2))\(fill.color.xib())
            \(tabs)\(tabsString(level: 1))</userDefinedRuntimeAttribute>
            """
        } else if fill.type == .gradientLinear {
            
            
            var index: Int = 0
            for color in fill.gradientStops {
                
                var keyPath = "gradientColor3"
                if index == 0 {
                    keyPath = "fillColor"
                } else if index == 1 {
                    keyPath = "gradientColor"
                } else if index == 2 {
                    keyPath = "gradientColor2"
                } else if index == 3 {
                    keyPath = "gradientColor3"
                }
                
                xmlGradient = xmlGradient + """
                \n\(tabs)\(tabsString(level: 1))<userDefinedRuntimeAttribute type="color" keyPath="\(keyPath)">
                \(tabs)\(tabsString(level: 2))\(color.xib())
                \(tabs)\(tabsString(level: 1))</userDefinedRuntimeAttribute>
                """
                
                index += 1
            }

            let pointFirst: CGPoint = fill.gradientHandlePositions[0]
            let pointLast: CGPoint = fill.gradientHandlePositions[fill.gradientHandlePositions.count - 2]
            
            xmlGradient = xmlGradient + """
            \n\(tabs)\(tabsString(level: 1))<userDefinedRuntimeAttribute type="point" keyPath="gradientStartPoint">
            \(tabs)\(tabsString(level: 2))<point key="value" x="\(pointFirst.x)" y="\(pointFirst.y)"/>
            \(tabs)\(tabsString(level: 1))</userDefinedRuntimeAttribute>
            """
            
            xmlGradient = xmlGradient + """
            \n\(tabs)\(tabsString(level: 1))<userDefinedRuntimeAttribute type="point" keyPath="gradientOffset">
            \(tabs)\(tabsString(level: 2))<point key="value" x="\(pointLast.x)" y="\(pointLast.y)"/>
            \(tabs)\(tabsString(level: 1))</userDefinedRuntimeAttribute>
            """
            
        }
        
        var xmlCornerRadius = ""
        if page.realRadius != 0 {
            xmlCornerRadius = """
            \n\(tabs)\(tabsString(level: 1))<userDefinedRuntimeAttribute type="number" keyPath="cornerRadius">
            \(tabs)\(tabsString(level: 2))<real key="value" value="\(page.realRadius)"/>
            \(tabs)\(tabsString(level: 1))</userDefinedRuntimeAttribute>
            """
        }
        
        let viewResult = """
        \n\(tabs)\(viewHEADER)
        \(tabs)\(tabsString(level: 0))\(xmlBound)
        \(tabs)\(tabsString(level: 0))\(addAutoresizingMask())
        \(tabs)\(tabsString(level: 0))<userDefinedRuntimeAttributes>\(xmlFillColor)\(xmlCornerRadius)\(xmlGradient)
        \(tabs)\(tabsString(level: 0))</userDefinedRuntimeAttributes>
        \(tabs)\(viewEND)
        """
        
        return viewResult
    }
    
    //MARK: - Create Views
    
    func createView(page: FigmaNode, level: Int, mainView: Bool = false) -> String {
        
        let tabs = tabsString(level: level)
        
        
        let randId = xibID()
        
        
        var image: Bool = false
        for fill in page.fills {
            if fill.type == .image {
                image = true
            }
        }
        
        //MARK: HEADER
        
        
        var viewHEADER = ""
        var viewEND = ""
        
        
        
        if image {
            
            var imageFill: FigmaFill!
            
            for fill in page.fills {
                if fill.type == .image {
                    imageFill = fill
                }
            }
            
            var contentMode = "scaleAspectFit"
            
            switch imageFill.scaleMode {
            case .fill: contentMode = "scaleAspectFill"
            case .fit: contentMode = "scaleAspectFit"
            default: break
            }
            
            if let imageURL = self.figmaImagesURLs[imageFill.imageRef] {
                
                let url = URL(string: imageURL)!
                
                FigmaData.downloadImage(url: url, completion: { [weak self] (image: UIImage) in
                    guard let _self = self else { return }
                    
//                    _self.saveImage(image: image, imageRef: imageFill.imageRef)
                    _self.saveImage(image: image, imageRef: page.name)
                    
                })
            }
            
//            let fileNameType = "\(imageFill.imageRef).png"
//            let fileNameType = "\(page.name).png"
            let fileNameType = "\(page.name)"
            
            viewHEADER = "<imageView clipsSubviews=\"YES\" userInteractionEnabled=\"NO\" contentMode=\"\(contentMode)\" horizontalHuggingPriority=\"251\" verticalHuggingPriority=\"251\" fixedFrame=\"YES\" image=\"\(fileNameType)\" translatesAutoresizingMaskIntoConstraints=\"NO\" id=\"\(randId)\">"
            
            viewEND = "</imageView>"
            
        } else if page.type == .text {
            
            var xmlAlignment = "left"
            
            if let pageFont = page.fontStyle {
                
                switch pageFont.textAlignHorizontal {
                case .left: xmlAlignment = "left"
                case .center: xmlAlignment = "center"
                case .right: xmlAlignment = "right"
                case .justified: xmlAlignment = "justified"
                }
                
            }
            
            
            viewHEADER = "<label opaque=\"NO\" userInteractionEnabled=\"NO\" contentMode=\"left\" horizontalHuggingPriority=\"251\" verticalHuggingPriority=\"251\" fixedFrame=\"YES\" text=\"\(page.text)\" textAlignment=\"\(xmlAlignment)\" lineBreakMode=\"tailTruncation\" numberOfLines=\"100\" baselineAdjustment=\"alignBaselines\" adjustsFontSizeToFit=\"NO\" translatesAutoresizingMaskIntoConstraints=\"NO\" id=\"\(randId)\">"
            
            viewEND = "</label>"
            
        } else {
            
            viewHEADER = "<view clipsSubviews=\"\(page.clipsContent.xib())\" contentMode=\"scaleToFill\" fixedFrame=\"YES\" translatesAutoresizingMaskIntoConstraints=\"NO\" id=\"\(randId)\" customClass=\"DesignView\" customModule=\"PatternsSwift\" customModuleProvider=\"target\">"
            
            viewEND = "</view>"
            
        }
        
        
        
        
        let xmlFrame = page.realFrame.xib()
        
        // let backgroundColor = "<color key=\"backgroundColor\" red=\"\(page.backgroundColor.redValue)\" green=\"\(page.backgroundColor.greenValue)\" blue=\"\(page.backgroundColor.blueValue)\" alpha=\"\(page.backgroundColor.alphaValue)\" colorSpace=\"custom\" customColorSpace=\"sRGB\"/>"
        
        
        //MARK: FILLS
        

        var xmlFillSubviews = ""
        var xmlFillColor = ""
        var xmlTextColor = ""
        
        if page.type != .text {
            
            if page.fills.count == 1 {
                
                let fill: FigmaFill = page.fills[0]
                if fill.type == .solid, fill.visible {
                    
                    xmlFillColor = """
                    \n\(tabs)\(tabsString(level: 1))<userDefinedRuntimeAttribute type="color" keyPath="fillColor">
                    \(tabs)\(tabsString(level: 2))\(fill.color.withAlphaComponent(fill.opacity).xib())
                    \(tabs)\(tabsString(level: 1))</userDefinedRuntimeAttribute>
                    """
                }
                
            } else {
                
                for fill: FigmaFill in page.fills {
                    if fill.visible {
                        
                        xmlFillSubviews = xmlFillSubviews + createViewFills(page: page, fill: fill, level: level + 2)
                    }
                }
            }
            
        } else {
            
            for fill: FigmaFill in page.fills {
                
                switch fill.type {
                case .solid:
                    
                    xmlTextColor = """
                    \n\(tabs)\(tabsString(level: 0))\(fill.color.withAlphaComponent(fill.opacity).xib("textColor"))
                    \(tabs)\(tabsString(level: 0))<nil key=\"highlightedColor\"/>
                    """
                    
                default: break
                }
            }
            
        }
        
        
        var xmlCornerRadius = ""
        if page.realRadius != 0 {
            xmlCornerRadius = """
            \n\(tabs)\(tabsString(level: 1))<userDefinedRuntimeAttribute type="number" keyPath="cornerRadius">
            \(tabs)\(tabsString(level: 2))<real key="value" value="\(page.realRadius)"/>
            \(tabs)\(tabsString(level: 1))</userDefinedRuntimeAttribute>
            """
        }
        
        
        
        
        
        
        var xmlBorder = ""
        if !page.strokes.isEmpty { // page.strokeWeight != 0 // page.strokes.count == 1
            
            let stroke: FigmaFill = page.strokes[0]
            
            if stroke.visible {
                if stroke.type == .solid {
                    
                    let strokeColor: UIColor = stroke.color.withAlphaComponent(stroke.opacity)
                    
//                    let color = "<color key=\"value\" red=\"\(strokeColor.red_)\" green=\"\(strokeColor.green_)\" blue=\"\(strokeColor.blue_)\" alpha=\"\(strokeColor.alpha_)\" colorSpace=\"custom\" customColorSpace=\"sRGB\"/>"
                    
                    let color: String = strokeColor.xib()
                    
                    xmlBorder = """
                    \n\(tabs)\(tabsString(level: 1))<userDefinedRuntimeAttribute type="number" keyPath="borderWidth">
                    \(tabs)\(tabsString(level: 2))<real key="value" value="\(page.strokeWeight)"/>
                    \(tabs)\(tabsString(level: 1))</userDefinedRuntimeAttribute>
                    \(tabs)\(tabsString(level: 1))<userDefinedRuntimeAttribute type="color" keyPath="borderColor">
                    \(tabs)\(tabsString(level: 2))\(color)
                    \(tabs)\(tabsString(level: 1))</userDefinedRuntimeAttribute>
                    """
                    
                }
            }
        }
        
        var xmlViewSubviews = ""
        
        if !page.subviews.isEmpty {
            
            for cpage: FigmaNode in page.subviews {
                if cpage.visible,
                    cpage.type != .vector,
                    cpage.type != .booleanOperation {
                    
                    xmlViewSubviews = xmlViewSubviews + "\n\(createView(page: cpage, level: level + 2))"
                    
                }
            }
        }
        
        
        var xmlSubviews = ""
        if !xmlFillSubviews.isEmpty || !xmlViewSubviews.isEmpty {
            xmlSubviews = """
            \n\(tabs)\(tabsString(level: 0))<subviews>\(xmlFillSubviews)\(xmlViewSubviews)
            \(tabs)\(tabsString(level: 0))</subviews>
            """
        }
        
        let freeformSimulatedSizeMetrics = "<freeformSimulatedSizeMetrics key=\"simulatedDestinationMetrics\"/>"
        let mainViewMetrics = (mainView ? "\n\(tabs)\(tabsString(level: 0))\(freeformSimulatedSizeMetrics)" : "")
        
        
        
        
        var xmlFontDescription = ""
        
        if page.type == .text {

            var findFont: UIFont?
            var fontSize: CGFloat = 0.0
            
            if let pageFont = page.fontStyle {
                fontSize = pageFont.fontSize
                
                if let fontName = pageFont.fontPostScriptName {
                            
                    if let font = UIFont(name: fontName, size: pageFont.fontSize) {
                        findFont = font
                    } else {
                        if let font = UIFont(name: "\(fontName)-Regular", size: pageFont.fontSize) {
                            findFont = font
                        }
                    }
                }
                
                if (findFont != nil) {
                    
                    xmlFontDescription = "\n\(tabs)\(tabsString(level: 0))<fontDescription key=\"fontDescription\" name=\"\(findFont!.fontName)\" family=\"\(findFont!.familyName)\" pointSize=\"\(fontSize)\"/>"
                    
                } else {
                    
                    if let fontPostScriptName = pageFont.fontPostScriptName {
                        
                        xmlFontDescription = "\n\(tabs)\(tabsString(level: 0))<fontDescription key=\"fontDescription\" type=\"system\" pointSize=\"\(fontSize)\"/>"
                        
//                        if fontPostScriptName.contains("Regular") || fontPostScriptName.contains("regular") {
//
//                            xmlFontDescription = "\n\(tabs)\(tabsString(level: 0))<fontDescription key=\"fontDescription\" type=\"system\" pointSize=\"\(fontSize)\"/>"
//
//                        } else
                            
                        if fontPostScriptName.contains("Bold") || fontPostScriptName.contains("bold") {
                            
                            xmlFontDescription = "\n\(tabs)\(tabsString(level: 0))<fontDescription key=\"fontDescription\" type=\"boldSystem\" pointSize=\"\(fontSize)\"/>"
                            
                        } else if fontPostScriptName.contains("Semibold") || fontPostScriptName.contains("semibold") {
                            
                            xmlFontDescription = "\n\(tabs)\(tabsString(level: 0))<fontDescription key=\"fontDescription\" type=\"system\" weight=\"semibold\" pointSize=\"\(fontSize)\"/>"
                            
                        } else if fontPostScriptName.contains("Medium") || fontPostScriptName.contains("medium") {
                            
                            xmlFontDescription = "\n\(tabs)\(tabsString(level: 0))<fontDescription key=\"fontDescription\" type=\"system\" weight=\"medium\" pointSize=\"\(fontSize)\"/>"
                            
                        } else if fontPostScriptName.contains("Light") || fontPostScriptName.contains("light") {
                            
                            xmlFontDescription = "\n\(tabs)\(tabsString(level: 0))<fontDescription key=\"fontDescription\" type=\"system\" weight=\"light\" pointSize=\"\(fontSize)\"/>"
                        }
                        
                    } else {
                        xmlFontDescription = "\n\(tabs)\(tabsString(level: 0))<fontDescription key=\"fontDescription\" type=\"system\" pointSize=\"\(fontSize)\"/>"
                    }
                }
            }
        }
        
        var xmlDefinedRuntimeAttributes = ""
        if !xmlFillColor.isEmpty || !xmlCornerRadius.isEmpty || !xmlBorder.isEmpty {
            xmlDefinedRuntimeAttributes = """
            \n\(tabs)\(tabsString(level: 0))<userDefinedRuntimeAttributes>\(xmlFillColor)\(xmlCornerRadius)\(xmlBorder)
            \(tabs)\(tabsString(level: 0))</userDefinedRuntimeAttributes>
            """
        } else {
            
            if image {
            } else if page.type == .text {
            } else {

                viewHEADER = "<view clipsSubviews=\"\(page.clipsContent.xib())\" contentMode=\"scaleToFill\" fixedFrame=\"YES\" translatesAutoresizingMaskIntoConstraints=\"NO\" id=\"\(randId)\">"
                
                viewEND = "</view>"
            }
            
            
        }
        
        var xmlMainHeader = ""
        var xmlMainEnd = ""
        
        if mainView {
            xmlMainHeader = """
            <?xml version="1.0" encoding="UTF-8"?>
            <document type="com.apple.InterfaceBuilder3.CocoaTouch.XIB" version="3.0" toolsVersion="15702" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" useSafeAreas="YES" colorMatched="YES">
                <device id="retina4_7" orientation="portrait" appearance="light"/>
                <dependencies>
                    <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="15704"/>
                    <capability name="documents saved in the Xcode 8 format" minToolsVersion="8.0"/>
                </dependencies>
                <objects>
                    <placeholder placeholderIdentifier="IBFilesOwner" id="-1" userLabel="File's Owner" customClass="TestXibView" customModule="PatternsSwift" customModuleProvider="target"/>
                    <placeholder placeholderIdentifier="IBFirstResponder" id="-2" customClass="UIResponder"/>\n
            """
            xmlMainEnd = """
            \n    </objects>
            </document>
            """
        }
        
        
        let viewResult = """
        \(xmlMainHeader)\(tabs)\(viewHEADER)
        \(tabs)\(tabsString(level: 0))\(xmlFrame)\(xmlFontDescription)\(xmlDefinedRuntimeAttributes)
        \(tabs)\(tabsString(level: 0))\(addAutoresizingMask())\(mainViewMetrics)\(xmlSubviews)\(xmlTextColor)
        \(tabs)\(viewEND)\(xmlMainEnd)
        """
        
        
        return viewResult
        
    }
    
}
