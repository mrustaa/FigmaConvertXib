//
//  DownloadMultiple.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 10.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit
import Foundation



class FigmaImgURL {
    
    var name: String
    var url: URL?
    var urlComponent: URL?
    var index: Int?
    
    init(name: String, url: URL? = nil, urlComponent: URL? = nil) {
        self.name         = name
        self.url          = url
        self.urlComponent = urlComponent
    }
}


extension FigmaNode {
    
    //--------------------------------------------------------------------------
    
    func donwloadImages(URLs: [String: String], projectKey: String) {
        
        let count = donwloadImagesCount(0)
        print("🔥 \(count)")
        
        
//        let fillImagesURLs_: [FigmaImgURL] = fillImagesURLs(imageURLs: URLs)
//        donwloadMultiple(URLs: fillImagesURLs_)
        
        let componentImageURLsForm_ = componentImageURLsForm(projectKey: projectKey)
        donwloadMultipleComponent(URLs: componentImageURLsForm_, callback: { urls in

        })
        
//        donwloadMultipleImage(URLs: []) { (img) in
//
//        }
        
//        var arrayURLs: [URL] = []
//        donwloadImages(URLs: URLs, projectKey: projectKey, addURLcallback: { (url: URL) in
//            arrayURLs.append(url)
//            print("🧩 \(arrayURLs.count) \(url)")
//        })
        
    }
    
    //--------------------------------------------------------------------------
    // MARK: - GET img-url fill
    
    func fillImagesURLs(imageURLs: [String: String]) -> [FigmaImgURL] {
        
        var result: [FigmaImgURL] = []
        
        for fill: FigmaFill in fills {
            
            if fill.type == .image {
                if let imageURL = imageURLs[fill.imageRef] {
                    if let url = URL(string: imageURL) {
                        
                        let furl = FigmaImgURL(name: name, url: url)
                        result.append(furl)
                    }
                    
                }
            }
        }
        
        var childrenURLs: [FigmaImgURL] = []
        if type != .component {
            for node: FigmaNode in children {
                if node.visible,
                   node.type != .vector,
                   node.type != .booleanOperation {
                    
                    childrenURLs += node.fillImagesURLs(imageURLs: imageURLs)
                }
            }
        }
        
        result += childrenURLs
        
        return result
    }
    
    //--------------------------------------------------------------------------
    // MARK: - GET img-url component
    
    func componentImageURLsForm(projectKey: String) -> [FigmaImgURL] {
        
        var result: [FigmaImgURL] = []
        
        if type == .component {
            if let url = FigmaData.current.getComponentURL(key: projectKey, nodeId: id, format: .PNG) {
                
                let furl = FigmaImgURL(name: name, urlComponent: url)
                result.append(furl)
            }
        }
        
        var childrenURLs: [FigmaImgURL] = []
        if type != .component {
            for node: FigmaNode in children {
                if node.visible,
                   node.type != .vector,
                   node.type != .booleanOperation {
                    
                    childrenURLs += node.componentImageURLsForm(projectKey: projectKey)
                }
            }
        }
        
        result += childrenURLs
        
        return result
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Count All Images
    
    func donwloadImagesCount(_ count: Int) -> Int {
        
        var count_: Int = count
        
        for fill: FigmaFill in fills {
            if fill.type == .image {
                count_ += 1
                
                return count_
            }
        }
        
        if type == .component {
            count_ += 1
            
            return count_
        }
        
        var childrenCount: Int = 0
        if type != .component {
            for node: FigmaNode in children {
                if node.visible,
                   node.type != .vector,
                   node.type != .booleanOperation {
                    
                    childrenCount += node.donwloadImagesCount(0)
                }
            }
        }
        
        count_ += childrenCount
        
        return count_
    }
    
    //--------------------------------------------------------------------------
    // MARK: - OLD
    
    func donwloadImages(URLs: [String: String], projectKey: String, addURLcallback: @escaping ((_ url: URL) -> Void) )  {
        
        for fill: FigmaFill in fills {
            
            if fill.type == .image {
                if let imageURL = URLs[fill.imageRef] {
                let url = URL(string: imageURL)!
                    
                    addURLcallback(url)
//                    print("🦠 \(url)")
                }
            }
        }
        
        
        if type == .component {

            FigmaData.current.requestComponent(key: projectKey, nodeId: id, format: .PNG, compJson: {
                [weak self] (data, json: [String:Any]?) in
                
                guard let _self = self,
                    let json = json,
                    let nodeID = json["images"] as? [String: String],
                    let imageURL = nodeID[_self.id] else { return }
                
                let url = URL(string: imageURL)!
                
                addURLcallback(url)
//                print("🧩 \(url)")
            })
        }
        
        
//        if let imageURL = URLs[imageFill.imageRef] {
//            let url = URL(string: imageURL)!
//
//            FigmaData.downloadImage(url: url, completion: { [weak self] (image: UIImage) in
//                guard let _self = self else { return }
//                FigmaData.save(image: image, name: _self.name)
//            })
//        }
        
        
        if type != .component {
            for node: FigmaNode in children {
                if node.visible,
                   node.type != .vector,
                   node.type != .booleanOperation {
                    
                    node.donwloadImages(URLs: URLs, projectKey: projectKey, addURLcallback: addURLcallback)
                }
            }
        }
    }
    
}
//--------------------------------------------------------------------------
func donwloadMultipleComponent(URLs: [FigmaImgURL], callback: @escaping (([URL]) -> Void) ) {

    let downloadManager = DownloadManager()
        
    var result: [URL] = []
    let completion = BlockOperation {
        
        for data in downloadManager.result {

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] {
                    guard let nodeID = json["images"] as? [String: String]  else { return }
                    let strURL = nodeID.map { $0.1 }[0]
                    guard let url_ = URL(string: strURL) else { return }
                    result.append(url_)
                    
                }
            } catch {
            }
        }
    }
    
    for figma in URLs {
        if let url = figma.urlComponent {
            let operation = downloadManager.queueDownload(url)
            completion.addDependency(operation)
        }
    }
    OperationQueue.main.addOperation(completion)
    
    print(" 🦍😡🚴‍♂️ \(URLs.count)")
