//
//  XibFigmaViewNew.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 30.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

extension FigmaNode {

    // MARK: Xib
    
    func xibNew(main: Bool = true, keyType: FigmaFileType? = nil) -> String {
        
        var view = ""
        
        //// _________________________________________________
        
        switch type {
            
        case .star, .ellipse, .regularPolygon,              /// figure
             .document, .page, .frame, .group, .rectangle:  /// view
            
            view = xibFigure(main: main, keyType: keyType)
            
        case .text:
            
            view = xibLabel()
        
        case .component:
            
            view = xibComponent()
            
        default: break
        }
        
        /// _Main _________________________________________________
        
        var mHeader = ""
        var mEnd    = ""
        
        if main {
            
            var m = xibMain()
            if keyType == .view {
                
                let name_ = name.xibFilterName(type: .view) + "View"
                
                m = xibMain(customClass: name_, connections: getConnetctions())
            }
            
            mHeader = m.header
            mEnd = m.resources + xibSearchImagesSize() + m.end
        }
        
        //// _________________________________________________
        
        let result = (mHeader + view + mEnd)
        
        return result
    }
    
    // MARK: - Component
    
    private func xibComponent() -> String {
        
        let view = imageXib(comp: true)
        
        let rect = realFrame.xib()
        let arMask = addAutoresizingMask()
        
        //// _________________________________________________
        
        let result = view.header +
                        rect +
                        arMask +
                    view.end
        
        return result
        
    }
    
    // MARK: - Label
    
    private func xibLabel() -> String {
        
        let rect = realFrame.xib()
        let arMask = addAutoresizingMask()
        
        var attr = ""
        
        let xmlFontName = fontNameXib()
        
        var textColor = ""
        
        /// _ Fill _________________________________________________
        
        if let fill = xibSearch(fill: .solid) {
            textColor = fill.colorA().xib("textColor")
        } else {
            attr += xibAttr(number: 18, key: "grBlendMode")
            textColor = xibAttr(color: .clear, key: "textColor")
        }
        
        /// _Gradient _________________________________________________
        
        if let linear = xibSearch(fill: .gradientLinear) {
            attr += linear.xibGradient()
        } else if let radial = xibSearch(fill: .gradientRadial) {
            attr += radial.xibGradient()
        }
        
        /// _Stroke _________________________________________________
        
        if let stroke = xibSearchStroke() {
            
            attr += xibAttr(color:  stroke.colorA(), key: "brColor")
            attr += xibAttr(number: strokeWeight,    key: "brWidth")
        }
        
        if let shadow = xibSearch(effect: .dropShadow) {
            attr += shadow.xib()
        }
        
        let attrs = xibAttrsClose(attributes: attr)
        
        let view = labelXib(design: !attr.isEmpty)
        
        //// _________________________________________________
        
        let result = view.header +
                        rect +
                        arMask +
                        xmlFontName +
                        textColor +
                        attrs +
                    view.end
        
        return result
    }
    
    
    // MARK: - Rect Image Figure
    
