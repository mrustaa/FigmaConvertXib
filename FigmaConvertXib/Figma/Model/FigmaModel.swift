
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    
    var document: Document
    var name, lastModified, thumbnailURL, version, role: String
    var schemaVersion: Int
    let components: Welcome.Components
    let styles: Welcome.Styles
    
//    init(_ json: [String:Any]) {
//
//        self.json(json)
//    }
}

//extension Welcome {
//    func json(_ json: [String:Any]) {
//        
//        if let schemaVersion = json["schemaVersion"] as? Int {
//            self.schemaVersion = schemaVersion
//        }
//        
//        if let name = json["name"] as? String {
//            self.name = name
//        }
//        if let lastModified = json["lastModified"] as? String {
//            self.lastModified = lastModified
//        }
//        if let thumbnailURL = json["thumbnailURL"] as? String {
//            self.thumbnailURL = thumbnailURL
//        }
//        if let version = json["version"] as? String {
//            self.version = version
//        }
//        if let role = json["role"] as? String {
//            self.role = role
//        }
//        
//        if let document = json["document"] as? [String: Any] {
////            self.document = Document(document)
//        }
//    }
//}

// MARK: - Document
class Document: Codable {
   
    var id, name: String
    var type: Type_
    var children: [Document]?
    /// ------------------------------------
    
}

extension Document {
    enum Type_: String, Codable {
        case document = "DOCUMENT"      /// Главный Док                     Document
        case page = "CANVAS"            /// Страница                        Page
        case frame = "FRAME"            /// Фрейм                           View
        case group = "GROUP"            /// Группа - группа не удаляет x y  View
        case rectangle = "RECTANGLE"    /// Прямоугольник                   View
        case text = "TEXT"              /// Текст                           Label
        case boolean = "BOOLEAN"        /// Bool
        case booleanOperation = "BOOLEAN_OPERATION"
        case component = "COMPONENT"
        case instance = "INSTANCE"
        case line = "LINE"              /// Линия
        case regularPolygon = "REGULAR_POLYGON"
        case slice = "SLICE"
        case vector = "VECTOR"          /// Вектор
        case ellipse = "ELLIPSE"        /// Овал
        case star = "STAR"              /// Звезда векторная
    }
}

// MARK: - Page
class Page: Document {
    
    var backgroundColor: Color
    var prototypeStartNodeID: JSONNull?
    var prototypeDevice: PrototypeDevice
    /// ------------------------------------
    required init(from decoder: Decoder) throws {
        backgroundColor = Color.zero; prototypeStartNodeID = nil; prototypeDevice = PrototypeDevice.zero
        try super.init(from: decoder)
        try dec(from: decoder)
    }
}

class View: Document {
    
//    var blendMode: BlendMode                        /// frame rect group text
    
//    var clipsContent: Bool? = true                  /// frame      group
//    var visible: Bool? = true
//    var alpha: Double? = 1.00 // alpha
//
//    /// Radius
//    var cornerRadius: Int? = 0                      ///       rect
//    var rectangleCornerRadii: [Double]?             ///       rect
    
    /// Rect
    var frame: Rect                                 /// frame rect group text
//    var layout: Layout                              /// frame rect group text   //(layout)
    
    /// Color
//    var fills: [Fill]                               /// frame rect group text rect+image
//    var background: [Fill]?                         /// frame rect group
//    var backgroundColor: Color?                     /// frame rect group
    
    /// Stroke
//    var strokes: [Fill]                             /// frame rect group text
//    var strokeWeight: Double                        /// frame rect group text
//    var strokeAlign: StrokeAlign                    /// frame rect group text
    
    /// ------------------------------------
    required init(from decoder: Decoder) throws {
        
//        blendMode = .color;
//        clipsContent = true; visible = true; alpha = 1.0; cornerRadius = 0;
        frame = Rect.zero;
//        layout = Layout.zero;
//        fills = [];
//        background = []; backgroundColor = Color.zero;
//        strokes = [];
//        strokeWeight = 0.0; strokeAlign = StrokeAlign.inside;
        try super.init(from: decoder);
        try decView(from: decoder)
    }
}

