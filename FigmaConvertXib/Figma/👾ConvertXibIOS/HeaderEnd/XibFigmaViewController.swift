//
//  XibFigmaViewController.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 23.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension FigmaNode {

    func xibViewController(name: String) -> String  {
        
        let vcID = xibId
        
        let sceneID = xibID()
        let vcContentID = xibID()
        let tableID = xibID()
        
        let header = """
        <?xml version="1.0" encoding="UTF-8"?>
        <document type="com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB" version="3.0" toolsVersion="16097.2" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" useSafeAreas="YES" colorMatched="YES">
            <device id="retina4_7" orientation="portrait" appearance="light"/>
            <dependencies>
                <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="16087"/>
                <capability name="Safe area layout guides" minToolsVersion="9.0"/>
                <capability name="documents saved in the Xcode 8 format" minToolsVersion="8.0"/>
            </dependencies>
            <scenes>
                <!--\(name)-->
                <scene sceneID="\(sceneID)">
                    <objects>
                        <viewController storyboardIdentifier="\(name)" useStoryboardIdentifierAsRestorationIdentifier="YES" id="\(vcID)" customClass="\(name)" customModule="FigmaConvertXib" customModuleProvider="target" sceneMemberID="viewController">
                            <view key="view" contentMode="scaleToFill" id="\(vcContentID)">
                                <rect key="frame" x="0.0" y="0.0" width="375" height="667"/>
                                <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
                                <subviews>
                                    <tableView clipsSubviews="YES" contentMode="scaleToFill" alwaysBounceVertical="YES" dataMode="prototypes" style="plain" separatorStyle="default" rowHeight="-1" estimatedRowHeight="-1" sectionHeaderHeight="28" sectionFooterHeight="28" translatesAutoresizingMaskIntoConstraints="NO" id="\(tableID)" customClass="TableAdapterView" customModule="FigmaConvertXib" customModuleProvider="target">
                                        <rect key="frame" x="0.0" y="0.0" width="375" height="667"/>
                                        <color key="backgroundColor" red="0.93725490196078431" green="0.94901960784313721" blue="0.96078431372549022" alpha="1" colorSpace="calibratedRGB"/>
                                    </tableView>
                                </subviews>
                                <color key="backgroundColor" white="1" alpha="1" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
                                <constraints>
                                    <constraint firstAttribute="trailing" secondItem="\(tableID)" secondAttribute="trailing" id="\(xibID())"/>
                                    <constraint firstItem="\(tableID)" firstAttribute="leading" secondItem="\(vcContentID)" secondAttribute="leading" id="\(xibID())"/>
                                    <constraint firstAttribute="bottom" secondItem="\(tableID)" secondAttribute="bottom" id="\(xibID())"/>
                                    <constraint firstItem="\(tableID)" firstAttribute="top" secondItem="\(vcContentID)" secondAttribute="top" id="\(xibID())"/>
                                </constraints>
                                <viewLayoutGuide key="safeArea" id="6qi-GV-N23"/>
                            </view>
                            <connections>
                                <outlet property="tableView" destination="\(tableID)" id="\(xibID())"/>
                            </connections>
                        </viewController>
                        <placeholder placeholderIdentifier="IBFirstResponder" id="\(xibID())" userLabel="First Responder" customClass="UIResponder" sceneMemberID="firstResponder"/>
                    </objects>
                </scene>
            </scenes>
        </document>
        """
        
        return header
    }
    
}
