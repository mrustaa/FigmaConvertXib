//
//  XibFigmaViewNew+LegacyCode.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 06.11.2021.
//  Copyright © 2021 mrusta. All rights reserved.
//

import Foundation

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