//class Text: View {
//
//    /// Text (Only)
//    let characters: String                         ///                 text
//    let styles: StickyStyles                       ///                 text
//    let characterStyleOverrides: [Int]             ///                 text
//    let styleOverrideTable: [String: StyleOverrideTable] ///           text
//    /// ------------------------------------
//    required init(from decoder: Decoder) throws {
//        characters = ""; clipsContent = true; visible = true; alpha = 1.0; cornerRadius = 0; frame = Rect.zero; layout = Layout.zero; fills = []; background = []; backgroundColor =  Color.zero; strokes = []; strokeWeight = 0.0; strokeAlign = StrokeAlign.inside;
//        try super.init(from: decoder);
//        try decView(from: decoder)
//    }
//}

class Image: Document {
    
}

 
 
// MARK: - View
struct View2: Codable {
    
    let effects: [Effect]                           /// frame      group text
    let layoutGrids: [JSONAny]?                     /// frame
    
    let exportSettings: [ExportSetting]?
    let overflowDirection: String?
    let preserveRatio: Bool?
    let textStyle: TextStyle?
    let layoutVersion: Int?
    let isMask, isMaskOutline: Bool?
    let layoutMode: String?
    let itemSpacing, horizontalPadding, verticalPadding: Int?
}


// MARK: - Fill
struct Fill: Codable {
    
    let type: Type
    let blendMode: BlendMode
    let scaleMode: ScaleMode?
    
    let color: Color?
    let visible: Bool?
    let gradientHandlePositions: [GradientHandlePosition]?
    let gradientStops: [GradientStop]?
    
    let opacity: Double?
    let imageRef: String?
    let imageTransform: [[Int]]?
    
    enum `Type`: String, Codable {
        case emoji = "EMOJI"
         case gradientAngular = "GRADIENT_ANGULAR"
         case gradientDiamond = "GRADIENT_DIAMOND"
         case gradientLinear = "GRADIENT_LINEAR"
         case gradientRadial = "GRADIENT_RADIAL"
         case image = "IMAGE"
         case solid = "SOLID"
    }
    
    enum ScaleMode: String, Codable {
        case fill = "FILL"
        case fit = "FIT"
        case crop = "STRETCH"
        case tile = "TILE"
    }
    
}


///----------------------------------------------------------------------------
extension Welcome {
    struct Components: Codable {
    }
    struct Styles: Codable {
    }
    enum CodingKeys: String, CodingKey {
        case document = "document"
        case components = "components"
        case schemaVersion = "schemaVersion"
        case styles = "styles"
        case name = "name"
        case lastModified = "lastModified"
        case thumbnailURL = "thumbnailUrl"
        case version = "version"
        case role = "role"
    }
}

extension Document {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case children = "children"
    }
    
    func dec(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode((Document.Type_).self, forKey: .type)
        
        switch type {
        case .document, .page, .frame, .group:
            
            var childrenContainer: UnkeyedDecodingContainer = try container.nestedUnkeyedContainer(forKey: .children)
            
            let count = childrenContainer.count ?? 0
            var children: [Document] = []
            for _ in 0 ..< count {
                
                
                let doc: Document? = try? childrenContainer.decode(Document.self)
                guard let doct = doc else { return }
                
                
                if "Combined Shape Copy" == doct.name {
                    
                }
                
                switch doct.type {
                case .document: children.append(doct)
                case .page:
                    let page: Page? = try? childrenContainer.decode(Page.self)
                    children.append(page!)
                case .frame, .group, .rectangle:
                    let view: View? = try? childrenContainer.decode(View.self)
                    children.append(view!)
                case .text: break
                default:
                    break
                }
            }
            self.children = children
            
        default: break
        }
        
        
    }
}

