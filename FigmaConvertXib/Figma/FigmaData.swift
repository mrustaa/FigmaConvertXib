//
//  FigmaData.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 24.06.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

class F_PrototypeDevice: Codable {
    var type: String
    var size: String
    var presetIdentifier: String
    var rotation: String
}

class F_Color: Codable {
    var r: Double
    var g: Double
    var b: Double
    var a: Double
}

//class F_Page: F_Document {
//    var backgroundColor: F_Color
//    var prototypeDevice: F_PrototypeDevice
//
//    private enum CodingKeys: String, CodingKey {
//        case backgroundColor
//        case prototypeDevice
//    }
//
//    required init(from decoder: Decoder) throws {
//
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        backgroundColor = try container.decode(F_Color.self, forKey: .backgroundColor)
//        prototypeDevice = try container.decode(F_PrototypeDevice.self, forKey: .prototypeDevice)
//
//        let superdecoder = try container.superDecoder()
//        try super.init(from: superdecoder)
//
//    }
//
//}

     
class F_Document: Codable {
    
    var id: String
    var name: String
    var type: F_DocType
    var children: [F_Document]?
    
    enum F_DocType: String, Codable {
        case booleanOperation = "BOOLEAN_OPERATION"
        case boolean = "BOOLEAN"
        case component = "COMPONENT"
        case document = "DOCUMENT"          /// Главный Документ
        case canvas = "CANVAS"              /// Page Страница
        case frame = "FRAME"                /// Размер
        case ellipse = "ELLIPSE"            /// Овал
        case vector = "VECTOR"              /// Вектор
        case group = "GROUP"                /// Группа - группа не удаляет x y
        case instance = "INSTANCE"
        case line = "LINE"
        case regularPolygon = "REGULAR_POLYGON"
        case slice = "SLICE"
        case star = "STAR"
        case text = "TEXT"                  /// Label Текст
        case rectangle = "RECTANGLE"        /// Прямоугольник
    }
    
    /// Page
    var backgroundColor: F_Color?
    var prototypeDevice: F_PrototypeDevice?
    
    //MARK: Decoding
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case children
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(F_DocType.self, forKey: .type)

        children = try? container.decode([F_Document].self, forKey: .children)
    }
//
    
}

class F_Response: Codable {
    
    var document: F_Document
    var schemaVersion: Double
    var name: String
    var lastModified: String
    var thumbnailUrl: String
    var version: String
    var role: String
    // var components: [String: Any]
    
    init(_ r: F_Response) {
        document = r.document; schemaVersion = r.schemaVersion; name = r.name; lastModified = r.lastModified; thumbnailUrl = r.thumbnailUrl; version = r.version; role = r.role
    }
}


extension F_Response {
    convenience init(data: Data) {
        let r: F_Response = try! JSONDecoder().decode(F_Response.self, from: data)
        self.init(r)
    }
}



    
    
//    public init(data: Data) throws {
//        self = try JSONDecoder().decode(FigmaResponse.self, from: data)
//    }
//
//    public init(_ json: String, using encoding: String.Encoding = .utf8) throws {
//        guard let data = json.data(using: encoding) else {
//            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
//        }
//        try self.init(data: data)
//    }
//}



class FigmaData {
    
    static let current = FigmaData()
    
    //MARK: Request
    
    typealias CompletionData = (_ data: Data) -> Void
    typealias CompletionJSON = (_ json: [String:Any]) -> Void
    typealias Completion = () -> Void
    
    public enum documentId: String {
        case Short = "Zy47vycoawoNCIcEg8ygH5"
        case All = "9KadDT1iy1EX0wJMY7qhSY"
        case Coffee = "M0q8R4TA8Lb4TB5lJSIq98"
    }
    
    let token = "44169-d6b5edd3-c479-475f-bee5-d0525b239ad0"
    
    let apiURL = "https://api.figma.com/v1/files/"
    
    public enum RequestType {
        case Files
        case Images
    }
    
    //MARK: - Result
    
    var page: PageClass? 
    var imagesURLs: [String: String]?
    

    
    //MARK: - Request Figma
    
    func requestFiles(completion: FigmaData.Completion?) {
        
        page = nil
        imagesURLs = nil
        
        request(type: .Files, compJson: { [weak self] (json: [String:Any]) in
            guard let _self = self else { return }
            
            let fileResponse = FileResponse(json)
            guard let page = fileResponse.document?.children[0].children[0] else { return }
            _self.page = page
            
            guard (_self.imagesURLs != nil) else { return }
            completion?()
            
            }, compData: { [weak self] (data: Data) in
                guard let _self = self else { return }
                
                let re = F_Response(data: data)
            })
        
        request(type: .Images, compJson: { [weak self] (json: [String:Any]) in
            guard let _self = self else { return }
            
            guard let meta = json["meta"] as? [String: Any] else { return }
            guard let images = meta["images"] as? [String: String] else { return }
            _self.imagesURLs = images
                
            guard (_self.page != nil) else { return }
            completion?()
        })
        
    }
    
    
    func request(type: RequestType, compJson: FigmaData.CompletionJSON?, compData: FigmaData.CompletionData? = nil) {
        
        let typeURL = (type == .Images ? "/images" : "")
        let srtURL = "\(apiURL)\(FigmaData.documentId.Short)\(typeURL)"
        
        let url = URL(string: srtURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["X-Figma-Token" : token]
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else { return }
            compData?(data)
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] {
                    DispatchQueue.main.async {
                        compJson?(json)
                    }
                }
            } catch {
                print(error)
            }
        }).resume()
        
    }
    
}
