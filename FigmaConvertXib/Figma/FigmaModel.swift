//
//  FigmaModel.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 25.06.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - ✅ Welcome
struct Welcome: Codable {
    let document: Document
    let components: Components
    let schemaVersion: Int
    let styles: WelcomeStyles
    let name, lastModified: String
    let thumbnailURL: String
    let version, role: String

    enum CodingKeys: String, CodingKey {
        case document, components, schemaVersion, styles, name, lastModified
        case thumbnailURL = "thumbnailUrl"
        case version, role
    }
}

// MARK: - Components
struct Components: Codable {
}

// MARK: - Document
struct Document: Codable {
    let id, name, type: String
    let children: [DocumentChild]
}

// MARK: - DocumentChild
struct DocumentChild: Codable {
    let id, name, type: String
    let children: [PurpleChild]
    let backgroundColor: Color
    let prototypeStartNodeID: JSONNull?
    let prototypeDevice: PrototypeDevice
}

// MARK: - Color
struct Color: Codable {
    let r, g, b, a: Double
}

// MARK: - PurpleChild
struct PurpleChild: Codable {
    let id, name, type, blendMode: String
    let absoluteBoundingBox: AbsoluteBoundingBox
    let constraints: Constraints
    let fills: [PurpleBackground]
    let strokes: [JSONAny]
    let strokeWeight: Int
    let strokeAlign: String
    let effects: [JSONAny]
    let children: [FluffyChild]?
    let clipsContent: Bool?
    let background: [PurpleBackground]?
    let backgroundColor: Color?
    let layoutGrids: [JSONAny]?
}

// MARK: - AbsoluteBoundingBox
struct AbsoluteBoundingBox: Codable {
    let x, y, width, height: Double
}

// MARK: - PurpleBackground
struct PurpleBackground: Codable {
    let blendMode: BlendMode
    let type: TypeEnum
    let color: Color?
    let visible: Bool?
    let gradientHandlePositions: [GradientHandlePosition]?
    let gradientStops: [GradientStop]?
}

enum BlendMode: String, Codable {
    case normal = "NORMAL"
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

enum TypeEnum: String, Codable {
    case gradientLinear = "GRADIENT_LINEAR"
    case image = "IMAGE"
    case solid = "SOLID"
}

// MARK: - FluffyChild
struct FluffyChild: Codable {
    let id, name, type, blendMode: String
    let absoluteBoundingBox: AbsoluteBoundingBox
    let constraints: Constraints
    let fills: [Fill]
    let strokes: [StrokeElement]
    let strokeWeight: Double
    let strokeAlign: String
    let effects: [JSONAny]
    let cornerRadius: Int?
    let rectangleCornerRadii: [Int]?
    let children: [TentacledChild]?
    let clipsContent: Bool?
    let background: [StrokeElement]?
    let backgroundColor: Color?
    let characters: String?
    let style: Style?
    let characterStyleOverrides: [JSONAny]?
    let styleOverrideTable: Components?
    let preserveRatio: Bool?
}

// MARK: - StrokeElement
struct StrokeElement: Codable {
    let blendMode: BlendMode
    let visible: Bool?
    let type: TypeEnum
    let color: Color
}

// MARK: - TentacledChild
struct TentacledChild: Codable {
    let id, name: String
    let visible: Bool?
    let type, blendMode: String
    let absoluteBoundingBox: AbsoluteBoundingBox
    let constraints: Constraints
    let fills: [Fill]
    let strokes: [StrokeElement]
    let strokeWeight: Int
    let strokeAlign: String
    let effects: [Effect]
    let cornerRadius: Int?
    let rectangleCornerRadii: [Int]?
    let children: [StickyChild]?
    let clipsContent: Bool?
    let background: [PurpleBackground]?
    let backgroundColor: Color?
    let layoutGrids: [JSONAny]?
    let exportSettings: [ExportSetting]?
    let preserveRatio: Bool?
    let characters: String?
    let style: Style?
    let layoutVersion: Int?
    let characterStyleOverrides: [JSONAny]?
    let styleOverrideTable: Components?
}

// MARK: - StickyChild
struct StickyChild: Codable {
    let id, name, type, blendMode: String
    let opacity: Double?
    let absoluteBoundingBox: AbsoluteBoundingBox
    let constraints: Constraints
    let fills, strokes: [StrokeElement]
    let strokeWeight: Int
    let strokeAlign: String
    let styles: ChildStyles?
    let effects: [JSONAny]
    let children: [IndigoChild]?
    let clipsContent: Bool?
    let background: [StrokeElement]?
    let backgroundColor: Color?
}

// MARK: - IndigoChild
struct IndigoChild: Codable {
    let id, name, type, blendMode: String
    let absoluteBoundingBox: AbsoluteBoundingBox
    let constraints: Constraints
    let fills: [JSONAny]
    let strokes: [StrokeElement]
    let strokeWeight: Int
    let strokeAlign: Horizontal
    let strokeCap, strokeJoin: String
    let styles: ChildStyles
    let effects: [JSONAny]
}

// MARK: - Constraints
struct Constraints: Codable {
    let vertical: Vertical
    let horizontal: Horizontal
}

enum Horizontal: String, Codable {
    case center = "CENTER"
    case horizontalLEFT = "LEFT"
    case leftRight = "LEFT_RIGHT"
    case scale = "SCALE"
}

enum Vertical: String, Codable {
    case center = "CENTER"
    case scale = "SCALE"
    case top = "TOP"
    case topBottom = "TOP_BOTTOM"
}

// MARK: - ChildStyles
struct ChildStyles: Codable {
    let stroke: String
}

// MARK: - Effect
struct Effect: Codable {
    let type: String
    let visible: Bool
    let color: Color
    let blendMode: BlendMode
    let offset: GradientHandlePosition
    let radius: Int
}

// MARK: - ExportSetting
struct ExportSetting: Codable {
    let suffix, format: String
    let constraint: Constraint
}

// MARK: - Constraint
struct Constraint: Codable {
    let type: Horizontal
    let value: Int
}

// MARK: - Fill
struct Fill: Codable {
    let opacity: Double?
    let blendMode: BlendMode
    let type: TypeEnum
    let gradientHandlePositions: [GradientHandlePosition]?
    let gradientStops: [GradientStop]?
    let color: Color?
    let scaleMode, imageRef: String?
    let visible: Bool?
}

// MARK: - Style
struct Style: Codable {
    let fontFamily: String
    let fontPostScriptName: String?
    let fontWeight: Int
    let textAutoResize: String?
    let fontSize: Int
    let textAlignHorizontal: Horizontal
    let textAlignVertical: Vertical
    let letterSpacing, lineHeightPx, lineHeightPercent: Double
    let lineHeightPercentFontSize: Double?
    let lineHeightUnit: String
}

// MARK: - PrototypeDevice
struct PrototypeDevice: Codable {
    let type: String
    let size: Size?
    let presetIdentifier: String?
    let rotation: String
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int
}

// MARK: - WelcomeStyles
struct WelcomeStyles: Codable {
    let the58102: The58102

    enum CodingKeys: String, CodingKey {
        case the58102 = "58:102"
    }
}

// MARK: - The58102
struct The58102: Codable {
    let key, name, styleType, the58102_Description: String

    enum CodingKeys: String, CodingKey {
        case key, name, styleType
        case the58102_Description = "description"
    }
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

//MARK: JSON Coding Key

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

//MARK: JSON Any

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