extension Page {
    enum CodingKeys: String, CodingKey {
        case backgroundColor = "backgroundColor"
        case prototypeStartNodeID = "prototypeStartNodeID"
        case prototypeDevice = "prototypeDevice"
    }
    func decView(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer = try decoder.container(keyedBy: CodingKeys.self)
        backgroundColor = try container.decode(Color.self, forKey: .backgroundColor)
        prototypeStartNodeID = try container.decode(JSONNull.self, forKey: .prototypeStartNodeID)
        prototypeDevice = try container.decode(PrototypeDevice.self, forKey: .prototypeDevice)
    }
}

extension View {
    
        enum CodingKeys: String, CodingKey {
            
//            case clipsContent = "clipsContent"
//            case visible = "visible"
//            case alpha = "opacity"
//            case cornerRadius = "cornerRadius"

//            case blendMode = "blendMode"
            case rect = "absoluteBoundingBox"
//            case layout = "constraints"
//            case fills = "fills"
//            case background = "background"
//            case backgroundColor = "backgroundColor"
//
//            case strokes = "strokes"
//            case strokeWeight = "strokeWeight"
//            case strokeAlign = "strokeAlign"
            
    //        case effects = "effects"
    //        case layoutGrids = "layoutGrids"
    //        case exportSettings = "exportSettings"
    //        case overflowDirection = "overflowDirection"
    //        case preserveRatio = "preserveRatio"
    //        case rectangleCornerRadii = "rectangleCornerRadii"
    //        case characters = "characters"
    //        case textStyle = "textStyle"
    //        case styles = "styles"
    //        case characterStyleOverrides = "characterStyleOverrides"
    //        case styleOverrideTable = "styleOverrideTable"
    //        case layoutVersion = "layoutVersion"
    //        case isMask = "isMask"
    //        case isMaskOutline = "isMaskOutline"
    //        case layoutMode = "layoutMode"
    //        case itemSpacing = "itemSpacing"
    //        case horizontalPadding = "horizontalPadding"
    //        case verticalPadding = "verticalPadding"
        }

    func decView(from decoder: Decoder) throws {
        
        let container: KeyedDecodingContainer = try decoder.container(keyedBy: CodingKeys.self)
//        blendMode = try container.decode(BlendMode.self, forKey: .blendMode)
        
        frame = try container.decode(Rect.self, forKey: .rect)
//        layout = try container.decode(Layout.self, forKey: .layout)
        
//        fills = try container.decode([Fill].self, forKey: .fills)
        /// Optional rect
//        background = try? container.decode([Fill].self, forKey: .background)
//        backgroundColor = try? container.decode(Color.self, forKey: .backgroundColor)
        
//        strokes = try container.decode([Fill].self, forKey: .strokes)
//        strokeWeight = try container.decode(Double.self, forKey: .strokeWeight)
//        strokeAlign = try container.decode(StrokeAlign.self, forKey: .strokeAlign)
        
        /// Optional
//        clipsContent = try? container.decode(Bool.self, forKey: .clipsContent)
//        visible = try? container.decode(Bool.self, forKey: .visible)
//        alpha = try? container.decode(Double.self, forKey: .alpha)
//        cornerRadius = try? container.decode(Int.self, forKey: .cornerRadius)
    }
}
   
extension Fill {
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case blendMode = "blendMode"
        case scaleMode = "scaleMode"
        case color = "color"
        case visible = "visible"
        case gradientHandlePositions = "gradientHandlePositions"
        case gradientStops = "gradientStops"
        case opacity = "opacity"
        case imageRef = "imageRef"
        case imageTransform = "imageTransform"
    }
}
extension Color {
    static let zero = Color(r: 0, g: 0, b: 0, a: 0)
}
extension PrototypeDevice {
    static let zero = PrototypeDevice(type: "", rotation: "")
}
///----------------------------------------------------------------------------





