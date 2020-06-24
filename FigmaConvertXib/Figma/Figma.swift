// To parse the JSON, add this file to your project and do:
//
//   let fileResponse = try FileResponse(json)
//   let commentsResponse = try CommentsResponse(json)
//   let commentRequest = try CommentRequest(json)
//   let projectsResponse = try ProjectsResponse(json)
//   let projectFilesResponse = try ProjectFilesResponse(json)

import UIKit
import Foundation

//MARK: - FileResponse

class FileResponse {
    var document: DocumentClass? = nil
    let schemaVersion: Double
    
    init(_ dict: [String:Any]) {
        schemaVersion = dict["schemaVersion"] as! Double
        
        if let dicDocument = dict["document"] as? [String: Any] {
            document = DocumentClass(dicDocument)
        }
    }
}

//MARK: - DocumentClass

class DocumentClass {
    let id: String
    let name: String
    let type: NodeType
    var children: [PageClass] = []
    
    init(_ dict: [String:Any]) {
        id = dict["id"] as! String
        name = dict["name"] as! String
        
        let type = dict["type"] as! String
        self.type = NodeType.type(type)
        
        if let arrayPages = dict["children"] as? [ [String: Any] ] {
            children = []
            for page in arrayPages {
                children.append( PageClass(page) )
            }
        }
    }
}

//MARK: - FillClass

class FillClass {
    
    var blendMode: BlendMode = .modeDefault
    var type: FillType = .solid
    
    var visible: Bool = true /// gradint
    var gradientHandlePositions: [CGPoint] = [] /// gradint
    var gradientStops: [UIColor] = [] /// gradint
    var gradientPosition: [CGFloat] = [] /// gradint
        
    var scaleMode: FillScaleMode = FillScaleMode.fill /// image
    var imageRef: String = "" /// image
        
    var opacity: CGFloat = 1.0 /// color
    var color: UIColor = .clear /// color
    
    init(_ dict: [String:Any]) {
        
        let type = dict["type"] as! String
        self.type = FillType.type(type)
        
        
        if let blendMode = dict["blendMode"] as? String {
            self.blendMode = BlendMode.blendMode(blendMode)
        }
        
        if let visible = dict["visible"] as? Bool {
            self.visible = visible
        }
        
        if let scaleMode = dict["scaleMode"] as? String {
            self.scaleMode = FillScaleMode.type(scaleMode)
        }
        if let imageRef = dict["imageRef"] as? String {
            self.imageRef = imageRef
        }
        
        
        if let opacity = dict["opacity"] as? CGFloat {
            self.opacity = opacity
        }
        if let color = dict["color"] as? [String: Any] {
            self.color = FigmaColor.color(color)
        }
        
        if let gradientHandlePositions = dict["gradientHandlePositions"] as? [ [String:CGFloat] ] {
            self.gradientHandlePositions = []
            for pos in gradientHandlePositions {
                if let x: CGFloat = pos["x"], let y: CGFloat = pos["y"] {
                    let point = CGPoint(x: x, y: y)
                    self.gradientHandlePositions.append(point)
                }
            }
        }
        
        if let gradientStops = dict["gradientStops"] as? [ [String:Any] ] {
            self.gradientStops = []
            for gradient in gradientStops {
                if let color = gradient["color"] as? [String: Any] {
                    let color = FigmaColor.color(color)
                    self.gradientStops.append(color)
                }
            }
        }
        
        if let gradientStops = dict["gradientStops"] as? [ [String:Any] ] {
            self.gradientPosition = []
            for gradient in gradientStops {
                if let position = gradient["position"] as? CGFloat {
                    self.gradientPosition.append(position)
                }
            }
        }
        
    }
}

//MARK: - PageClass

class PageClass {
    
    let id: String
    let name: String
    let type: NodeType
    var backgroundColor: UIColor = .clear
    var children: [PageClass] = []
    var blendMode: BlendMode = .modeDefault
    var absoluteBoundingBox: CGRect = CGRect.zero
    var clipsContent: Bool = false
    var strokeWeight: CGFloat = 0.0
    var strokeColor: UIColor = .clear
    var cornerRadius: CGFloat = 0.0
    var text: String = ""
    var fontStyle: FontStyle?
    var fills: [FillClass] = []
    var strokes: [FillClass] = []
    var visible: Bool = true
    
