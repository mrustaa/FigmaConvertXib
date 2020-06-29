//
//  FigmaData.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 24.06.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

class FigmaData {
    
    static let current = FigmaData()
    
    //MARK: Request
    
    typealias CompletionJSON = (_ data: Data, _ json: [String:Any]?) -> Void
    typealias Completion = () -> Void
    
    public enum documentId: String {
        case RuStAm4iK = "PLRDJ59Baio6xjpmylVt3T"
        case Short = "Zy47vycoawoNCIcEg8ygH5"
        case All = "9KadDT1iy1EX0wJMY7qhSY"
        case Coffee = "M0q8R4TA8Lb4TB5lJSIq98"
    }
    
    var customDocId: String?
    
    let token = "44169-d6b5edd3-c479-475f-bee5-d0525b239ad0"
    
    let apiURL = "https://api.figma.com/v1/files/"
    
    public enum RequestType {
        case Files
        case Images
    }
    
    //MARK: - Result
    
    var resporse: FigmaResponse?
    var imagesURLs: [String: String]?
    
    
    //MARK: - Request Figma
    
    func requestFiles(documentId: String? = nil, completion: FigmaData.Completion?) {
        
        customDocId = documentId
        
        resporse = nil
        imagesURLs = nil
        
        request(type: .Files, compJson: { [weak self] (data, json: [String:Any]?) in
            guard let json = json else { return }
            guard let _self = self else { return }
            
//            var welcome: Welcome = try! JSONDecoder().decode(Welcome.self, from: data)
            
            _self.resporse = FigmaResponse(json)
            
            guard (_self.imagesURLs != nil) else { return }
            completion?()
            
        })
        
        request(type: .Images, compJson: { [weak self] (data, json: [String:Any]?) in
            guard let json = json else { return }
            guard let _self = self else { return }
            
            guard let meta = json["meta"] as? [String: Any] else { return }
            guard let images = meta["images"] as? [String: String] else { return }
            _self.imagesURLs = images
                
            guard (_self.resporse != nil) else { return }
            completion?()
        })
        
    }
    
    
    func request(type: RequestType, compJson: FigmaData.CompletionJSON?) {
        
        let typeURL = (type == .Images ? "/images" : "")
        
        var srtURL = "\(apiURL)\(FigmaData.documentId.RuStAm4iK.rawValue)\(typeURL)"
        if let customDocId = customDocId {
            srtURL = "\(apiURL)\(customDocId)\(typeURL)"
        }
        
        
        let url = URL(string: srtURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["X-Figma-Token" : token]
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let currentData: Data = data, error == nil else { return }
            compJson?(currentData, nil)
            do {
                if let json = try JSONSerialization.jsonObject(with: currentData, options: .allowFragments) as? [String : Any] {
                    DispatchQueue.main.async {
                        compJson?(currentData, json)
                    }
                }
            } catch {
                print(error)
            }
        }).resume()
        
    }
    
}