enum BlendMode: String, Codable {
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
}

// MARK: - Color
struct Color: Codable {
    let r, g, b, a: Double
}

// MARK: - AbsoluteBoundingBox
struct Rect: Codable {
    let x, y, width, height: Double
    static let zero = Rect(x: 0, y: 0, width: 0, height: 0)
}


// MARK: - GradientHandlePosition
struct GradientHandlePosition: Codable {
    let x, y: Double
}

// MARK: - GradientStop
struct GradientStop: Codable {
    let color: Color
    let position: Double
}

enum BooleanOperation: String, Codable {
    case exclude = "EXCLUDE"
    case intersect = "INTERSECT"
    case subtract = "SUBTRACT"
    case union = "UNION"
}

// MARK: - Autoresizing (Constraints)
struct Layout: Codable {
    let vertical: Vertical
    let horizontal: Horizontal
    static let zero = Layout(vertical: .top, horizontal: .horizontalLEFT)
}

enum Horizontal: String, Codable {
    case center = "CENTER"
    case horizontalLEFT = "LEFT"
    case horizontalRIGHT = "RIGHT"
    case leftRight = "LEFT_RIGHT"
    case scale = "SCALE"
}

enum Vertical: String, Codable {
    case bottom = "BOTTOM"
    case center = "CENTER"
    case scale = "SCALE"
    case top = "TOP"
    case topBottom = "TOP_BOTTOM"
}

enum Name: String, Codable {
    case bounds = "Bounds"
    case icMessage = "ic_message"
    case oval5 = "Oval 5"
    case path = "Path"
    case rectangle3 = "Rectangle 3"
    case rectangle3Copy = "Rectangle 3 Copy"
    case rectangle3Copy2 = "Rectangle 3 Copy 2"
    case rectangle3Copy3 = "Rectangle 3 Copy 3"
    case rectangle3Copy4 = "Rectangle 3 Copy 4"
    case rectangle3Copy5 = "Rectangle 3 Copy 5"
    case rectangle3Copy6 = "Rectangle 3 Copy 6"
    case rectangle3Copy7 = "Rectangle 3 Copy 7"
    case rectangle3Copy8 = "Rectangle 3 Copy 8"
    case rectanglePath = "Rectangle-path"
    case shape = "Shape"
    case union = "Union"
}


enum StrokeAlign: String, Codable {
    case center = "CENTER"
    case inside = "INSIDE"
    case outside = "OUTSIDE"
}

enum Stroke: String, Codable {
    case round = "ROUND"
}

// MARK: - Effect
struct Effect: Codable {
    let type: EffectType
    let visible: Bool
    let color: Color?
    let blendMode: BlendMode?
    let offset: GradientHandlePosition?
    let radius: Double
}

enum EffectType: String, Codable {
    case backgroundBlur = "BACKGROUND_BLUR"
    case dropShadow = "DROP_SHADOW"
    case innerShadow = "INNER_SHADOW"
}

// MARK: - ExportSetting
struct ExportSetting: Codable {
    let suffix: Suffix
    let format: Format
    let constraint: Constraint
}

// MARK: - Constraint
struct Constraint: Codable {
    let type: Horizontal
    let value: Int
}

enum Format: String, Codable {
    case jpg = "JPG"
    case png = "PNG"
    case svg = "SVG"
}

enum Suffix: String, Codable {
    case empty = ""
    case the2X = "@2x"
    case the3X = "@3x"
    case white = "_White"
}

// MARK: - Style
struct TextStyle: Codable {
    let fontFamily: FontFamily
    let fontPostScriptName: FontPostScriptName?
    let fontWeight: Int
    let textAutoResize: TextAutoResize?
    let fontSize: Double
    let textAlignHorizontal: Horizontal
    let textAlignVertical: Vertical
    let letterSpacing, lineHeightPx, lineHeightPercent: Double
    let lineHeightPercentFontSize: Double?
    let lineHeightUnit: LineHeightUnit
}