    var realFrame: CGRect = CGRect.zero
    var realRadius: CGFloat = 0.0
    
    init(_ dict: [String:Any]) {
        
        id = dict["id"] as! String
        name = dict["name"] as! String
        

        if let visible = dict["visible"] as? Bool {
            self.visible = visible
        }
        
        let type = dict["type"] as! String
        self.type = NodeType.type(type)
        
        if let backgroundColor = dict["backgroundColor"] as? [String: Any] {
            self.backgroundColor = FigmaColor.color(backgroundColor)
        }
        
        if let arrayFills = dict["fills"] as? [ [String: Any] ] {
            
            self.fills = []
            
            for dictFill in arrayFills {
                
                self.fills.append( FillClass(dictFill) )
                
//                if let color = dictFill["color"] as? [String: Any] {
//                    self.backgroundColor = FigmaColor.color(color)
//                }
//                if let opacity = dictFill["opacity"] as? CGFloat {
//                    self.backgroundColor = self.backgroundColor.withAlphaComponent(opacity)
//                }
            }
        }
        
        if let arrayStrokes = dict["strokes"] as? [ [String: Any] ] {
            
            self.strokes = []
            
            for dict in arrayStrokes {
                self.strokes.append( FillClass(dict) )
            }
            
            for strokes in arrayStrokes {
                if let color = strokes["color"] as? [String: Any] {
                    self.strokeColor = FigmaColor.color(color)
                }
            }
        }
        
        if let strokeWeight = dict["strokeWeight"] as? CGFloat {
            self.strokeWeight = strokeWeight
        }
        
        
        if let blendMode = dict["blendMode"] as? String {
            self.blendMode = BlendMode.blendMode(blendMode)
        }
        
        if let absoluteBoundingBox = dict["absoluteBoundingBox"] as? [String: Any] {
            self.absoluteBoundingBox = FigmaRect.rect(absoluteBoundingBox)
        }
        
        if let clipsContent = dict["clipsContent"] as? Bool {
            self.clipsContent = clipsContent
        }
        
        if let cornerRadius = dict["cornerRadius"] as? CGFloat {
            self.cornerRadius = cornerRadius
        }
        
        if let characters = dict["characters"] as? String {
            self.text = characters
        }
        
        if let style = dict["style"] as? [String: Any] {
            self.fontStyle = FontStyle(style)
        }
        
        
        if let arrayPages = dict["children"] as? [ [String: Any] ] {
            children = []
            for page in arrayPages {
                children.append( PageClass(page) )
            }
        }
        
    }
}

//MARK: - FontStyle

class FontStyle {
    
    var fontFamily: String = ""
    var fontPostScriptName: String?
    var italic: Bool = false
    var fontSize: CGFloat = 0.0
    var fontWeight: CGFloat = 0.0
    var letterSpacing: CGFloat = 0.0
    var lineHeightPercent: CGFloat = 0.0
    var lineHeightPx: CGFloat = 0.0
    var textAlignHorizontal: TextAlignHorizontal = .left
    var textAlignVertical: TextAlignVertical = .center
    
    init(_ dict: [String:Any]) {
        
        if let fontFamily = dict["fontFamily"] as? String {
            self.fontFamily = fontFamily
        }
        if let fontPostScriptName = dict["fontPostScriptName"] as? String {
            self.fontPostScriptName = fontPostScriptName
        }
        if let italic = dict["italic"] as? Bool {
            self.italic = italic
        }
        if let fontSize = dict["fontSize"] as? CGFloat {
            self.fontSize = fontSize
        }
        if let fontWeight = dict["fontWeight"] as? CGFloat {
            self.fontWeight = fontWeight
        }
        if let letterSpacing = dict["letterSpacing"] as? CGFloat {
            self.letterSpacing = letterSpacing
        }
        if let lineHeightPercent = dict["lineHeightPercent"] as? CGFloat {
            self.lineHeightPercent = lineHeightPercent
        }
        if let lineHeightPercent = dict["lineHeightPercent"] as? CGFloat {
            self.lineHeightPercent = lineHeightPercent
        }
        
        if let textAlignHorizontal = dict["textAlignHorizontal"] as? String {
            self.textAlignHorizontal = TextAlignHorizontal.type(textAlignHorizontal)
        }
        if let textAlignVertical = dict["textAlignVertical"] as? String {
            self.textAlignVertical = TextAlignVertical.type(textAlignVertical)
        }
        
    }
}