    private func xibFigure(main: Bool, keyType: FigmaFileType? = nil) -> String {
        
        var view = designFigureXib()
        
        /// _ Frame ________________________________________
        
        var rect = realFrame.xib()
        
        /// _Cell Key ________________________________________
        
        var connections: String = ""
        
        var findKey: FigmaFileType? = nil
        
        if let keyType = keyType {
             
            if keyType == .cell, name.find(find: FigmaFileType.cell.rawValue) {
                findKey = .cell
                
                let cell = cellXib(rect: realFrame)
                
                view.header = cell.header
                view.end    = cell.end
                
                connections = cell.connections
                
                rect = realFrame.xibBound()
                
            } else if keyType == .collection, name.find(find: FigmaFileType.collection.rawValue) {
                findKey = .collection
                
                let cell = collectionCellXib(rect: realFrame)
                
                view.header = cell.header
                view.end    = cell.end
                
                connections = cell.connections
                
                rect = realFrame.xibBound()
            }
            
        }
        if name.find(find: FigmaFileType.button.rawValue) {
             findKey = .button
            
            view = designButtonXib()
        }
        
        
        let arMask = addAutoresizingMask()
        
        /// _Attributes ________________________________________
        
        var attrArr: [String] = []
        
        
        switch type {
        case .document, .page, .frame, .group, .rectangle:  /// view
            if realRadius != 0 {
                attrArr.append( xibAttr(number: realRadius, key: "cornerRadius") )
            }
        
        case .ellipse:
            attrArr.append( xibAttr(number: 1, key: "figureType") )
            
        case .regularPolygon:
            attrArr.append( xibAttr(number: 2, key: "figureType") )
            attrArr.append( xibAttr(number: 3, key: "starCount") )
            
        case .star:
            attrArr.append( xibAttr(number: 3, key: "figureType") )
        
        default: break
        }
        
        /// _Stroke _________________________________________________
        
        if let stroke = xibSearchStroke() {
            attrArr.append( xibAttr(color:  stroke.colorA(), key: "brColor") )
            attrArr.append( xibAttr(number: strokeWeight,    key: "brWidth") )
        }
        
        /// _ Fill _________________________________________________
        
        if let fill = xibSearch(fill: .solid) {
            attrArr.append( xibAttr(color: fill.colorA(), key: "fillColor") )
        }
        
            /// _ Image _
        if let image = xibSearch(fill: .image) {
            let contentMode: CGFloat = (image.scaleMode == .fill) ? 2 : 1
            attrArr.append( xibAttr(imageName: name.xibFilter(), key: "image") )
            attrArr.append( xibAttr(number:    contentMode,      key: "imageMode") )
        }
            
            /// _ Gradient _
        if let linear = xibSearch(fill: .gradientLinear) {
            attrArr.append( linear.xibGradient() )
        } else if let radial = xibSearch(fill: .gradientRadial) {
            attrArr.append( radial.xibGradient() )
        }
        
        /// _Effects _________________________________________________
        
        if let blur = xibSearch(effect: .layerBlur) {
            attrArr.append( blur.xib() )
        }
        if let shadow = xibSearch(effect: .dropShadow) {
            attrArr.append( shadow.xib() )
        }
        if let innerShadow = xibSearch(effect: .innerShadow) {
            attrArr.append( innerShadow.xib() )
        }
        
        
        var attrs = ""
        var backgroundColor = ""
        
        if attrArr.count != 0 {
            if attrArr.count == 1, attrArr[0].find(find: "fillColor"), let fill = xibSearch(fill: .solid) {
                backgroundColor = fill.colorA().xib("backgroundColor")
                view = viewXib()
            } else {
                attrs = xibAttrsClose(attributes: attrArr.joined())
            }
        } else {
            if findKey == nil {
                view = viewXib()
            }
        }
        
        /// _Subviews _________________________________________________
        
        var subviews_ = ""
        
        if type != .component {
            for node: FigmaNode in children {
                if node.visible,
                    node.type != .vector,
                    node.type != .booleanOperation {
                    
                    let view_ = node.xibNew(main: false, keyType: keyType)
                    
                    subviews_ += view_
                }
            }
        }
        
        
        var subvs = ""
        if !subviews_.isEmpty {
            subvs = xibSubviewsClose(subviews: subviews_)
        }
        
        
        /// _Connections _________________________________________________
        // if !connections.isEmpty connections += getConnetctions()
        
        if let key = findKey {
            if key == .cell || key == .collection {
                connections += getConnetctions()
            }
        }
        
        /// _Main _________________________________________________
        
        let mMetrics = (main ? "<freeformSimulatedSizeMetrics key=\"simulatedDestinationMetrics\"/>" : "")
        
        //// _________________________________________________
        
        let result = view.header +
                        rect +
                        backgroundColor +
                        arMask +
                        mMetrics +
                        subvs +
                        attrs +
                        connections +
                    view.end
        
        return result
    }
    
    func getConnetctions() -> String {
        
        let connections_ = propertyChildren(type: .xib).connections
        if !connections_.isEmpty {
            
            var result = ""
            for c in connections_ {
                result += c
            }
            
            return """
            <connections>
                \(result)
            </connections>
            """
        }
        return ""
    }
    
}



// MARK: - Examlpe