enum FontFamily: String, Codable {
    case circularAir = "Circular Air"
    case gtWalsheimPro = "GT Walsheim Pro"
    case helveticaNeue = "Helvetica Neue"
    case proximaNova = "Proxima Nova"
    case roboto = "Roboto"
    case sfCompactRounded = "SFCompactRounded"
    case sfProDisplay = "SF Pro Display"
    case sfProText = "SF Pro Text"
    case sfuiText = "SFUIText"
}

enum FontPostScriptName: String, Codable {
    case circularAirBold = "CircularAir-Bold"
    case circularAirBook = "CircularAir-Book"
    case gtWalsheimPro = "GTWalsheimPro"
    case gtWalsheimProBold = "GTWalsheimPro-Bold"
    case gtWalsheimProMedium = "GTWalsheimPro-Medium"
    case helveticaNeue = "HelveticaNeue"
    case proximaNovaBold = "ProximaNova-Bold"
    case proximaNovaExtrabld = "ProximaNova-Extrabld"
    case proximaNovaRegular = "ProximaNova-Regular"
    case proximaNovaSemibold = "ProximaNova-Semibold"
    case robotoMedium = "Roboto-Medium"
    case sfCompactRoundedRegular = "SFCompactRounded-Regular"
    case sfCompactRoundedSemibold = "SFCompactRounded-Semibold"
    case sfProDisplayBold = "SFProDisplay-Bold"
    case sfProDisplayHeavy = "SFProDisplay-Heavy"
    case sfProTextLight = "SFProText-Light"
    case sfProTextRegular = "SFProText-Regular"
    case sfProTextSemibold = "SFProText-Semibold"
    case sfuiTextRegular = "SFUIText-Regular"
    case sfuiTextSemibold = "SFUIText-Semibold"
}

enum LineHeightUnit: String, Codable {
    case intrinsic = "INTRINSIC_%"
    case pixels = "PIXELS"
}

enum TextAutoResize: String, Codable {
    case height = "HEIGHT"
    case widthAndHeight = "WIDTH_AND_HEIGHT"
}

// MARK: - PurpleStyleOverrideTable
struct PurpleStyleOverrideTable: Codable {
}

// MARK: - PurpleStyles
struct PurpleStyles: Codable {
    let fill: TentacledFill?
    let stroke: StickyFill?
}

enum TentacledFill: String, Codable {
    case the242 = "24:2"
    case the243 = "24:3"
    case the244 = "24:4"
    case the2720 = "272:0"
    case the2721 = "272:1"
    case the2722 = "272:2"
    case the2723 = "272:3"
}

enum StickyFill: String, Codable {
    case the2722 = "272:2"
    case the2723 = "272:3"
    case the2725 = "272:5"
    case the2726 = "272:6"
}


// MARK: - FluffyStyleOverrideTable
struct FluffyStyleOverrideTable: Codable {
    let the1: StyleOverrideTable?

    enum CodingKeys: String, CodingKey {
        case the1 = "1"
    }
}

// MARK: - StyleOverrideTable
struct StyleOverrideTable: Codable {
    let fills: [Fill]
}

// MARK: - FluffyStyles
struct FluffyStyles: Codable {
    let stroke: StickyFill?
    let fill, effect: String?
}

// MARK: - TentacledStyleOverrideTable
struct TentacledStyleOverrideTable: Codable {
    let letterSpacing: Double
}

// MARK: - TentacledStyles
struct TentacledStyles: Codable {
    let fill: StickyFill
    let stroke: TentacledFill?
    let text: String?
}

// MARK: - StickyStyles
struct StickyStyles: Codable {
    let fill: TentacledFill
}

// MARK: - PrototypeDevice
struct PrototypeDevice: Codable {
    let type, rotation: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