//MARK: - 19 FillType

 enum FillType: String {
    
    case emoji = "EMOJI"
    case gradientAngular = "GRADIENT_ANGULAR"
    case gradientDiamond = "GRADIENT_DIAMOND"
    case gradientLinear = "GRADIENT_LINEAR"
    case gradientRadial = "GRADIENT_RADIAL"
    case image = "IMAGE"
    case solid = "SOLID"
    
    static func type(_ str: String) -> FillType {
        var type: FillType = .solid
        
        switch str {
        case "EMOJI": type = .emoji
        case "GRADIENT_ANGULAR": type = .gradientAngular
        case "GRADIENT_DIAMOND": type = .gradientDiamond
        case "GRADIENT_LINEAR": type = .gradientLinear
        case "GRADIENT_RADIAL": type = .gradientRadial
        case "IMAGE": type = .image
        case "SOLID": type = .solid
        default: break
        }
        return type
    }
}

//MARK: - 19 FillScaleMode

enum FillScaleMode: String {

    case fill = "FILL"
    case fit = "FIT"
    case crop = "STRETCH"
    case tile = "TILE"
    
    static func type(_ str: String) -> FillScaleMode {
        var type: FillScaleMode = .fill
        
        switch str {
        case "FILL": type = .fill
        case "FIT": type = .fit
        case "STRETCH": type = .crop
        case "TILE": type = .tile
        default: break
        }
        return type
    }
}

//MARK: - 25 TextAlignHorizontal

enum TextAlignHorizontal: String {
    case center = "CENTER"
    case justified = "JUSTIFIED"
    case left = "LEFT"
    case right = "RIGHT"
    
    static func type(_ str: String) -> TextAlignHorizontal {
        var type: TextAlignHorizontal = .left
        
        switch str {
        case "CENTER": type = .center
        case "JUSTIFIED": type = .justified
        case "LEFT": type = .left
        case "RIGHT": type = .right
        default: break
        }
        return type
    }
}

//MARK: - 26 TextAlignVertical

enum TextAlignVertical: String {
    case bottom = "BOTTOM"
    case center = "CENTER"
    case top = "TOP"
    
    static func type(_ str: String) -> TextAlignVertical {
        var type: TextAlignVertical = .center
        
        switch str {
        case "BOTTOM": type = .bottom
        case "CENTER": type = .center
        case "TOP": type = .top
        default: break
        }
        return type
    }
}

//MARK: - NodeType

enum NodeType: String {
    
    case boolean = "BOOLEAN" /// Bool
    case component = "COMPONENT"
    case ellipse = "ELLIPSE" /// Овал
    case vector = "VECTOR" ///
    case booleanOperation = "BOOLEAN_OPERATION"
    case document = "DOCUMENT" /// Главный Док
    case canvas = "CANVAS" /// Полотно Холст
    case frame = "FRAME" /// Фрейм
    case group = "GROUP" /// Группа - группа не удаляет x y
    case instance = "INSTANCE"
    case line = "LINE"
    case regularPolygon = "REGULAR_POLYGON"
    case slice = "SLICE"
    case star = "STAR"
    case text = "TEXT" /// Label
    case rectangle = "RECTANGLE" /// прямоугольник
    
