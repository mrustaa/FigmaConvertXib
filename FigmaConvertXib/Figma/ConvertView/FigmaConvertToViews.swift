

import Foundation
import UIKit



class FigmaConvertToViews: NSObject {

    //MARK: - Separator Children
    
    var figmaImagesURLs: [String: String] = [:]
    var projectKey: String = ""
    
    func add(page: FigmaPage, projectKey: String, imagesURLs: [String: String]) -> (UIView, FigmaNode) {
        
        self.projectKey = projectKey
        self.figmaImagesURLs = imagesURLs
        
        let view = pageConvert(page: page)
        
        return view
    }
    
    func pageConvert(page: FigmaPage) -> (UIView, FigmaNode) {
        
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = page.backgroundColor
        
        var minX: CGFloat = 0
        var minY: CGFloat = 0
        
        var maxW: CGFloat = 0
        var maxH: CGFloat = 0
        
        /// поиск минальных X Y
        for subview: FigmaNode in page.subviews {
            
            if minX == 0 {
                minX = subview.absoluteBoundingBox.origin.x
            } else if minX > subview.absoluteBoundingBox.origin.x {
                minX = subview.absoluteBoundingBox.origin.x
            }
            
            if minY == 0 {
                minY = subview.absoluteBoundingBox.origin.y
            } else if minY > subview.absoluteBoundingBox.origin.y {
                minY = subview.absoluteBoundingBox.origin.y
            }
        }
        
        /// поиск максимального размера Всей Страницы
        ///  исходя из его Subviews
        for subview: FigmaNode in page.subviews {
            
            var x = subview.absoluteBoundingBox.origin.x
            var y = subview.absoluteBoundingBox.origin.y
            let width = subview.absoluteBoundingBox.size.width
            let height = subview.absoluteBoundingBox.size.height
            
            x = x - minX
            y = y - minY
            
            let cur_maxW = (x + width)
            if maxW == 0 {
                maxW = cur_maxW
            } else if maxW < cur_maxW {
                maxW = cur_maxW
            }
            
            let cur_maxH = (y + height)
            if maxH == 0 {
                maxH = cur_maxH
            } else if maxH < cur_maxH {
                maxH = cur_maxH
            }
        }
        
        let resultPageRealFrame = CGRect(x: 0, y: 0, width: maxW, height: maxH)
        
        view.frame = resultPageRealFrame
        page.realFrame = resultPageRealFrame
        
        
        
        
        for subview: FigmaNode in page.subviews {
            
            
            /// добавление subviews
            if  subview.visible,
                subview.type != .vector,
                subview.type != .star,
                subview.type != .line,
                subview.type != .regularPolygon,
                subview.type != .booleanOperation {
                
                var image: Bool = false
                for fill in subview.fills { if fill.type == .image { image = true }}
                
                var resultView: UIView!
                if subview.type == .component {
                    resultView = pageConvertToImageComponent(page: subview)
                } else if image {
                    resultView = pageConvertToImage(page: subview)
                } else if subview.type == .text {
                    resultView = pageConvertToLabel(page: subview)
                } else {
                    resultView = pageConvert(figma_view: subview)
                }
                
                /// проверка на cornerRadius - максимум
                subview.realRadius = radiusMax(radius: subview.cornerRadius, frame: resultView.bounds)
                resultView.layer.cornerRadius = subview.realRadius
                
                let x = subview.absoluteBoundingBox.origin.x - minX
                let y = subview.absoluteBoundingBox.origin.y - minY
                let width = subview.absoluteBoundingBox.size.width
                let height = subview.absoluteBoundingBox.size.height
                
                let frame = CGRect(x: x, y: y, width: width, height: height)
                resultView.frame = frame
                subview.realFrame = frame
                view.addSubview(resultView)
            }
            
            // print(" \(x) \(y) \(width) \(height) ")
        }
        
        return (view, FigmaNode(page))
    }
    
    
    func add(figma_view: FigmaNode, frame: CGRect) -> UIView {
        
        let view: UIView = pageConvert(figma_view: figma_view)
        view.frame = frame
        
        figma_view.realFrame = view.frame
        figma_view.realRadius = radiusMax(radius: figma_view.cornerRadius, frame: view.bounds)
        
        return view
    }
    
