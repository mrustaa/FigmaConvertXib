//
//  Color.swift
//  PlusBank
//
//  Created by Valentin Titov on 02.02.2021.
//

import UIKit

extension UIColor {
  /* Common */
  static let systemRed = UIColor(named: "SystemRed")!
  ///Texts
  static let text = UIColor(named: "NormalText")!
  static let details = UIColor(named: "DetailsText")!
  static let alwaysLightText = UIColor(named:"AlwaysLightText")!
  /// Backgrounds
  static let background = UIColor(named:"BackgroundColor")!
  static let inverseBackground = UIColor(named:"InverseBackground")!
  static let accent = UIColor(named:"AccentColor")!
  static let lightAccent = UIColor(named:"LightAccentColor")!
  
  /* Shadows */
  /// Drop
  static let topDropShadow = UIColor(named:"TopDropShadow")!
  static let bottomDropShadow = UIColor(named:"BottomDropShadow")!
  static let accentDropShadow = UIColor(named:"AccentDropShadow")!

  /// Inner
  static let topInnerShadow = UIColor(named:"TopInnerShadow")!
  static let bottomInnerShadow = UIColor(named:"BottomInnerShadow")!
  static let accentInnerShadow = UIColor(named:"AccentInnerShadow")!
  
}
