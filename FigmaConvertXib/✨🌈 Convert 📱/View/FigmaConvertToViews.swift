

import Foundation
import UIKit



class FigmaConvertToViews: NSObject {

    //MARK: - Separator Children
    
    var figmaImagesURLs: [String: String] = [:]
    var projectKey: String = ""
    
    func add(page: FigmaPage, projectKey: String, imagesURLs: [String: String]) -> (view: UIView, node: FigmaNode) {
        
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
        for subview: FigmaNode in page.children {
            
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
        for child: FigmaNode in page.children {
            
            var x      = child.absoluteBoundingBox.origin.x
            var y      = child.absoluteBoundingBox.origin.y
            let width  = child.absoluteBoundingBox.size.width
            let height = child.absoluteBoundingBox.size.height
            
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
        
        for child: FigmaNode in page.children {
            
            
            /// добавление subviews
            if  child.visible,
                child.type != .vector,
                child.type != .line,
                child.type != .booleanOperation {
                // subview.type != .star,
                // subview.type != .regularPolygon, {
                
                var image: Bool = false
                for fill in child.fills { if fill.type == .image { image = true }}
                
                var resultView: UIView!
                if child.type == .component {
                    resultView = pageConvertToImageComponent(node: child)
                } else if image {
                    resultView = pageConvertToImage(node: child)
                } else if child.type == .text {
                    resultView = pageConvertToLabel(node: child)
                } else {
                    resultView = pageConvert(node: child)
                }
                
                /// проверка на cornerRadius - максимум
                child.realRadius = radiusMax(radius: child.cornerRadius, frame: resultView.bounds)
                resultView.layer.cornerRadius = child.realRadius
                
                let x       = child.absoluteBoundingBox.origin.x - minX
                let y       = child.absoluteBoundingBox.origin.y - minY
                let width   = child.absoluteBoundingBox.size.width
                let height  = child.absoluteBoundingBox.size.height
                
                let frame = CGRect(x: x, y: y, width: width, height: height)
                resultView.frame = frame
                child.realFrame = frame
                view.addSubview(resultView)
            }
            
            // print(" \(x) \(y) \(width) \(height) ")
        }
        
        return (view, FigmaNode(page))
    }
    
    
    func add(node: FigmaNode, frame: CGRect) -> UIView {
        
        let view: UIView = pageConvert(node: node)
        view.frame = frame
        
        node.realFrame = view.frame
        node.realRadius = radiusMax(radius: node.cornerRadius, frame: view.bounds)
        
        return view
    }
    
    func add(node: FigmaNode, imagesURLs: [String: String]) -> UIView {
        
        self.figmaImagesURLs = imagesURLs
        // self.mainView = mainView
        // self.FigmaNode?.removeFromSuperview()
        
        let view: UIView = pageConvert(node: node)
            view.frame.origin.x = 0
            view.frame.origin.y = 0
        
        node.realFrame = view.frame
        node.realRadius = radiusMax(radius: node.cornerRadius, frame: view.bounds)
        
        // FigmaNode = view
        
        return view
    }
    
    func separatorChildrenViewsType(node: FigmaNode, mailView: UIView) {
        
        for cpage: FigmaNode in node.children {
            
            if cpage.visible,
                cpage.type != .vector,
                cpage.type != .line,
                cpage.type != .booleanOperation {
                // cpage.type != .star,
                // cpage.type != .regularPolygon, {
            
                var image: Bool = false
                for fill in cpage.fills { if fill.type == .image { image = true } }
                
                var resultView: UIView!
                if cpage.type == .component {
                    resultView = pageConvertToImageComponent(node: cpage)
                } else if image {
                    resultView = pageConvertToImage(node: cpage)
                } else if cpage.type == .text {
                    resultView = pageConvertToLabel(node: cpage)
                } else {
                    resultView = pageConvert(node: cpage)
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
    
    func pageConvert(node: FigmaNode) -> UIView {
        
        let view = DesignFigure(frame: node.absoluteBoundingBox)

        view.cornerRadius = radiusMax(radius: node.cornerRadius, frame: view.bounds)
        
        switch node.type {
        case .ellipse:          view.figureType = 1
        case .regularPolygon:   view.figureType = 2; view.starCount = 3
        case .star:             view.figureType = 3
        default:                view.figureType = 0
        }
        
        view.alpha = node.opacity
        view.clipsToBounds = node.clipsContent
            
            

        for fill: FigmaFill in node.fills {
            if fill.visible {
                
                let fillView = DesignFigure(frame: view.bounds)

                switch node.type {
                case .ellipse:          fillView.figureType = 1
                case .regularPolygon:   fillView.figureType = 2; fillView.starCount = 3
                case .star:             fillView.figureType = 3
                default:                fillView.figureType = 0; fillView.cornerRadius = view.cornerRadius
                }
                
                switch fill.type {
                case .solid:
                    
                    fillView.cornerRadius = radiusMax(radius: node.cornerRadius, frame: view.bounds)
                    fillView.fillColor = fill.colorA()
                
                case .gradientLinear:
                    
                    fillView.grStartPoint = fill.startPoint()
                    fillView.grEndPoint   = fill.endPoint()
                    
                    fillView.grRadial = (fill.type == .gradientRadial)
                    
                    var i: Int = 0
                    for color in fill.gradientStops {
                        
                        switch i {
                        case 0: fillView.grColor1 = color
                        case 1: fillView.grColor2 = color
                        case 2: fillView.grColor3 = color
                        case 3: fillView.grColor4 = color
                        case 4: fillView.grColor5 = color
                        case 5: fillView.grColor6 = color
                        default: break
                        }
                        
                        i += 1
                    }
                    
                default: break
                }
                
                view.addSubview(fillView)
            }
            
        }
        
        for effect: FigmaEffect in node.effects {
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
                                        cornerRadius: view.cornerRadius)
                    
                } else if effect.type == .layerBlur {
                    
                    view.add(blur: shadowRadius, rect: view.bounds)
                }
            }
        }
        
        for stroke: FigmaFill in node.strokes {
            if stroke.type == .solid {
                if stroke.visible {
                    view.layer.borderColor = stroke.color.withAlphaComponent(stroke.opacity).cgColor
                    view.layer.borderWidth = node.strokeWeight
                } else {
                    view.layer.borderColor = UIColor.clear.cgColor
                    view.layer.borderWidth = 0.0
                }
            }
        }
            
        separatorChildrenViewsType(node: node, mailView: view)
        
        return view
    }
    
    //MARK: - 🏞Image Component
    
    func pageConvertToImageComponent(node: FigmaNode) -> UIView {
        
        let imageView = UIImageView(frame: node.absoluteBoundingBox)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        
        if !FigmaData.checkImageExists(imageName: node.name) {
            
            FigmaData.current.requestComponent(key: projectKey,
                                               nodeId: node.id,
                                               format: .PNG,
                                               compJson:
                { (data, json: [String:Any]?) in
                    
                    guard let json = json,
                        let nodeID = json["images"] as? [String: String],
                        let imageURL = nodeID[node.id] else { return }
                    
                    let url = URL(string: imageURL)!
                    
                    FigmaData.downloadImage(url: url, completion: { (image: UIImage) in
                        
                        main {
                            node.imageSize = image.size
                            imageView.image = image
                        }
                           
                        FigmaData.saveImage(image: image, name: node.name)
                    })
            })
            
        } else {
            if let image = FigmaData.load(imageName: node.name) {
                node.imageSize = image.size
                imageView.image = image
            }
        }
        
        return imageView
    }
    
    //MARK: - 🏞Image
    
    func pageConvertToImage(node: FigmaNode) -> UIView {
        
        
        let cornerRadius = radiusMax(radius: node.cornerRadius, frame: node.absoluteBoundingBox)
        
        let view = UIView(frame: node.absoluteBoundingBox)
            view.clipsToBounds = node.clipsContent
            view.layer.cornerRadius = cornerRadius
        
        let imageView = UIImageView(frame: view.bounds)
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = cornerRadius
            view.addSubview(imageView)
        
        guard let imageFill = node.imageFill(), imageFill.visible else { return view }
        
        for fill: FigmaFill in node.fills {
            
            switch fill.type {
            case .solid:
                
                if fill.visible {
//                    let layer = CALayer()
//                    layer.frame = view.bounds
//                    layer.cornerRadius = radiusMax(radius: node.cornerRadius, frame: view.bounds)
//                    layer.backgroundColor = fill.color.withAlphaComponent(fill.opacity).cgColor
//                    // layer.opacity = Float(fill.opacity)
//                    imageView.layer.addSublayer(layer)
                    
                    imageView.backgroundColor = fill.color.withAlphaComponent(fill.opacity)
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
                    layer.cornerRadius = radiusMax(radius: node.cornerRadius, frame: view.bounds)
                    // view.layer.insertSublayer(layer, at: 0)
                    imageView.layer.addSublayer(layer)
                }
                
            default: break
            }
        }
        
        for effect: FigmaEffect in node.effects {
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
        
        for stroke: FigmaFill in node.strokes {
            if stroke.type == .solid {
                if stroke.visible {
                    view.layer.borderColor = stroke.color.withAlphaComponent(stroke.opacity).cgColor
                    view.layer.borderWidth = node.strokeWeight
                } else {
                    view.layer.borderColor = UIColor.clear.cgColor
                    view.layer.borderWidth = 0.0
                }
            }
        }
        
        
        
        if !FigmaData.checkImageExists(imageName: node.name) {
            
            if let imageURL = self.figmaImagesURLs[imageFill.imageRef] {
                
                let url = URL(string: imageURL)!
                
                FigmaData.downloadImage(url: url, completion: { (image: UIImage) in
                    // guard let _self = self else { return }
                    
                    main {
                        node.imageSize = image.size
                        imageView.image = image
                    }
                    
                    FigmaData.saveImage(image: image, name: node.name)
                    // FigmaData.save(image: image, name: page.name)
                })
                
                // imageView.clipsToBounds = true
            }
            
        } else {
            if let image = FigmaData.load(imageName: node.name) {
                node.imageSize = image.size
                imageView.image = image
            }
        }
        

        switch imageFill.scaleMode {
        case .fill: imageView.contentMode = .scaleAspectFill
        case .fit:  imageView.contentMode = .scaleAspectFit
        default: break
        }
        
        separatorChildrenViewsType(node: node, mailView: view)
        
        return view
    }
    
    //MARK: - Label
    
    func pageConvertToLabel(node: FigmaNode) -> UILabel {
        
        let label = DesignLabel(frame: node.absoluteBoundingBox)
        
        label.text = node.text
        label.textColor = .clear
        label.numberOfLines = 100
        label.clipsToBounds = node.clipsContent
        label.layer.cornerRadius = radiusMax(radius: node.cornerRadius, frame: label.bounds)
        
        
        
        if let pageFont = node.fontStyle {
            
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
        
        for fill: FigmaFill in node.fills {
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
        
        for stroke: FigmaFill in node.strokes {
            if stroke.visible {
                
                if stroke.type == .solid {
                    label.brColor = stroke.color.withAlphaComponent(stroke.opacity)
                    label.brWidth = node.strokeWeight
                }
            }
        }
        
        for effect: FigmaEffect in node.effects {
            if effect.visible {
                
                if effect.type == .dropShadow {
                    label.shRadius = effect.radius / 2
                    label.shColor  = effect.color
                    label.shOffset = effect.offset
                }
            }
        }
        
        separatorChildrenViewsType(node: node, mailView: label)
        
//        label.applyGradientWith(startColor: .red, endColor: .black)
        
        return label
    }
}
