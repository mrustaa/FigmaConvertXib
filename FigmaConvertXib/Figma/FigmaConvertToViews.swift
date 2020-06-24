

import Foundation
import UIKit



class FigmaConvertToViews: NSObject {

    //MARK: - Separator Children
    
    var figmaView: UIView?
    var figmaImagesURLs: [String: String] = [:]
    
    
    func add(page: PageClass, mainView: UIView) {
        
        figmaView?.removeFromSuperview()
        
        let view = pageConvertToView(page: page)
        view.frame.origin.x = 0
        view.frame.origin.y = 0
        
        page.realFrame = view.frame
        page.realRadius = radiusMax(radius: page.cornerRadius, frame: view.bounds)
        
        mainView.addSubview(view)
        
        figmaView = view
        
    }
    
    func separatorChildrenViewsType(page: PageClass, mailView: UIView) {
        
        for cpage: PageClass in page.children {
            
            if cpage.visible,
                cpage.type != .vector,
                cpage.type != .booleanOperation {
            
                var image: Bool = false
                for fill in cpage.fills {
                    if fill.type == .image {
                        image = true
                    }
                }
                
                
                
                var resultView: UIView!
                
                if image {
                    resultView = pageConvertToImage(page: cpage)
                } else if cpage.type == .text {
                    resultView = pageConvertToLabel(page: cpage)
                } else {
                    resultView = pageConvertToView(page: cpage)
                }
                
                /// проверка на cornerRadius - максимум
                cpage.realRadius = radiusMax(radius: cpage.cornerRadius, frame: resultView.bounds)
                resultView.layer.cornerRadius = cpage.realRadius
                
                
                /// проверка на группу - она не вычисляет  - x y    у своих subviews
                resultView.frame.origin.x =  (resultView.frame.origin.x - mailView.frame.origin.x)
                resultView.frame.origin.y = (resultView.frame.origin.y - mailView.frame.origin.y)

                
                cpage.realFrame = resultView.frame
                
                mailView.addSubview( resultView )
            }
        }
    }
    
    //MARK: - Radius
    
    func radiusMax(radius: CGFloat, frame: CGRect) -> CGFloat {
        
        /// проверка на cornerRadius - максимум
        let rmin = (min(frame.width, frame.height) / 2)
        if radius > rmin {
            return rmin
        } else {
            return radius
        }
    }
    
    //MARK: - View
    
    func pageConvertToView(page: PageClass) -> UIView {
        
        let view = UIView(frame: page.absoluteBoundingBox)
        
        if page.type == .ellipse {
            
            view.backgroundColor = .clear
            
            for fill: FillClass in page.fills {
                
                switch fill.type {
                case .solid:
                    
                    if fill.visible {
                        let ellipsePath = UIBezierPath(ovalIn: view.bounds)
                        
                        let shapeLayer = CAShapeLayer()
                        shapeLayer.frame = view.bounds
                        shapeLayer.path = ellipsePath.cgPath
                        shapeLayer.fillColor = fill.color.cgColor
                        shapeLayer.opacity = Float(fill.opacity)
                        shapeLayer.strokeColor = page.strokeColor.cgColor
                        shapeLayer.lineWidth = page.strokeWeight
                        view.layer.addSublayer(shapeLayer)
                    }
                
                case .gradientLinear:
                    
                    if fill.visible {
                        let ellipsePath = UIBezierPath(ovalIn: view.bounds)
                        
                        var gradietCGColors: [CGColor] = [ ]
                        
                        for color in fill.gradientStops {
                            gradietCGColors.append( color.cgColor )
                        }
                        
                        let pointFirst: CGPoint = fill.gradientHandlePositions[0]
                        let pointLast: CGPoint = fill.gradientHandlePositions[fill.gradientHandlePositions.count - 2]
                        
                        let layer = CAGradientLayer()
                        layer.frame = view.bounds
                        layer.colors = gradietCGColors
                        layer.startPoint = pointFirst //CGPoint(x: pointFirst.y, y: pointFirst.x)
                        layer.endPoint = pointLast //CGPoint(x: pointLast.y, y: pointLast.x)
                        layer.cornerRadius = radiusMax(radius: page.cornerRadius, frame: view.bounds)
                        //  view.layer.insertSublayer(layer, at: 0)
                        
                        let shapeLayer = CAShapeLayer()
                        shapeLayer.frame = view.bounds
                        shapeLayer.path = ellipsePath.cgPath
                        shapeLayer.fillColor = UIColor.black.cgColor
                        shapeLayer.opacity = Float(fill.opacity)
                        
                        layer.mask = shapeLayer
                        
                        view.layer.addSublayer(layer)
                    }
                    
                default: break
                }
            }
            
        } else {
            
//            view.backgroundColor = page.backgroundColor
            view.clipsToBounds = page.clipsContent
            view.layer.cornerRadius = radiusMax(radius: page.cornerRadius, frame: view.bounds)
            
            for fill: FillClass in page.fills {
                
                switch fill.type {
                case .solid:
                    
                    if fill.visible {
                        let layer = CALayer()
                        layer.frame = view.bounds
                        layer.cornerRadius = radiusMax(radius: page.cornerRadius, frame: view.bounds)
                        layer.backgroundColor = fill.color.cgColor
                        layer.opacity = Float(fill.opacity)
                        view.layer.addSublayer(layer)
                    }
                case .gradientLinear:
                    
                    if fill.visible {
                        
                        var gradietCGColors: [CGColor] = [ ]
                        
                        for color in fill.gradientStops {
                            gradietCGColors.append( color.cgColor )
                        }
                        
                        let pointFirst: CGPoint = fill.gradientHandlePositions[0]
                        let pointLast: CGPoint = fill.gradientHandlePositions[fill.gradientHandlePositions.count - 2]
                        
                        let layer = CAGradientLayer()
                        layer.frame = view.bounds
                        layer.colors = gradietCGColors
                        layer.startPoint = pointFirst
                        layer.endPoint = pointLast
                        layer.cornerRadius = radiusMax(radius: page.cornerRadius, frame: view.bounds)
                        // view.layer.insertSublayer(layer, at: 0)
                        view.layer.addSublayer(layer)
                    }
                    
                default: break
                }
            }
            
            for stroke: FillClass in page.strokes {
                if stroke.type == .solid {
                    if stroke.visible {
                        view.layer.borderColor = stroke.color.withAlphaComponent(stroke.opacity).cgColor
                        view.layer.borderWidth = page.strokeWeight
                    } else {
                        view.layer.borderColor = UIColor.clear.cgColor
                        view.layer.borderWidth = 0.0
                    }
                }
            }
            
        }
        
        separatorChildrenViewsType(page: page, mailView: view)
        
        return view
    }
    
