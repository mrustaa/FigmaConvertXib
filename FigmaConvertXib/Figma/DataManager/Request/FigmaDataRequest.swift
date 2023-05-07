//
//  FigmaDataClearFolder.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 25.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension FigmaData {
    
    //MARK: - Request Figma
    
    func requestFiles(projectKey: String, completion: FigmaData.Completion?) {
        
        response = nil
        imagesURLs = nil
        
        request(projectId: projectKey, type: .Files, compJson: { [weak self] (data, json: [String:Any]?) in
            guard let _self = self else { return }
            guard let json = json else { return }
            
            _self.response = FigmaResponse(json)
            
            guard (_self.imagesURLs != nil) else { return }
            completion?()
            
        })
        
        request(projectId: projectKey, type: .Images, compJson: { [weak self] (data, json: [String:Any]?) in
            guard let json = json else { return }
            guard let _self = self else { return }
            
            guard let meta = json["meta"] as? [String: Any] else { return }
            guard let images = meta["images"] as? [String: String] else { return }
            _self.imagesURLs = images
                
            guard (_self.response != nil) else { return }
            completion?()
        })
        
    }
    
    func getComponentURL(key: String, nodeId: String, format: RequestComponentFormat) -> URL? {
        
        let srtURL = "\(apiURLComponent)\(key)/?ids=\(nodeId)&scale=\(3.0)&format=\(format.rawValue)"
        guard let url = URL(string: srtURL) else { return nil }
        return url
    }
    
    func requestComponent(key: String, nodeId: String, format: RequestComponentFormat, compJson: FigmaData.CompletionDataJSON? = nil) {
        
        guard let url = getComponentURL(key: key, nodeId: nodeId, format: format) else { return }
        
        
        guard let token = LocalData.current.token else {
            compJson?(Data(), getError("token") )
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["X-Figma-Token" : token]
        
//      print( request.writeRequest() )
      
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    guard let currentData: Data = data, error == nil else { return }
          
          if let httpResponse = response as? HTTPURLResponse {
//            print( httpResponse.writeResponse(data: currentData) )
          }
          
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
    
    func getError(_ text: String) -> [String: String] {
        return [ "err" : text ]
    }
    
    func request(projectId: String? = nil, type: RequestType, compJson: FigmaData.CompletionDataJSON? = nil) {
        
        var projId = ""
        if type != .Me {
            guard let projectId = projectId else { return }
            projId = projectId
        }
        
        var srtURL = ""
        switch type {
        case .Me:     srtURL = apiURLMe
        case .Files:  srtURL = "\(apiURLFiles)\(projId)"
        case .Images: srtURL = "\(apiURLFiles)\(projId)/images"
            
        }
        
        guard let url = URL(string: srtURL) else {
            compJson?(Data(), getError("url") )
            return
        }
        
        guard let token = LocalData.current.token else {
            compJson?(Data(), getError("token") )
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["X-Figma-Token" : token]
        
//      print( request.writeRequest() )
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let currentData: Data = data, error == nil else { return }
            
          if let httpResponse = response as? HTTPURLResponse {
//            print( httpResponse.writeResponse(data: currentData) )
          }
            if type != .Me {
                compJson?(currentData, nil)
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: currentData, options: .allowFragments) as? [String : Any] {
                    DispatchQueue.main.async {
                        if ((json["err"] as? String) != nil) {
                            compJson?(currentData, nil)
                            return
                        } else {
                            compJson?(currentData, json)
                        }
                    }
                }
            } catch {
                print(error)
            }
        }).resume()
        
    }
    
    func checkTokenRequest(complectionExists: FigmaData.CompletionJSON? = nil, errorCallback: Completion? = nil) {
        
        request(type: .Me, compJson: { (data, json: [String:Any]?) in
            guard let json = json else {
                complectionExists?(nil)
                return
            }
            
            complectionExists?(json)
        })
        
    }
    
    func checkProjectRequest(key: String, complectionExists: FigmaData.CompletionString? = nil) {
        
        request(projectId: key, type: .Files, compJson: { (data, json: [String:Any]?) in
            guard let json = json else { return }
            
            if ((json["err"] as? String) != nil) {
                complectionExists?(nil)
                return
            }
            
            guard let name = json["name"] as? String else {
                complectionExists?(nil)
                return
            }
            
            complectionExists?(name)
        })
    }
    
}