    static func type(_ str: String) -> NodeType {
        var nType: NodeType = .boolean
        
        switch str {
        case "BOOLEAN": nType = .boolean
        case "CANVAS": nType = .canvas
        case "COMPONENT": nType = .component
        case "DOCUMENT": nType = .document
        case "ELLIPSE": nType = .ellipse
        case "FRAME": nType = .frame
        case "GROUP": nType = .group
        case "INSTANCE": nType = .instance
        case "LINE": nType = .line
        case "RECTANGLE": nType = .rectangle
        case "REGULAR_POLYGON": nType = .regularPolygon
        case "SLICE": nType = .slice
        case "STAR": nType = .star
        case "TEXT": nType = .text
        case "VECTOR": nType = .vector
        case "BOOLEAN_OPERATION": nType = .booleanOperation
        default: break
        }
        return nType
    }
}

//MARK: - 5 BlendMode

enum BlendMode: String {
    
    case modeDefault = ""
    
    case color = "COLOR"
    case colorBurn = "COLOR_BURN"
    case colorDodge = "COLOR_DODGE"
    case darken = "DARKEN"
    case difference = "DIFFERENCE"
    case exclusion = "EXCLUSION"
    case hardLight = "HARD_LIGHT"
    case hue = "HUE"
    case lighten = "LIGHTEN"
    case linearBurn = "LINEAR_BURN"
    case linearDodge = "LINEAR_DODGE"
    case luminosity = "LUMINOSITY"
    case multiply = "MULTIPLY"
    case normal = "NORMAL"
    case overlay = "OVERLAY"
    case passThrough = "PASS_THROUGH"
    case saturation = "SATURATION"
    case screen = "SCREEN"
    case softLight = "SOFT_LIGHT"
    
    static func blendMode(_ str: String) -> BlendMode {
        var bMode: BlendMode = .color
        
        switch str {
        case "COLOR": bMode = .color
        case "COLOR_BURN": bMode = .colorBurn
        case "COLOR_DODGE": bMode = .colorDodge
        case "DARKEN": bMode = .darken
        case "DIFFERENCE": bMode = .difference
        case "EXCLUSION": bMode = .exclusion
        case "HARD_LIGHT": bMode = .hardLight
        case "HUE": bMode = .hue
        case "LIGHTEN": bMode = .lighten
        case "LINEAR_BURN": bMode = .linearBurn
        case "LINEAR_DODGE": bMode = .linearDodge
        case "LUMINOSITY": bMode = .luminosity
        case "MULTIPLY": bMode = .multiply
        case "NORMAL": bMode = .normal
        case "OVERLAY": bMode = .overlay
        case "PASS_THROUGH": bMode = .passThrough
        case "SATURATION": bMode = .saturation
        case "SCREEN": bMode = .screen
        case "SOFT_LIGHT": bMode = .softLight
        default: break
        }
        return bMode
    }
}

//MARK: - 4 Color

class FigmaColor {
    class func rgba( _ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
    class func color(_ color: [String: Any]) -> UIColor {
        let r = color["r"] as! CGFloat
        let g = color["g"] as! CGFloat
        let b = color["b"] as! CGFloat
        let a = color["a"] as! CGFloat
        return rgba(r * 255.0, g * 255.0, b * 255.0, a)
    }
}

//MARK: - 3 Rect

class FigmaRect {
    
