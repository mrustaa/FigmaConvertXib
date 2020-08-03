//
//  File.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 01.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

func xibMain() -> (header: String, resources: String, end: String)  {
    

    let header = """
    <?xml version="1.0" encoding="UTF-8"?>
    <document type="com.apple.InterfaceBuilder3.CocoaTouch.XIB" version="3.0" toolsVersion="15702" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" useSafeAreas="YES" colorMatched="YES">
        <device id="retina4_7" orientation="portrait" appearance="light"/>
        <dependencies>
            <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="15704"/>
            <capability name="documents saved in the Xcode 8 format" minToolsVersion="8.0"/>
        </dependencies>
        <objects>
            <placeholder placeholderIdentifier="IBFilesOwner" id="-1" userLabel="File's Owner"/>
            <placeholder placeholderIdentifier="IBFirstResponder" id="-2" customClass="UIResponder"/>
    """
    
    let resources = """
    </objects>
    """
    
    let end = """
    </document>
    """
    
    return (header, resources, end)
}