    func add(figma_view: FigmaNode, imagesURLs: [String: String]) -> UIView {
        
        self.figmaImagesURLs = imagesURLs
        // self.mainView = mainView
        // self.FigmaNode?.removeFromSuperview()
        
        let view: UIView = pageConvert(figma_view: figma_view)
        view.frame.origin.x = 0
        view.frame.origin.y = 0
        
        figma_view.realFrame = view.frame
        figma_view.realRadius = radiusMax(radius: figma_view.cornerRadius, frame: view.bounds)
        
        // FigmaNode = view
        
        return view
    }
    
    func separatorChildrenViewsType(figma_view: FigmaNode, mailView: UIView) {
        
        for cpage: FigmaNode in figma_view.subviews {
            
            if cpage.visible,
                cpage.type != .vector,
                cpage.type != .star,
                cpage.type != .line,
                cpage.type != .regularPolygon,
                cpage.type != .booleanOperation {
            
                var image: Bool = false
                for fill in cpage.fills { if fill.type == .image { image = true } }
                
                var resultView: UIView!
                if cpage.type == .component {
                    resultView = pageConvertToImageComponent(page: cpage)
                } else if image {
                    resultView = pageConvertToImage(page: cpage)
                } else if cpage.type == .text {
                    resultView = pageConvertToLabel(page: cpage)
                } else {
                    resultView = pageConvert(figma_view: cpage)
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
    
    func pageConvert(figma_view: FigmaNode) -> UIView {
        
        let view = UIView(frame: figma_view.absoluteBoundingBox)
        view.alpha = figma_view.opacity
        
        //MARK: Ellipse
        
        if figma_view.type == .ellipse {
            
            view.backgroundColor = .clear
            
            for fill: FigmaFill in figma_view.fills {
                
                switch fill.type {
                case .solid:
                    
                    if fill.visible {
                        let ellipsePath = UIBezierPath(ovalIn: view.bounds)
                        
                        let shapeLayer = CAShapeLayer()
                        shapeLayer.frame = view.bounds
                        shapeLayer.path = ellipsePath.cgPath
                        shapeLayer.fillColor = fill.color.cgColor
                        shapeLayer.opacity = Float(fill.opacity)
                        shapeLayer.strokeColor = figma_view.strokeColor.cgColor
                        shapeLayer.lineWidth = figma_view.strokeWeight
                        
                        // shapeLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                        // shapeLayer.transform = CATransform3DRotate(shapeLayer.transform, 40 * CGFloat.pi/180, 0.0, 0.0, 1.0)
                        
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
                        layer.cornerRadius = radiusMax(radius: figma_view.cornerRadius, frame: view.bounds)
                        //  view.layer.insertSublayer(layer, at: 0)
                        
                        let shapeLayer = CAShapeLayer()
                        shapeLayer.frame = view.bounds
                        shapeLayer.path = ellipsePath.cgPath
                        shapeLayer.fillColor = UIColor.black.cgColor
                        shapeLayer.opacity = Float(fill.opacity)
                        
                        // shapeLayer.strokeColor = figma_view.strokeColor.cgColor
                        // shapeLayer.lineWidth = figma_view.strokeWeight
                        
                        layer.mask = shapeLayer
                        
                        view.layer.addSublayer(layer)
                        
                        if figma_view.strokeWeight != 0 {
                            let strokeLayer = CAShapeLayer()
                            strokeLayer.frame = view.bounds
                            strokeLayer.path = ellipsePath.cgPath
                            strokeLayer.fillColor = UIColor.clear.cgColor
                            strokeLayer.strokeColor = figma_view.strokeColor.cgColor
                            strokeLayer.lineWidth = figma_view.strokeWeight
                            view.layer.addSublayer(strokeLayer)
                        }
                        
                    }
                    
                default: break
                }
            }
            
            // view.layer.borderColor = figma_view.strokeColor.cgColor
            // view.layer.borderWidth = figma_view.strokeWeight
            
        }
        //MARK: Rectangle
        else {
            
            // view.backgroundColor = page.backgroundColor
            view.clipsToBounds = figma_view.clipsContent
            
            let cornerRadius = radiusMax(radius: figma_view.cornerRadius, frame: view.bounds)
            view.layer.cornerRadius = cornerRadius
            
            for fill: FigmaFill in figma_view.fills {
                
                switch fill.type {
                case .solid:
                    
                    if fill.visible {
                        let layer = CALayer()
                        layer.frame = view.bounds
                        layer.cornerRadius = radiusMax(radius: figma_view.cornerRadius, frame: view.bounds)
                        layer.backgroundColor = fill.color.withAlphaComponent(fill.opacity).cgColor
                        // layer.opacity = Float(fill.opacity)
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
                        layer.cornerRadius = radiusMax(radius: figma_view.cornerRadius, frame: view.bounds)
                        // view.layer.insertSublayer(layer, at: 0)
                        view.layer.addSublayer(layer)
                    }
                    
                default: break
                }
            }
            
            for effect: FigmaEffect in figma_view.effects {
                if effect.visible {
                    
                    let shadowRadius = effect.radius / 2
                    let shadowColor  = effect.color.cgColor
                    let shadowOffset = effect.offset
                    
                    if effect.type == .dropShadow {
                        
                        view.layer.shadowOpacity = 1.0
                        view.layer.shadowOffset = shadowOffset
                        view.layer.shadowRadius = shadowRadius
                        view.layer.shadowColor  = shadowColor
                        
                    } else if effect.type == .innerShadow {
                        
                        view.addInnerShadow(color: shadowColor,
                                            radius: shadowRadius,
                                            offset: shadowOffset,
                                            cornerRadius: cornerRadius)
                        
                    } else if effect.type == .layerBlur {
                        
                        view.add(blur: shadowRadius, rect: view.bounds)
                    }
                }
            }
            
            for stroke: FigmaFill in figma_view.strokes {
                if stroke.type == .solid {
                    if stroke.visible {
                        view.layer.borderColor = stroke.color.withAlphaComponent(stroke.opacity).cgColor
                        view.layer.borderWidth = figma_view.strokeWeight
                    } else {
                        view.layer.borderColor = UIColor.clear.cgColor
                        view.layer.borderWidth = 0.0
                    }
                }
            }
            
        }
        
        separatorChildrenViewsType(figma_view: figma_view, mailView: view)
        
        return view
    }
    
    //MARK: - 🏞Image Component
    
    func pageConvertToImageComponent(page: FigmaNode) -> UIView {
        
        let imageView = UIImageView(frame: page.absoluteBoundingBox)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        
        if !FigmaData.checkImageExists(imageName: page.name) {
            
            FigmaData.current.requestComponent(key: projectKey,
                                               nodeId: page.id,
                                               format: .PNG,
                                               compJson:
                { (data, json: [String:Any]?) in
                    
                    guard let json = json,
                        let nodeID = json["images"] as? [String: String],
                        let imageURL = nodeID[page.id] else { return }
                    
                    let url = URL(string: imageURL)!
                    
                    FigmaData.downloadImage(url: url, completion: { (image: UIImage) in
                        
                        main {
                            imageView.image = image
                        }
                           
                        FigmaData.saveImageXcassets(image: image, name: page.name)
                    })
            })
            
        } else {
            if let image = FigmaData.load(imageName: page.name) {
                imageView.image = image
            }
        }
        
        return imageView
    }
    
    //MARK: - 🏞Image
    
    func pageConvertToImage(page: FigmaNode) -> UIView {
        
        
        let cornerRadius = radiusMax(radius: page.cornerRadius, frame: page.absoluteBoundingBox)
        
        let view = UIView(frame: page.absoluteBoundingBox)
            view.clipsToBounds = page.clipsContent
            view.layer.cornerRadius = cornerRadius
        
        let imageView = UIImageView(frame: view.bounds)
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = cornerRadius
            view.addSubview(imageView)
        
        guard let imageFill = page.imageFill(), imageFill.visible else { return view }
        
        for fill: FigmaFill in page.fills {
            
            switch fill.type {
            case .solid:
                
                if fill.visible {
                    let layer = CALayer()
                    layer.frame = view.bounds
                    layer.cornerRadius = radiusMax(radius: page.cornerRadius, frame: view.bounds)
                    layer.backgroundColor = fill.color.withAlphaComponent(fill.opacity).cgColor
                    // layer.opacity = Float(fill.opacity)
                    imageView.layer.addSublayer(layer)
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
                    imageView.layer.addSublayer(layer)
                }
                
            default: break
            }
        }
        
        for effect: FigmaEffect in page.effects {
            if effect.visible {
                
                let shadowRadius = effect.radius / 2
                let shadowColor = effect.color.cgColor
                let shadowOffset = effect.offset
                
                if effect.type == .dropShadow {
                    
                    view.layer.shadowOpacity = 1.0
                    view.layer.shadowOffset = shadowOffset
                    view.layer.shadowRadius = shadowRadius
                    view.layer.shadowColor = shadowColor
                    
                } else if effect.type == .innerShadow {
                    
                    imageView.addInnerShadow(color: shadowColor,
                                             radius: shadowRadius,
                                             offset: shadowOffset,
                                             cornerRadius: cornerRadius)
                    
                } else if effect.type == .layerBlur {
                    
                    imageView.add(blur: shadowRadius, rect: imageView.bounds)
                }
            }
        }
        
        for stroke: FigmaFill in page.strokes {
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
        
        if let imageURL = self.figmaImagesURLs[imageFill.imageRef] {
            
            let url = URL(string: imageURL)!
            
            FigmaData.downloadImage(url: url, completion: { (image: UIImage) in
                // guard let _self = self else { return }
                main {
                    imageView.image = image
                }
                FigmaData.saveImageXcassets(image: image, name: page.name)
                // FigmaData.save(image: image, name: page.name)
            })
            
            switch imageFill.scaleMode {
            case .fill: imageView.contentMode = .scaleAspectFill
            case .fit: imageView.contentMode = .scaleAspectFit
            default: break
            }
            
//            imageView.clipsToBounds = true
        }
        
        separatorChildrenViewsType(figma_view: page, mailView: view)
        
        return view
    }
    
    //MARK: - Label
    
    func pageConvertToLabel(page: FigmaNode) -> UILabel {
        
        let label = DesignLabel(frame: page.absoluteBoundingBox)
        
        label.text = page.text
        label.textColor = .clear
        label.numberOfLines = 100
        label.clipsToBounds = page.clipsContent
        label.layer.cornerRadius = radiusMax(radius: page.cornerRadius, frame: label.bounds)
        
        
        
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
        
        for fill: FigmaFill in page.fills {
            if fill.visible {
                
                switch fill.type {
                case .solid:
                    
                    label.textColor = fill.color
                    
                case .gradientRadial, .gradientLinear:
                    
                    var i: Int = 0
                    for color in fill.gradientStops {
                        switch i {
                        case 0: label.grColor1 = color
                        case 1: label.grColor2 = color
                        case 2: label.grColor3 = color
                        case 3: label.grColor4 = color
                        case 4: label.grColor5 = color
                        case 5: label.grColor6 = color
                        default: break
                        }
                        i += 1
                    }
                    
                    label.grPointPercent = true
                    label.grRadial = fill.type == .gradientRadial
                    // label.grDebug = true
                    
                    label.grStartPoint = fill.startPoint()
                    label.grEndPoint   = fill.endPoint()
                    
                default: break
                }
                
            }
        }
        
        if label.textColor == .clear {
            label.textColor = .black
            label.grBlendMode = 18
        }
        
        for stroke: FigmaFill in page.strokes {
            if stroke.visible {
                
                if stroke.type == .solid {
                    label.brColor = stroke.color.withAlphaComponent(stroke.opacity)
                    label.brWidth = page.strokeWeight
                }
            }
        }
        
        for effect: FigmaEffect in page.effects {
            if effect.visible {
                
                if effect.type == .dropShadow {
                    label.shRadius = effect.radius / 2
                    label.shColor  = effect.color
                    label.shOffset = effect.offset
                }
            }
        }
        
        separatorChildrenViewsType(figma_view: page, mailView: label)
        
//        label.applyGradientWith(startColor: .red, endColor: .black)
        
        return label
    }
}