//
//    let queue = OperationQueue()
//    queue.maxConcurrentOperationCount = 1
//
//    var result: [URL] = []
//    var i = 0
//
//    for figmaURL: FigmaImgURL in URLs {
//
//        let operation = BlockOperation(block: {
//
//            print("start 🧑‍🎤")
//
//            guard let url = figmaURL.urlComponent else { return }
//
//            var request = URLRequest(url: url)
//                request.httpMethod = "GET"
//                request.allHTTPHeaderFields = ["X-Figma-Token" : FigmaData.current.token]
//
//            URLSession.shared.dataTask(with: request, completionHandler: {
//                (data: Data?, response: URLResponse?, error: Error?) in
//
//                guard let data_: Data = data, error == nil else { return }
//                do {
//                    if let json = try JSONSerialization.jsonObject(with: data_, options: .allowFragments) as? [String : Any] {
//
//                        guard let nodeID = json["images"] as? [String: String]  else { return }
//                        let strURL = nodeID.map { $0.1 }[0]
//                        guard let url_ = URL(string: strURL) else { return }
//
//                        result.append(url_)
//                        figmaURL.url = url_
//
//                        print("finished 👩🏻‍🎤 \(result.count)")
//
//                        i += 1
//                        if URLs.count == i {
//                            callback(result)
//                        }
//
//                    }
//                    // if let image = UIImage(data: data_) {
//                    //
//                    // }
//                } catch {
//                    // print(error)
//                }
//            }).resume()
//        })
//
//        queue.addOperation(operation)
//    }
    
}
//--------------------------------------------------------------------------
func donwloadMultipleImage(URLs: [FigmaImgURL], callback: @escaping (([UIImage]) -> Void) ) {
    
    let downloadManager = DownloadManager()
    
    let completion = BlockOperation {
        
//        for data in downloadManager.result {
//            
//            if let image = UIImage(data: data) {
//
//            }
//
//            do {
//                if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] {
//                    guard let nodeID = json["images"] as? [String: String]  else { return }
//                    let strURL = nodeID.map { $0.1 }[0]
//                    guard let url_ = URL(string: strURL) else { return }
//
//                }
//            } catch {
//            }
//        }
        print("all done")
    }
    
    let urlStrings = [
            "https://s.zeptobars.com/INN2605K-large-die-HD.jpg",
            "https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
            "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTAZcmbuygesp5PxEIPkZN98AVcqFodSxI3rQ&usqp=CAU",
            "https://images.unsplash.com/photo-1533387520709-752d83de3630?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80",
            "https://images.unsplash.com/photo-1535332371349-a5d229f49cb5?ixlib=rb-1.2.1&w=1000&q=80",
            "https://images.unsplash.com/photo-1513002749550-c59d786b8e6c?ixlib=rb-1.2.1&w=1000&q=80"
    ]
    
    let urls = urlStrings.compactMap { URL(string: $0) }
    for url in urls {
        let operation = downloadManager.queueDownload(url)
        completion.addDependency(operation)
    }
    
    OperationQueue.main.addOperation(completion)
    
//    var result: [UIImage] = []
//    var i = 0
//
//    let queue = OperationQueue()
//    queue.maxConcurrentOperationCount = 1
//
//    for figmaURL: FigmaImgURL in URLs {
//
//        let operation = BlockOperation(block: {
//
//            guard let url = figmaURL.url else { return }
//
//            var request = URLRequest(url: url)
//                request.httpMethod = "GET"
//                request.allHTTPHeaderFields = ["X-Figma-Token" : FigmaData.current.token]
//
//            URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
//
//                guard let data_: Data = data, error == nil else { return }
//                if let image = UIImage(data: data_) {
//                    result.append(image)
//                }
//
//                i += 1
//                if URLs.count == i {
//                    callback(result)
//                }
//
//            }).resume()
//        })
//        queue.addOperation(operation)
//    }
    
}