    //MARK: - Image
    
    func pageConvertToImage(page: PageClass) -> UIImageView {
        
        let imageView = UIImageView(frame: page.absoluteBoundingBox)
//        imageView.backgroundColor = page.backgroundColor
        imageView.clipsToBounds = page.clipsContent
        imageView.layer.cornerRadius = radiusMax(radius: page.cornerRadius, frame: imageView.bounds)
        
        var imageFill: FillClass!
        
        for fill in page.fills {
            if fill.type == .image {
                imageFill = fill
            }
        }
        
        if !imageFill.visible {
            return imageView
        }
        
        for stroke: FillClass in page.strokes {
            if stroke.type == .solid {
                if stroke.visible {
                    imageView.layer.borderColor = stroke.color.withAlphaComponent(stroke.opacity).cgColor
                    imageView.layer.borderWidth = page.strokeWeight
                } else {
                    imageView.layer.borderColor = UIColor.clear.cgColor
                    imageView.layer.borderWidth = 0.0
                }
            }
        }
        
        if let imageURL = self.figmaImagesURLs[imageFill.imageRef] {
            
            let url = URL(string: imageURL)!
            
            downloadImage(url: url, completion: { (image: UIImage) in
                // guard let _self = self else { return }
                
                imageView.image = image
            })
            
            switch imageFill.scaleMode {
            case .fill: imageView.contentMode = .scaleAspectFill
            case .fit: imageView.contentMode = .scaleAspectFit
            default: break
            }
            
            imageView.clipsToBounds = true
        }
        
        separatorChildrenViewsType(page: page, mailView: imageView)
        
        return imageView
    }
    
    //MARK: - Label
    
    func pageConvertToLabel(page: PageClass) -> UILabel {
        
        let label = UILabel(frame: page.absoluteBoundingBox)
        label.text = page.text
        
        label.numberOfLines = 100
        
        
        
        if let pageFont = page.fontStyle {
            
            var findFont: UIFont?
            
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
                label.font = findFont
            } else {
                
                if let fontPostScriptName = pageFont.fontPostScriptName {
                    
                    label.font = UIFont.systemFont(ofSize: pageFont.fontSize)
                    
                    if fontPostScriptName.contains("Bold") || fontPostScriptName.contains("bold") {
                        label.font = UIFont.boldSystemFont(ofSize: pageFont.fontSize)
                    } else if fontPostScriptName.contains("Semibold") || fontPostScriptName.contains("semibold") {
                        label.font = UIFont.systemFont(ofSize: pageFont.fontSize, weight: UIFont.Weight.semibold)
                    } else if fontPostScriptName.contains("Medium") || fontPostScriptName.contains("medium") {
                        label.font = UIFont.systemFont(ofSize: pageFont.fontSize, weight: UIFont.Weight.medium)
                    } else if fontPostScriptName.contains("Light") || fontPostScriptName.contains("light") {
                        label.font = UIFont.systemFont(ofSize: pageFont.fontSize, weight: UIFont.Weight.light)
                    }
                    
                } else {
                    label.font = UIFont.systemFont(ofSize: pageFont.fontSize)
                }
            }
            
            switch pageFont.textAlignHorizontal {
            case .left: label.textAlignment = .left
            case .center: label.textAlignment = .center
            case .right:  label.textAlignment = .right
            case .justified: label.textAlignment = .justified
            }
            
            // switch pageFont.textAlignVertical {
            // case .center: label.textAlignment = .center
            // case .bottom: label.textAlignment = .left
            // case .top:  label.textAlignment = .right
            // default: break
            
        }
        
        for fill: FillClass in page.fills {
            
            switch fill.type {
            case .solid:
                
                label.textColor = fill.color
                
            default: break
            }
        }
        
        label.clipsToBounds = page.clipsContent
        label.layer.cornerRadius = radiusMax(radius: page.cornerRadius, frame: label.bounds)
        // label.layer.borderColor = page.strokeColor.cgColor
        // label.layer.borderWidth = page.strokeWeight
        
        for stroke: FillClass in page.strokes {
            if stroke.type == .solid {
                if stroke.visible {
                    label.layer.borderColor = stroke.color.withAlphaComponent(stroke.opacity).cgColor
                    label.layer.borderWidth = page.strokeWeight
                } else {
                    label.layer.borderColor = UIColor.clear.cgColor
                    label.layer.borderWidth = 0.0
                }
            }
        }
        
        separatorChildrenViewsType(page: page, mailView: label)
        
        return label
    }
}
