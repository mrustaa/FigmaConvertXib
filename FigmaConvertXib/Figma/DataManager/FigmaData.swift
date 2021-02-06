//
//  FigmaData.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 24.06.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

class FigmaData {
    
    //MARK: - Current
    
    static let current = FigmaData()
    
    //MARK: - Result = Response.Data ✅
    
    var response: FigmaResponse?
    var imagesURLs: [String: String]?

    //MARK: - Figma.Api Token.Key 🔑
    
//    let token = ""
    
    //MARK: - Test.Figma.Doc IDs
    
//    public enum documentId: String {
//        case GererateXML  = ""
//        case Untitled     = ""
//    }
    
    //MARK: - Figma.Api URLs
    
    static let apiURL   = "https://api.figma.com/v1/"
    let apiURLMe        = (apiURL + "me")
    let apiURLFiles     = (apiURL + "files/")
    let apiURLComponent = (apiURL + "images/")
    
    public enum RequestType {
        case Me
        case Files
        case Images
    }
    
    //MARK: - Figma.Api Image.Form.Type
    
    public enum RequestComponentFormat: String {
        case JPG = "jpg"
        case PNG = "png"
        case SVG = "svg"
        case PDF = "pdf"
    }
    
    //MARK: - Callbacks
    
    typealias CompletionJSON        = (_ json: [String:Any]?) -> Void
    typealias CompletionDataJSON    = (_ data: Data, _ json: [String:Any]?) -> Void
    typealias CompletionBool        = (_ value: Bool) -> Void
    typealias CompletionString      = (_ value: String?) -> Void
    typealias Completion            = () -> Void

}
