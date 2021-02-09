//
//  XmlFigmaAndroidDrawableShape.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 07.02.2021.
//  Copyright © 2021 mrusta. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    var degrees: CGFloat {
        return self * CGFloat(180) / .pi
    }
}

extension CGPoint {
    func angle(to comparisonPoint: CGPoint) -> CGFloat {
        let originX = comparisonPoint.x - x
        let originY = comparisonPoint.y - y
        let bearingRadians = atan2f(Float(originY), Float(originX))
        var bearingDegrees = CGFloat(bearingRadians).degrees
        
        while bearingDegrees < 0 {
            bearingDegrees += 360
        }
        
        return bearingDegrees
    }
    
    func distanceSquared(to: CGPoint) -> CGFloat {
        return (self.x - to.x) * (self.x - to.x) + (self.y - to.y) * (self.y - to.y)
    }
}

extension FigmaNode {
    
    func xmlAndroidDrawable() -> String {
        
        var stroke = ""
        if let stroke_ = xibSearchStroke() {
            stroke = """
            <stroke
                android:width="\(strokeWeight)dp"
                android:color="\(stroke_.colorA().hex())"
                />
            """
        }
        
        var corners = ""
        if realRadius != 0 {
            corners = """
            <corners
                android:radius="\(realRadius)dp"
                />
            """
        }
        
        var solid = ""
        if let fill = xibSearch(fill: .solid) {
            solid = """
            <solid
                android:color="\(fill.colorA().hex())"
                />
            """
        }
        
        var gradient = ""
        if let linear = xibSearch(fill: .gradientLinear) {
//             attrArr.append( linear.xibGradient() )
            
            let start = linear.startPoint()
            let end   = linear.endPoint()
            
            let angle2 = start.angle(to: end)
            //let angle2 = end.angle(to: start)
            
            
            var color  = ""
            
            if 2 < linear.gradientStops.count {
                
                color = """
                android:startColor="\(linear.gradientStops[0].hex())"
                android:centerColor="\(linear.gradientStops[1].hex())"
                android:endColor="\(linear.gradientStops[2].hex())"
                android:centerX="0.5"
                android:centerY="0.5"
                """
                
            } else {
                
                color = """
                android:startColor="\(linear.gradientStops[0].hex())"
                android:endColor="\(linear.gradientStops[1].hex())"
                """
            }
            
            
            
            var angle = 0
            
            if        337.5 < angle2 {
                angle = 360 // 0
            } else if 292.5 < angle2 {
                angle = 315
            } else if 247.5 < angle2 {
                angle = 270
            } else if 202.5 < angle2 {
                angle = 225
            } else if 157.5 < angle2 {
                angle = 180
            } else if 112.5 < angle2 {
                angle = 135
            } else if  67.5 < angle2 {
                angle = 90
            } else if  22.5 < angle2 {
                angle = 45
            }
            
            
            ///__Angle________________________________________________________
            ///                         2
            /// 0  360      1 => 2     /    2
            /// 45                    1     |   2
            /// 90                          1    \
            /// 135                               1
            /// 180                                  2 = 1
            /// 225                               1
            /// 270                         1    /           по умолчанию
            /// 315                   1     |   2
            /// 0 360       1 => 2     \    2
            ///                         2
            ///_._____________________________________________________________
            
            gradient = """
            <gradient
                android:type="linear"
                \(color)
                android:angle="-\(angle)"
                />
            """
            
        } else if let radial = xibSearch(fill: .gradientRadial) {
            // attrArr.append( radial.xibGradient() )
            
            let start   = radial.startPoint()
            //let end     = radial.gradientHandlePositions[1]
            let end    = radial.endPoint()
            
            var x = ""
            if start.x < 0 {
                x = "0.0"
            } else {
                x = String(format: "%.3f", start.x)
            }
            
            var y = ""
            if start.y < 0 {
                y = "0.0"
            } else {
                y = String(format: "%.3f", start.y)
            }
            
            
            let distance1 = start.distanceSquared(to: end)
            
//            let distance2 = start.distanceSquared(to: end2)
//
//            let distance3 = end.distanceSquared(to: end2)
            
            var color  = ""
            
            
            if 2 < radial.gradientStops.count {
                
                color = """
                android:startColor="\(radial.gradientStops[0].hex())"
                android:centerColor="\(radial.gradientStops[1].hex())"
                android:endColor="\(radial.gradientStops[2].hex())"
                """
                
            } else {
                
                color = """
                android:startColor="\(radial.gradientStops[0].hex())"
                android:endColor="\(radial.gradientStops[1].hex())"
                """
            }
            
            gradient = """
            <gradient
                android:type="radial"
                android:gradientRadius="\(distance1)in"
                android:centerX="\(x)"
                android:centerY="\(y)"
                \(color)
                />
            """
            
            
        }
        
        
        let shape = """
        <?xml version="1.0" encoding="utf-8"?>
        <shape
            xmlns:android="http://schemas.android.com/apk/res/android"
            android:shape="rectangle">
            
            \(corners)
            
            \(stroke)
            
            \(solid)

            \(gradient)

        </shape>
        """
        
        return shape
    }
    
}
