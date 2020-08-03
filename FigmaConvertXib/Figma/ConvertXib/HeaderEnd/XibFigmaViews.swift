//
//  XibFigmaViews.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 21.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

private let customModule = "FigmaConvertXib"

private let customClassImage = "DesignImageView"
private let customClassLabel = "DesignLabel"
private let customClassView = "DesignView"
private let customClassFigure = "DesignFigure"



extension FigmaNode {
    
    enum XibViewType {
        case image
        case imageComp
        case imageDesign
        case view
        case viewDesign
        case viewDesignComp
        case label
    }
    
    
    func xib(viewType: XibViewType) -> (String, String) {
        
        switch viewType {
        case .image:          return imageXib()
        case .imageComp:      return imageXib(comp: true)
        case .imageDesign:    return designImageViewXib()
        case .view:           return viewXib()
        case .viewDesign:     return designViewXib()
        case .viewDesignComp: return designViewXib(comp: true)
        case .label:          return labelXib()
        }
    }
    
    func imageXibReady() -> String {
        
        let imageHeaderEnd = imageXib()
        
        return """
        \(imageHeaderEnd.0)
        \(realFrame.xibBound())
        \(addAutoresizingMask())
        \(imageHeaderEnd.1)
        """
    }
    
    // MARK: - ImageView
    
    func imageXib(comp: Bool = false) -> (header: String, end: String) {
        
        // let fileNameType = "\(imageFill.imageRef).png"
        // let fileNameType = "\(page.name).png"
        
        let contentMode = comp ? "scaleAspectFill" : contentModeXib()
        
        let header = """
        <imageView clipsSubviews="NO" userInteractionEnabled="NO" alpha="\(opacity)" contentMode="\(contentMode)" horizontalHuggingPriority="251" verticalHuggingPriority="251" fixedFrame="YES" image="\( name.xibFilter() )" translatesAutoresizingMaskIntoConstraints="NO" userLabel="\(name)" id="\(xibID())">
        """
        
        let end = "</imageView>"
        
        return (header, end)
    }
    
    func designImageViewXib() -> (String, String) {
        
        let header = """
        <view contentMode="scaleToFill" fixedFrame="YES" translatesAutoresizingMaskIntoConstraints="NO" id="\(xibID())" userLabel="\( name.xibFilter() )" customClass="\(customClassImage)" customModule="\(customModule)" customModuleProvider="target">
        """
        
        let end = "</view>"
        
        return (header, end)
    }
    
    // MARK: - Label
    
    func labelXib() -> (header: String, end: String) {
        
        let header = """
        <label opaque="NO" userInteractionEnabled="NO" alpha="\(opacity)" contentMode="left" horizontalHuggingPriority="251" verticalHuggingPriority="251" fixedFrame="YES" text="\(text.xibFilter())" textAlignment="\(fontStyleXib())" lineBreakMode="tailTruncation" numberOfLines="\(100)" baselineAdjustment="alignBaselines" adjustsFontSizeToFit="NO" translatesAutoresizingMaskIntoConstraints="NO" id="\(xibID())" userLabel="\(name.xibFilter())" customClass="\(customClassLabel)" customModule="\(customModule)" customModuleProvider="target">
        """
        
        let end = "</label>"
        
        return (header, end)
    }
    
    // MARK: - View
    
    func designViewXib(comp: Bool = false) -> (String, String) {
        
        let clipsSubviews = comp ? "YES" : clipsContent.xib()
        
        let header = """
        <view clipsSubviews="\(clipsSubviews)" alpha="\(opacity)" contentMode="scaleToFill" fixedFrame="YES" translatesAutoresizingMaskIntoConstraints="NO" userLabel="\( name.xibFilter() )" id="\(xibID())" customClass="\(customClassView)" customModule="\(customModule)" customModuleProvider="target">
        """
        
        let end = "</view>"
        
        return (header, end)
    }
    
    func viewXib() -> (header: String, end: String) {
        
        let header = """
        <view clipsSubviews="\(clipsContent.xib())" alpha="\(opacity)" contentMode="scaleToFill" fixedFrame="YES" translatesAutoresizingMaskIntoConstraints="NO" userLabel="\( name.xibFilter() )" id="\(xibID())">
        """
        
        let end = "</view>"
        
        return (header, end)
    }
    
    // MARK: - Design Figure
      
    func designFigureXib() -> (header: String, end: String) {
        
        let header = """
        <view clipsSubviews="\(clipsContent.xib())" alpha="\(opacity)" contentMode="scaleToFill" fixedFrame="YES" translatesAutoresizingMaskIntoConstraints="NO" userLabel="\(name.xibFilter())" id="\(xibID())" customClass="\(customClassFigure)" customModule="\(customModule)" customModuleProvider="target">
        """

        let end = "</view>"
          
        return (header, end)
    }
    
    // MARK: - Cell
    
    func cellXib(rect: CGRect) -> (header: String, end: String) {
        
        let name_ = name.xibFilterName(type: .cell) + "Cell"
        
        let cellID = xibID()
        
        let header = """
        <tableViewCell clipsSubviews="\(clipsContent.xib())" contentMode="scaleToFill" preservesSuperviewLayoutMargins="YES" selectionStyle="default" indentationWidth="10" rowHeight="64" id="\(cellID)" customClass="\(name_)" customModule="\(customModule)" customModuleProvider="target">
            \(rect.xib())
            <autoresizingMask key="autoresizingMask"/>
            <tableViewCellContentView key="contentView" opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="center" preservesSuperviewLayoutMargins="YES" insetsLayoutMarginsFromSafeArea="NO" tableViewCell="\(cellID)" id="\(xibID())">
                \(rect.xibBound())
                <autoresizingMask key="autoresizingMask"/>
                <subviews>
        """
        
        let end = """
                </subviews>
            </tableViewCellContentView>
            \(UIColor.clear.xib("backgroundColor"))
        </tableViewCell>
        """
        
        let view = designFigureXib()
        
        return (header + view.header, view.end + end)
        
    }
    
    /**
     
     <tableViewCell clipsSubviews="YES" contentMode="scaleToFill" preservesSuperviewLayoutMargins="YES" selectionStyle="default" indentationWidth="10" rowHeight="64" id="ADc-Wu-299" customClass="TitleTextCell" customModule="ContainerControllerSwift_Example" customModuleProvider="target">
     
        <rect key="frame" x="0.0" y="0.0" width="375" height="64"/>
        <autoresizingMask key="autoresizingMask"/>
        <tableViewCellContentView key="contentView" opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="center" preservesSuperviewLayoutMargins="YES" insetsLayoutMarginsFromSafeArea="NO" tableViewCell="ADc-Wu-299" id="Qrk-n6-aPT">
     
            <rect key="frame" x="0.0" y="0.0" width="375" height="64"/>
            <autoresizingMask key="autoresizingMask"/>
            <subviews>
     
            </subviews>
            <color key="backgroundColor" white="0.0" alpha="0.0" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
     
        </tableViewCellContentView>
        <color key="backgroundColor" white="0.0" alpha="0.0" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
     
     </tableViewCell>
     
     */
    
    
}