    class func rect(_ rect: [String: Any]) -> CGRect {
        let x = rect["x"] as! CGFloat
        let y = rect["y"] as! CGFloat
        let w = rect["width"] as! CGFloat
        let h = rect["height"] as! CGFloat
        return CGRect(x: x, y: y, width: w, height: h)
    }
}


//public struct Paint: Codable {
//    public let color: Color?
//    public let gradientHandlePositions: [Vector2]?
//    public let gradientStops: [ColorStop]?
//    public let opacity: Double
//    public let scaleMode: String?
//    public let type: FillType
//    public let visible: Bool
//}

//MARK: - 6 Document

//class ViewClass {
//
//    let id: String
//    let name: String
//    let type: NodeType
    
//    public let children: [Document]?
//    public let id: String
//    public let name: String
//    public let type: NodeType?
//    public let visible: Bool
//    public let backgroundColor: Color? = nil
//    public let exportSettings: [ExportSetting]?
//    public let absoluteBoundingBox: Rect? = nil
//    public let blendMode: BlendMode? = nil
//    public let clipsContent: Bool?
//    public let constraints: LayoutConstraint? = nil
//    public let effects: [Effect]? = nil
//    public let isMask: Bool?
//    public let layoutGrids: [LayoutGrid]? = nil
//    public let opacity: Double?
//    public let preserveRatio: Bool?
//    public let transitionNodeID: String?
//    public let fills: [Paint]? = nil
//    public let strokeAlign: StrokeAlign? = nil
//    public let strokes: [Paint]?
//    public let strokeWeight: Double?
//    public let cornerRadius: Double?
//    public let characters: String?
//    public let characterStyleOverrides: [Double]?
//    public let style: TypeStyle? = nil
//    public let styleOverrideTable: [TypeStyle]? = nil
//    public let description: String?
//    public let componentID: String?

//    enum CodingKeys: String, CodingKey {
//        case children, id, name, type, visible, backgroundColor, exportSettings, absoluteBoundingBox, blendMode, clipsContent, constraints, effects, isMask, layoutGrids, opacity, preserveRatio, transitionNodeID, fills, strokeAlign, strokes, strokeWeight, cornerRadius, characters, characterStyleOverrides, style, styleOverrideTable, description
//        case componentID = "componentId"
//    }
//}


/*


 
//MARK: - 2 Component

class Component {
    public let absoluteBoundingBox: Rect
    public let backgroundColor: Color
    public let blendMode: BlendMode
    public let children: [Document]
    public let clipsContent: Bool
    public let constraints: LayoutConstraint
    public let description: String
    public let effects: [Effect]
    public let exportSettings: [ExportSetting]
    public let id: String
    public let isMask: Bool
    public let layoutGrids: [LayoutGrid]
    public let name: String
    public let opacity: Double
    public let preserveRatio: Bool
    public let transitionNodeID: String?
    public var type: NodeType
    public let visible: Bool
}




//MARK: - 7 LayoutConstraint

public struct LayoutConstraint: Codable {
    public let horizontal: Horizontal
    public let vertical: Vertical
}

//MARK: - 8 Horizontal

public enum Horizontal: String, Codable {
    case center = "CENTER"
    case horizontalLEFT = "LEFT"
    case horizontalRIGHT = "RIGHT"
    case leftRight = "LEFT_RIGHT"
    case scale = "SCALE"
}

//MARK: - 9 Vertical

public enum Vertical: String, Codable {
    case bottom = "BOTTOM"
    case center = "CENTER"
    case scale = "SCALE"
    case top = "TOP"
    case topBottom = "TOP_BOTTOM"
}

//MARK: - 10 Effect

public struct Effect: Codable {
    public let blendMode: BlendMode?
    public let color: Color?
    public let offset: Vector2?
    public let radius: Double
    public let type: EffectType
    public let visible: Bool
}

//MARK: - 11 Vector2

public struct Vector2: Codable {
    public let x: Double
    public let y: Double
}

//MARK: - 12 EffectType

public enum EffectType: String, Codable {
    case backgroundBlur = "BACKGROUND_BLUR"
    case dropShadow = "DROP_SHADOW"
    case innerShadow = "INNER_SHADOW"
    case layerBlur = "LAYER_BLUR"
}

//MARK: - 13 ExportSetting

public struct ExportSetting: Codable {
    public let constraint: Constraint
    public let format: Format
    public let suffix: String
}

//MARK: - 14 Constraint

public struct Constraint: Codable {
    public let type: ConstraintType
    public let value: Double
}

//MARK: - 15 ConstraintType

public enum ConstraintType: String, Codable {
    case height = "HEIGHT"
    case scale = "SCALE"
    case width = "WIDTH"
}

//MARK: - 16 Format

public enum Format: String, Codable {
    case jpg = "JPG"
    case png = "PNG"
    case svg = "SVG"
}

//MARK: - 17 Paint

public struct Paint: Codable {
    public let color: Color?
    public let gradientHandlePositions: [Vector2]?
    public let gradientStops: [ColorStop]?
    public let opacity: Double
    public let scaleMode: String?
    public let type: FillType
    public let visible: Bool
}

//MARK: - 18 ColorStop

public struct ColorStop: Codable {
    public let color: Color
    public let position: Double
}



//MARK: - 20 LayoutGrid

public struct LayoutGrid: Codable {
    public let alignment: Alignment
    public let color: Color
    public let count: Double
    public let gutterSize: Double
    public let offset: Double
    public let pattern: Pattern
    public let sectionSize: Double
    public let visible: Bool
}

//MARK: - 21 Alignment

public enum Alignment: String, Codable {
    case center = "CENTER"
    case max = "MAX"
    case min = "MIN"
}

//MARK: - 22 Pattern

public enum Pattern: String, Codable {
    case columns = "COLUMNS"
    case grid = "GRID"
    case rows = "ROWS"
}

//MARK: - 23 StrokeAlign

public enum StrokeAlign: String, Codable {
    case center = "CENTER"
    case inside = "INSIDE"
    case outside = "OUTSIDE"
}

//MARK: - 24 TypeStyle

public struct TypeStyle: Codable {
    public let fills: [Paint]
    public let fontFamily: String
    public let fontPostScriptName: String
    public let fontSize: Double
    public let fontWeight: Double
    public let italic: Bool
    public let letterSpacing: Double
    public let lineHeightPercent: Double
    public let lineHeightPx: Double
    public let textAlignHorizontal: TextAlignHorizontal
    public let textAlignVertical: TextAlignVertical
}

//MARK: - 25 TextAlignHorizontal

public enum TextAlignHorizontal: String, Codable {
    case center = "CENTER"
    case justified = "JUSTIFIED"
    case textAlignHorizontalLEFT = "LEFT"
    case textAlignHorizontalRIGHT = "RIGHT"
}

//MARK: - 26 TextAlignVertical

public enum TextAlignVertical: String, Codable {
    case bottom = "BOTTOM"
    case center = "CENTER"
    case top = "TOP"
}

//MARK: - 29 CommentsResponse

public struct CommentsResponse: Codable {
    public let comments: [Comment]
}

//MARK: - 30 Comment

public struct Comment: Codable {
    public let clientMeta: ClientMeta
    public let createdAt: String
    public let fileKey: String
    public let id: String
    public let message: String
    public let orderID: Double
    public let parentID: String
    public let resolvedAt: String?
    public let user: User

    enum CodingKeys: String, CodingKey {
        case clientMeta = "client_meta"
        case createdAt = "created_at"
        case fileKey = "file_key"
        case id, message
        case orderID = "order_id"
        case parentID = "parent_id"
        case resolvedAt = "resolved_at"
        case user
    }
}

//MARK: - 31 ClientMeta

public struct ClientMeta: Codable {
    public let x: Double?
    public let y: Double?
    public let nodeID: [String]?
    public let nodeOffset: Vector2?

    enum CodingKeys: String, CodingKey {
        case x, y
        case nodeID = "node_id"
        case nodeOffset = "node_offset"
    }
}

//MARK: - 32 User

public struct User: Codable {
    public let handle, imgURL: String

    enum CodingKeys: String, CodingKey {
        case handle
        case imgURL = "img_url"
    }
}

//MARK: - 33 CommentRequest

public struct CommentRequest: Codable {
    public let clientMeta: ClientMeta
    public let message: String

    enum CodingKeys: String, CodingKey {
        case clientMeta = "client_meta"
        case message
    }
}

//MARK: - 34 ProjectsResponse

public struct ProjectsResponse: Codable {
    public let projects: [Project]
}

//MARK: - 35 Project

public struct Project: Codable {
    public let id: Double
    public let name: String
}

//MARK: - 36 ProjectFilesResponse

public struct ProjectFilesResponse: Codable {
    public let files: [File]
}

//MARK: - 37 File

public struct File: Codable {
    public let key: String
    public let lastModified: String
    public let name, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case key
        case lastModified = "last_modified"
        case name
        case thumbnailURL = "thumbnail_url"
    }
}

*/
