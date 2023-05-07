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
private let customClassButton = "DesignButton"
private let customClassTable = "TableAdapterView"

typealias headerEnd = (_ header: String, _ end: String, _ id: String) -> Void

extension FigmaNode {
    
    enum XibViewType {
        case image
        case imageComp
        case imageDesign
        case view
        case viewDesign
        case viewDesignComp
        case label
        case labelDesign
    }
    
    
    func xib(viewType: XibViewType) -> (header: String, end: String) {
        
        switch viewType {
        case .image:          return imageXib()
        case .imageComp:      return imageXib(comp: true)
        case .imageDesign:    return designImageViewXib()
        case .view:           return viewXib()
        case .viewDesign:     return designViewXib()
        case .viewDesignComp: return designViewXib(comp: true)
        case .label:          return labelXib(design: false)
        case .labelDesign:    return labelXib(design: true)
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
        <imageView clipsSubviews="NO" userInteractionEnabled="NO" alpha="\(opacity)" contentMode="\(contentMode)" horizontalHuggingPriority="251" verticalHuggingPriority="251" fixedFrame="YES" image="\(name.xibFilter())" translatesAutoresizingMaskIntoConstraints="NO" userLabel="\(name)" id="\(xibId)">
        """
        
        let end = "</imageView>"
        
        return (header, end)
    }
    
    
    func designImageViewXib() -> (header: String, end: String) {
        
        let header = """
        <view contentMode="scaleToFill" fixedFrame="YES" translatesAutoresizingMaskIntoConstraints="NO" id="\(xibId)" userLabel="\(name.xibFilterRemoveKey())" customClass="\(customClassImage)" customModule="\(customModule)" customModuleProvider="target">
        """
        
        let end = "</view>"
        
        return (header, end)
    }
    
    // MARK: - Label
    
    func labelXib(design: Bool) -> (header: String, end: String) {
        
        let designable = (design ? " customClass=\"\(customClassLabel)\" customModule=\"\(customModule)\"" : "")
        
        let header = """
        <label opaque="NO" userInteractionEnabled="NO" alpha="\(opacity)" contentMode="left" horizontalHuggingPriority="251" verticalHuggingPriority="251" fixedFrame="YES" text="\(text.xibFilter())" textAlignment="\(fontStyleXib())" lineBreakMode="tailTruncation" numberOfLines="\(100)" baselineAdjustment="alignBaselines" adjustsFontSizeToFit="NO" translatesAutoresizingMaskIntoConstraints="NO" id="\(xibId)" userLabel="\(name.xibFilterRemoveKey())"\(designable) customModuleProvider="target">
        """
        
        let end = "</label>"
        
        return (header, end)
    }
    
    // MARK: - View
    
    func designViewXib(comp: Bool = false) -> (header: String, end: String) {
        
        let clipsSubviews = comp ? "YES" : clipsContent.xib()
        
        let header = """
        <view clipsSubviews="\(clipsSubviews)" alpha="\(opacity)" contentMode="scaleToFill" fixedFrame="YES" translatesAutoresizingMaskIntoConstraints="NO" userLabel="\(name.xibFilterRemoveKey())" id="\(xibId)" customClass="\(customClassView)" customModule="\(customModule)" customModuleProvider="target">
        """
        
        let end = "</view>"
        
        return (header, end)
    }
    
    func viewXib(id: String? = nil) -> (header: String, end: String) {
        
        let id = id ?? xibId
        
        let header = """
        <view clipsSubviews="\(clipsContent.xib())" alpha="\(opacity)" contentMode="scaleToFill" fixedFrame="YES" translatesAutoresizingMaskIntoConstraints="NO" userLabel="\( name.xibFilterRemoveKey() )" id="\(id)">
        """
        
        let end = "</view>"
        
        return (header, end)
    }
    
    // MARK: - Design Figure
      
  
  func tableAdapterViewXib() -> (header: String, end: String, constraints: String) {
    let header = """
        <tableView clipsSubviews="YES" contentMode="scaleToFill" insetsLayoutMarginsFromSafeArea="NO" alwaysBounceVertical="YES" contentInsetAdjustmentBehavior="always" keyboardDismissMode="interactive" style="plain" separatorStyle="default" rowHeight="-1" estimatedRowHeight="-1" sectionHeaderHeight="28" sectionFooterHeight="28" contentViewInsetsToSafeArea="NO" translatesAutoresizingMaskIntoConstraints="NO" id="\(tableId)" customClass="\(customClassTable)" customModule="\(customModule)" customModuleProvider="target">
            \(realFrame.xibBound())
            \(UIColor.white.xib("backgroundColor"))
        """
    
    let end = "</tableView>"
    
    let constraints = """
            <constraint firstItem="\(tableId)" firstAttribute="leading" secondItem="\(xibId)" secondAttribute="leading" id="\(xibID())"/>
            <constraint firstItem="\(tableId)" firstAttribute="top" secondItem="\(xibId)" secondAttribute="top" constant="200" id="\(tableTop)"/>
            <constraint firstAttribute="bottom" secondItem="\(tableId)" secondAttribute="bottom" constant="200" id="\(tableBottom)"/>
            <constraint firstAttribute="trailing" secondItem="\(tableId)" secondAttribute="trailing" id="\(xibID())"/>
        """
    
    return (header, end, constraints)
  }
  
    func designFigureXib(id: String? = nil) -> (header: String, end: String) {
        
        let id = id ?? xibId
        
        let header = """
        <view clipsSubviews="\(clipsContent.xib())" alpha="\(opacity)" contentMode="scaleToFill" fixedFrame="YES" translatesAutoresizingMaskIntoConstraints="NO" userLabel="\(name.xibFilterRemoveKey())" id="\(id)" customClass="\(customClassFigure)" customModule="\(customModule)" customModuleProvider="target">
        """

        let end = "</view>"
        
        return (header, end)
    }
    
    // MARK: - Button
    
    func designButtonXib() -> (header: String, end: String) {
        
        let header = """
        <button clipsSubviews="\(clipsContent.xib())" alpha="\(opacity)" opaque="NO" contentMode="scaleToFill" fixedFrame="YES" contentHorizontalAlignment="center" lineBreakMode="middleTruncation" translatesAutoresizingMaskIntoConstraints="NO" userLabel="\(name.xibFilterRemoveKey())" id="\(xibId)" customClass="\(customClassButton)" customModule="\(customModule)" customModuleProvider="target">
        """
        
//        let button = """
//        <state key="normal" title="">
//            \(UIColor.black.xib())
//        </state>
//        """
//
//        header += button
        
        let end = "</button>"
        
        return (header, end)
    }
    
  
    func cellButtonXib() -> (header: String, end: String) {
      
//       <button opaque="NO" contentMode="scaleToFill" fixedFrame="YES" contentHorizontalAlignment="center" contentVerticalAlignment="center" buttonType="roundedRect" lineBreakMode="middleTruncation" translatesAutoresizingMaskIntoConstraints="NO" id="Qeb-tN-E1l" customClass="DesignButton" customModule="FigmaConvertXib" customModuleProvider="target">
      
      let rect = realFrame.getBounds().xib()
      
      let header = """
      <button opaque="NO" contentMode="scaleToFill" contentHorizontalAlignment="center" contentVerticalAlignment="center" buttonType="system" lineBreakMode="middleTruncation" translatesAutoresizingMaskIntoConstraints="NO" id="\(cellButtonId)">
        \(rect)
      """
      
      let end = """
      </button>
      """
      
      return (header, end)
    }
  
    // MARK: - Cell
    
    func cellXib(rect: CGRect) -> (header: String, connections: String, end: String) {
        
        let name_ = name.xibFilterName(type: .cell) + "Cell"
        
      Self.tableCellId        = xibId
      Self.tableCellContentId = xibID()
      Self.tableCellViewId    = xibID()
        
        var view: (header: String, end: String)!
        if let _ = attributesOnlyFill(getAttributes()) {
            view = viewXib(id: Self.tableCellViewId)
        } else {
            view = designFigureXib(id: Self.tableCellViewId)
        }
        
        let viewHeader = view.header
        let viewEnd    = view.end
        
        let header = """
        <tableViewCell clipsSubviews="\(clipsContent.xib())" contentMode="scaleToFill" preservesSuperviewLayoutMargins="YES" selectionStyle="none" indentationWidth="10" rowHeight="64" id="\(Self.tableCellId)" customClass="\(name_)" customModule="\(customModule)" customModuleProvider="target">
            \(rect.xib())
            <autoresizingMask key="autoresizingMask"/>
            <tableViewCellContentView key="contentView" opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="center" preservesSuperviewLayoutMargins="YES" insetsLayoutMarginsFromSafeArea="NO" tableViewCell="\(Self.tableCellId)" id="\(Self.tableCellContentId)">
                \(rect.xibBound())
                <autoresizingMask key="autoresizingMask"/>
                <subviews>
                    \(viewHeader)
        """
        
      let constaints: (origin: String, size: String) = ("", "")
      
//      constaints = xibConstraintsAll(
//        curId: Self.tableCellViewId,
//        mainId: Self.tableCellContentId,
//        first: true
//      )
      
        let constraintClose = xibConstraintsClose(value: constaints.origin)
      
        let connections = """
                    \(viewEnd)
                </subviews>
                \(constraintClose)
            </tableViewCellContentView>
            \(UIColor.clear.xib("backgroundColor"))
        """
        
        let end = """
        </tableViewCell>
        """
        
        return (header, connections, end)
    }
    
    // MARK: - Cell
       
    func collectionCellXib(rect: CGRect) -> (header: String, connections: String, end: String) {
        
        let name_ = name.xibFilterName(type: .collection) + "Cell"
        
      Self.tableCellId        = xibId
      Self.tableCellViewId    = xibID()
      
      let view = designFigureXib(id: Self.tableCellViewId)
      let viewHeader = view.header
      let viewEnd    = view.end
      
        let header = """
        <collectionViewCell opaque="NO" clipsSubviews="\(clipsContent.xib())" multipleTouchEnabled="YES" contentMode="center" id="\(Self.tableCellId)" customClass="\(name_)" customModule="\(customModule)" customModuleProvider="target">
            \(rect.xibBound())
            <autoresizingMask key="autoresizingMask"/>
            <view key="contentView" opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="center">
                \(rect.xibBound())
                <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
                <subviews>
                    \(viewHeader)
        """
        
      let constaints: (origin: String, size: String) = ("", "")
//      let constaints = xibConstraintsAll(
//        curId: Self.tableCellViewId,
//        mainId: Self.tableCellId
//      )
      
        let constraintClose = xibConstraintsClose(value: constaints.origin)
      
        let connections = """
                    \(viewEnd)
                </subviews>
                \(constraintClose)
            </view>
        """
        
        let end = """
        </collectionViewCell>
        """
        
        return (header, connections, end)
        
        
        /**
        <collectionViewCell opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="center" id="gTV-IL-0wX" customClass="MapsFavoriteCell" customModule="FigmaConvertXib" customModuleProvider="target">
            <rect key="frame" x="0.0" y="0.0" width="86" height="137"/>
            <autoresizingMask key="autoresizingMask"/>
                
            view
         
            <connections>
                <outlet property="titleLabel" destination="SmU-sf-jgY" id="0NI-av-LbI"/>
            </connections>
         
        </collectionViewCell>
         */
    }
    
}
