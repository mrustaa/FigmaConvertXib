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
    
    func xibNew(main: Bool = true, cell: Bool = false) -> String {
        
        var xib_ = ""
        
        //// _________________________________________________
        
        switch type {
            
        case .star, .ellipse, .regularPolygon,              /// figure
             .document, .page, .frame, .group, .rectangle:  /// view
            
            xib_ = xibFigure(main: main, cell: cell)
            
        case .text:
            
            xib_ = xibLabel()
        
        case .component:
            
            xib_ = xibComponent()
            
        default: break
        }
        
        /// _Main _________________________________________________
        
        var mHeader = ""
        var mEnd = ""
        
        if main {
            let m = xibMain()
            mHeader = m.header
            mEnd = m.resources + xibSearchImagesSize() + m.end
        }
        
        //// _________________________________________________
        
        return mHeader + xib_ + mEnd
    }
    
    // MARK: - Component
    
    private func xibComponent() -> String {
        
        let view = imageXib(comp: true)
        
        let rect = realFrame.xib()
        let arMask = addAutoresizingMask()
        
        //// _________________________________________________
        
        return view.header +
                    rect +
                    arMask +
                view.end
    }
    
    // MARK: - Label
    
    private func xibLabel() -> String {
        
        let view = labelXib()
        
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
        
        //// _________________________________________________
        
        return view.header +
                    rect +
                    arMask +
                    xmlFontName +
                    textColor +
                    attrs +
                view.end
    }
    
    
    // MARK: - Rect Image Figure
    
    private func xibFigure(main: Bool, cell: Bool) -> String {
        
        var view = designFigureXib()
        if cell, name.find(find: FigmaFileType.cell.rawValue) {
            view = cellXib(rect: realFrame)
        }
        
        var rect = realFrame.xib()
        if cell, name.find(find: FigmaFileType.cell.rawValue) {
            rect = realFrame.xibBound()
        }
        
        let arMask = addAutoresizingMask()
        
        /// _Attributes ________________________________________
        
        var attr = ""
        
        switch type {
        case .document, .page, .frame, .group, .rectangle:  /// view
            if realRadius != 0 {
                attr += xibAttr(number: realRadius, key: "cornerRadius")
            }
        
        case .ellipse:
            attr += xibAttr(number: 1, key: "figureType")
            
        case .regularPolygon:
            attr += xibAttr(number: 2, key: "figureType")
            attr += xibAttr(number: 3, key: "starCount")
            
        case .star:
            attr += xibAttr(number: 3, key: "figureType")
        
        default: break
        }
        
        /// _Stroke _________________________________________________
        
        if let stroke = xibSearchStroke() {
            
            attr += xibAttr(color:  stroke.colorA(), key: "brColor")
            attr += xibAttr(number: strokeWeight,    key: "brWidth")
        }
        
        /// _ Fill _________________________________________________
        
        if let fill = xibSearch(fill: .solid) {
            attr += xibAttr(color: fill.colorA(), key: "fillColor")
        }
        
        if let image = xibSearch(fill: .image) {
            
            let contentMode: CGFloat = (image.scaleMode == .fill) ? 2 : 1
            
            attr += xibAttr(imageName: name.xibFilter(), key: "image")
            attr += xibAttr(number:    contentMode,      key: "imageMode")
        }
        
        if let linear = xibSearch(fill: .gradientLinear) {
            attr += linear.xibGradient()
        } else if let radial = xibSearch(fill: .gradientRadial) {
            attr += radial.xibGradient()
        }
        
        /// _Effects _________________________________________________
        
        if let blur = xibSearch(effect: .layerBlur) {
            attr += blur.xib()
        }
        if let shadow = xibSearch(effect: .dropShadow) {
            attr += shadow.xib()
        }
        if let innerShadow = xibSearch(effect: .innerShadow) {
            attr += innerShadow.xib()
        }
        
        var attrs = ""
        if !attr.isEmpty {
            attrs = xibAttrsClose(attributes: attr)
        } else {
            view = viewXib()
        }
        
        /// _Subviews _________________________________________________
        
        var subviews_ = ""
        
        if type != .component {
            for node: FigmaNode in children {
                if node.visible,
                    node.type != .vector,
                    node.type != .booleanOperation {
                    
                    subviews_ += node.xibNew(main: false, cell: cell)
                }
            }
        }
        
        var subvs = ""
        if !subviews_.isEmpty {
            subvs = xibSubviewsClose(subviews: subviews_)
        }
        
        /// _Main _________________________________________________
        
        let mMetrics = (main ? "<freeformSimulatedSizeMetrics key=\"simulatedDestinationMetrics\"/>" : "")
        
        //// _________________________________________________
        
        return view.header +
                    rect +
                    arMask +
                    mMetrics +
                    subvs +
                    attrs +
               view.end
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