/**
________________________________________________________________________________________________________________________
  |  Examlpe
  v
 
 <view contentMode="scaleAspectFill" fixedFrame="YES" translatesAutoresizingMaskIntoConstraints="NO" id="kT0-gl-BMX" customClass="DesignFigure" customModule="FigmaConvertXib" customModuleProvider="target">
rect
     <rect key="frame" x="182" y="104" width="216" height="205"/>
autoresizingMask
     <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
 
subviews
     <subviews>
         <view contentMode="scaleToFill" fixedFrame="YES" translatesAutoresizingMaskIntoConstraints="NO" id="4V2-DE-IUX">
             <rect key="frame" x="-69" y="20" width="240" height="128"/>
             <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
             <color key="backgroundColor" systemColor="systemBackgroundColor" cocoaTouchSystemColor="whiteColor"/>
         </view>
     </subviews>
 
     <userDefinedRuntimeAttributes>

  ________________________________________________________________________________
 
cornerRadius
          <userDefinedRuntimeAttribute type="number" keyPath="cornerRadius">
              <real key="value" value="10"/>
          </userDefinedRuntimeAttribute>
 
 ________________________________________________________________________________
                Figure
 
figureType id
         <userDefinedRuntimeAttribute type="number" keyPath="figureType">
             <integer key="value" value="3"/>
         </userDefinedRuntimeAttribute>
starCount
         <userDefinedRuntimeAttribute type="number" keyPath="starCount">
             <integer key="value" value="5"/>
         </userDefinedRuntimeAttribute>
starRadius
         <userDefinedRuntimeAttribute type="number" keyPath="starRadius">
             <real key="value" value="11"/>
         </userDefinedRuntimeAttribute>
 
________________________________________________________________________________
                 Stroke | ✅
 
brColor
         <userDefinedRuntimeAttribute type="color" keyPath="brColor">
             <color key="value" cocoaTouchSystemColor="viewFlipsideBackgroundColor"/>
         </userDefinedRuntimeAttribute>
brWidth
         <userDefinedRuntimeAttribute type="number" keyPath="brWidth">
             <real key="value" value="2"/>
         </userDefinedRuntimeAttribute>

________________________________________________________________________________
                 Fill | Solid ✅
 
fillColor
        <userDefinedRuntimeAttribute type="color" keyPath="fillColor">
            <color key="value" white="0.0" alpha="0.0" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
        </userDefinedRuntimeAttribute>
 
___________________________________________________
                 Fill | Image ✅

image
          <userDefinedRuntimeAttribute type="image" keyPath="image" value="🎈"/>
imageMode
          <userDefinedRuntimeAttribute type="number" keyPath="imageMode">
              <integer key="value" value="1"/>
          </userDefinedRuntimeAttribute>
 
___________________________________________________
                 Fill | Gradient ✅
 
grEndPoint
         <userDefinedRuntimeAttribute type="point" keyPath="grEndPoint">
             <point key="value" x="5" y="4"/>
         </userDefinedRuntimeAttribute>
grStartPoint
         <userDefinedRuntimeAttribute type="point" keyPath="grStartPoint">
             <point key="value" x="4" y="3"/>
         </userDefinedRuntimeAttribute>
grDebug
         <userDefinedRuntimeAttribute type="boolean" keyPath="grDebug" value="YES"/>
grDrawsOptions
         <userDefinedRuntimeAttribute type="boolean" keyPath="grDrawsOptions" value="NO"/>
grRadial
         <userDefinedRuntimeAttribute type="boolean" keyPath="grRadial" value="NO"/>
grBlendMode
         <userDefinedRuntimeAttribute type="number" keyPath="grBlendMode">
             <integer key="value" value="0"/>
         </userDefinedRuntimeAttribute>
grColor1
         <userDefinedRuntimeAttribute type="color" keyPath="grColor1">
             <color key="value" red="0.96848052740000001" green="0.78080801499999997" blue="0.45943740910000003" alpha="1" colorSpace="custom" customColorSpace="displayP3"/>
         </userDefinedRuntimeAttribute>
grColor2
         <userDefinedRuntimeAttribute type="color" keyPath="grColor2">
             <color key="value" red="1" green="0.61872760609999999" blue="0.65694078700000003" alpha="1" colorSpace="custom" customColorSpace="displayP3"/>
         </userDefinedRuntimeAttribute>
grColor3
         <userDefinedRuntimeAttribute type="color" keyPath="grColor3">
             <color key="value" red="0.44610523969999999" green="0.25384594199999999" blue="0.96848052740000001" alpha="1" colorSpace="custom" customColorSpace="displayP3"/>
         </userDefinedRuntimeAttribute>


________________________________________________________________________________
                Effects | Blur ✅
blur
          <userDefinedRuntimeAttribute type="number" keyPath="blur">
              <real key="value" value="2"/>
          </userDefinedRuntimeAttribute>
 
___________________________________________________
                Effects | Shadow ✅
 
shColor
         <userDefinedRuntimeAttribute type="color" keyPath="shColor">
             <color key="value" white="0.0" alpha="0.53593214899999997" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
         </userDefinedRuntimeAttribute>
shRadius
         <userDefinedRuntimeAttribute type="number" keyPath="shRadius">
             <real key="value" value="4"/>
         </userDefinedRuntimeAttribute>
shOffset
         <userDefinedRuntimeAttribute type="size" keyPath="shOffset">
             <size key="value" width="0.0" height="4"/>
         </userDefinedRuntimeAttribute>

__________________________________________________
                Effects | Inner Shadow ✅

inShRadius
         <userDefinedRuntimeAttribute type="number" keyPath="inShRadius">
             <real key="value" value="3"/>
         </userDefinedRuntimeAttribute>
inShOffset
         <userDefinedRuntimeAttribute type="size" keyPath="inShOffset">
             <size key="value" width="0.0" height="6"/>
         </userDefinedRuntimeAttribute>
inShColor
         <userDefinedRuntimeAttribute type="color" keyPath="inShColor">
             <color key="value" white="1" alpha="1" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
         </userDefinedRuntimeAttribute>
 
 ________________________________________________________________________________

     </userDefinedRuntimeAttributes>
 </view>
 */
