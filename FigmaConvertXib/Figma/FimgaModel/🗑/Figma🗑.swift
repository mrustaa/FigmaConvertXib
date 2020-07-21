//
//  FigmaModel.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 25.06.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//



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


//// MARK: - StickyChild
//struct StickyChild: Codable {
//    let id, name: String
//    let type: ChildType
//    let blendMode: BlendMode?
//    let opacity: Double?
//    let absoluteBoundingBox: AbsoluteBoundingBox
//    let constraints: Constraints
//    let fills: [PurpleFill]?
//    let strokes: [StrokeElement]?
//    let strokeWeight: Double?
//    let strokeAlign: StrokeAlign?
//    let effects: [Effect]?
//    let characters: String?
//    let style: Style?
//    let layoutVersion: Int?
//    let characterStyleOverrides: [Int]?
//    let styleOverrideTable: [String: StyleOverrideTable]?
//    let visible: Bool?
//    let children: [IndigoChild]?
//    let clipsContent: Bool?
//    let background: [StrokeElement]?
//    let backgroundColor: Color?
//    let exportSettings: [ExportSetting]?
//    let rectangleCornerRadii: [Int]?
//    let cornerRadius: Double?
//    let styles: FluffyStyles?
//    let preserveRatio: Bool?
//    let strokeCap, strokeJoin: Stroke?
//    let booleanOperation: BooleanOperation?
//    let layoutGrids: [JSONAny]?
//    let layoutMode: String?
//    let itemSpacing, horizontalPadding, verticalPadding: Int?
//    let strokeMiterAngle: Double?
//    let layoutAlign: String?
//}
//
//// MARK: - IndigoChild
//struct IndigoChild: Codable {
//    let id, name: String
//    let type: ChildType
//    let blendMode: BlendMode?
//    let absoluteBoundingBox: AbsoluteBoundingBox
//    let constraints: Constraints
//    let fills: [FluffyFill]?
//    let strokes: [StrokeElement]?
//    let strokeWeight: Double?
//    let strokeAlign: StrokeAlign?
//    let effects: [Effect]?
//    let visible: Bool?
//    let children: [IndecentChild]?
//    let clipsContent: Bool?
//    let background: [StrokeElement]?
//    let backgroundColor: Color?
//    let preserveRatio: Bool?
//    let booleanOperation: BooleanOperation?
//    let layoutGrids: [JSONAny]?
//    let strokeCap, strokeJoin: Stroke?
//    let styles: PurpleStyles?
//    let opacity: Double?
//    let characters: String?
//    let style: Style?
//    let layoutVersion: Int?
//    let characterStyleOverrides: [Int]?
//    let styleOverrideTable: FluffyStyleOverrideTable?
//    let exportSettings: [ExportSetting]?
//    let cornerRadius: Double?
//    let isMask, isMaskOutline: Bool?
//    let layoutAlign: String?
//    let rectangleCornerRadii: [Int]?
//    let strokeMiterAngle: Double?
//}
//
//// MARK: - IndecentChild
//struct IndecentChild: Codable {
//    let id, name: String
//    let type: ChildType
//    let blendMode: BlendMode?
//    let opacity: Double?
//    let absoluteBoundingBox: AbsoluteBoundingBox
//    let constraints: Constraints
//    let fills: [FluffyFill]?
//    let strokes: [StrokeElement]?
//    let strokeWeight: Double?
//    let strokeAlign: StrokeAlign?
//    let effects: [Effect]?
//    let children: [HilariousChild]?
//    let clipsContent: Bool?
//    let background: [StrokeElement]?
//    let backgroundColor: Color?
//    let strokeCap, strokeJoin: Stroke?
//    let cornerRadius: Double?
//    let visible: Bool?
//    let booleanOperation: BooleanOperation?
//    let preserveRatio: Bool?
//    let layoutGrids: [JSONAny]?
//    let exportSettings: [ExportSetting]?
//    let characters: String?
//    let style: Style?
//    let layoutVersion: Int?
//    let characterStyleOverrides: [JSONAny]?
//    let styleOverrideTable: PurpleStyleOverrideTable?
//    let styles: PurpleStyles?
//    let strokeMiterAngle: Double?
//    let isMask: Bool?
//}
//
//// MARK: - HilariousChild
//struct HilariousChild: Codable {
//    let id, name: String
//    let type: ChildType
//    let blendMode: BlendMode
//    let absoluteBoundingBox: AbsoluteBoundingBox
//    let constraints: Constraints
//    let fills: [PurpleFill]
//    let strokes: [StrokeElement]
//    let strokeWeight: Double
//    let strokeAlign: StrokeAlign
//    let strokeCap, strokeJoin: Stroke?
//    let effects: [Effect]
//    let cornerRadius: Double?
//    let booleanOperation: BooleanOperation?
//    let children: [AmbitiousChild]?
//    let rectangleCornerRadii: [Int]?
//    let visible, isMask, isMaskOutline: Bool?
//    let opacity: Double?
//    let clipsContent: Bool?
//    let background: [StrokeElement]?
//    let backgroundColor: Color?
//    let exportSettings: [ExportSetting]?
//    let preserveRatio: Bool?
//    let layoutGrids: [JSONAny]?
//    let styles: PurpleStyles?
//    let strokeMiterAngle: Double?
//}
//
//// MARK: - AmbitiousChild
//struct AmbitiousChild: Codable {
//    let id, name: String
//    let type: ChildType
//    let blendMode: BlendMode
//    let absoluteBoundingBox: AbsoluteBoundingBox
//    let constraints: Constraints
//    let fills, strokes: [StrokeElement]
//    let strokeWeight: Int
//    let strokeAlign: StrokeAlign
//    let effects: [JSONAny]
//    let strokeCap, strokeJoin: Stroke?
//    let cornerRadius: Int?
//    let booleanOperation: BooleanOperation?
//    let children: [CunningChild]?
//    let rectangleCornerRadii: [Int]?
//    let visible, isMask, isMaskOutline: Bool?
//    let opacity: Double?
//    let clipsContent: Bool?
//    let background: [StrokeElement]?
//    let backgroundColor: Color?
//    let characters: String?
//    let style: Style?
//    let layoutVersion: Int?
//    let characterStyleOverrides: [JSONAny]?
//    let styleOverrideTable: PurpleStyleOverrideTable?
//    let exportSettings: [ExportSetting]?
//}
//
//// MARK: - CunningChild
//struct CunningChild: Codable {
//    let id, name: String
//    let type: ChildType
//    let blendMode: BlendMode
//    let absoluteBoundingBox: AbsoluteBoundingBox
//    let constraints: Constraints
//    let fills, strokes: [StrokeElement]
//    let strokeWeight: Int
//    let strokeAlign: StrokeAlign
//    let effects: [Effect]
//    let opacity: Double?
//    let strokeCap, strokeJoin: Stroke?
//    let children: [MagentaChild]?
//    let clipsContent: Bool?
//    let background: [StrokeElement]?
//    let backgroundColor: Color?
//    let visible: Bool?
//    let booleanOperation: BooleanOperation?
//    let layoutGrids: [JSONAny]?
//    let exportSettings: [ExportSetting]?
//}
//
//// MARK: - MagentaChild
//struct MagentaChild: Codable {
//    let id, name: String
//    let type: ChildType
//    let blendMode: BlendMode
//    let absoluteBoundingBox: AbsoluteBoundingBox
//    let constraints: Constraints
//    let fills, strokes: [StrokeElement]
//    let strokeWeight: Int
//    let strokeAlign: StrokeAlign
//    let strokeCap, strokeJoin: Stroke?
//    let effects: [JSONAny]
//    let opacity: Double?
//    let visible: Bool?
//    let children: [FriskyChild]?
//    let clipsContent: Bool?
//    let background: [StrokeElement]?
//    let backgroundColor: Color?
//    let booleanOperation: BooleanOperation?
//    let cornerRadius: Double?
//}
//
//// MARK: - FriskyChild
//struct FriskyChild: Codable {
//    let id: String
//    let name: Name
//    let type: ChildType
//    let blendMode: BlendMode
//    let absoluteBoundingBox: AbsoluteBoundingBox
//    let constraints: Constraints
//    let fills, strokes: [StrokeElement]
//    let strokeWeight: Int
//    let strokeAlign: StrokeAlign
//    let strokeCap, strokeJoin: Stroke?
//    let effects: [JSONAny]
//    let cornerRadius: Int?
//    let booleanOperation: BooleanOperation?
//    let children: [MischievousChild]?
//    let rectangleCornerRadii: [Int]?
//    let visible: Bool?
//    let opacity: Double?
//}
//
//// MARK: - MischievousChild
//struct MischievousChild: Codable {
//    let id: String
//    let name: Name
//    let type: ChildType
//    let blendMode: BlendMode
//    let absoluteBoundingBox: AbsoluteBoundingBox
//    let constraints: Constraints
//    let fills: [StrokeElement]
//    let strokes: [JSONAny]
//    let strokeWeight: Int
//    let strokeAlign: Horizontal
//    let effects: [JSONAny]
//}
