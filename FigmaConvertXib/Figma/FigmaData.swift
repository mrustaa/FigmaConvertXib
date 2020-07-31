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
    typealias CompletionBool = (_ value: Bool) -> Void
    typealias CompletionString = (_ value: String?) -> Void
    typealias Completion = () -> Void
    
    public enum documentId: String {
        case RuStAm4iK = "PLRDJ59Baio6xjpmylVt3T"
        case Short = "Zy47vycoawoNCIcEg8ygH5"
        case All = "9KadDT1iy1EX0wJMY7qhSY"
        case Coffee = "M0q8R4TA8Lb4TB5lJSIq98"
    }
    
    let token = "44169-d6b5edd3-c479-475f-bee5-d0525b239ad0"
    
    let apiURL = "https://api.figma.com/v1/files/"
    let apiURLComponent = "https://api.figma.com/v1/images/"
    
    public enum RequestType {
        case Files
        case Images
    }
    
    public enum RequestComponentFormat: String {
        case JPG = "jpg"
        case PNG = "png"
        case SVG = "svg"
        case PDF = "pdf"
    }
    
    //MARK: - Result
    
    var response: FigmaResponse?
    var imagesURLs: [String: String]?
    
    
    //MARK: - 📁 Paths
    
    /// path: /FigmaConvertXib/FigmaConvertXib/Figma/Xib
    
    class func pathXib() -> String {
        
        let pathFile: String = #file
        let arrayFilesName: [String] = #file.split(separator: "/").map({String($0)})
        let resultPathFinal: String = pathFile.findReplace(find: arrayFilesName.last!, replace: "Xib")
        return resultPathFinal
    }
    
    /// path: /FigmaConvertXib/FigmaConvertXib/Figma/Xib/images.xcassets
    
    class func pathXibImages() -> String {
        
        let pathFile: String = #file
        let arrayFilesName: [String] = #file.split(separator: "/").map({String($0)})
        let resultPathFinal: String = pathFile.findReplace(find: arrayFilesName.last!, replace: "Xib/images.xcassets")
        return resultPathFinal
    }
    
    /// path: TEMP
    /// /Users/mrusta/Library/Developer/CoreSimulator/Devices/FC70BFBD-0AA2-4BBF-AB10-A450BE6EED79/data/Containers/Data/Application/963AFA02-49CE-475D-AE9E-44D407355067/Documents
    
    class func pathTemporaryDocument() -> String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return documentDirectory[0]
    }
    

    //MARK: - 📁 🆕 Create Folder
    
    class func createFolder(path: String, name: String) -> String? {
        
        // let localStrURL = FigmaData.pathTemporaryDocument()
        // let localStrURL = FigmaData.pathXibImages()
        
        let name_ = name.findReplace(find: "/", replace: ":")
        
        guard let localURL = URL(string: path) else { return nil }
        let dataPath = localURL.appendingPathComponent(name_)
        
        if !FileManager.default.fileExists(atPath: dataPath.absoluteString) {
            do {
                let dataPathStr = path + "/" + name_ // dataPath.absoluteString
                try FileManager.default.createDirectory(atPath: dataPathStr, withIntermediateDirectories: true, attributes: nil)
                return dataPath.absoluteString
            } catch {
                print("Error", error.localizedDescription);
            }
        }
        return nil
    }
    
    //MARK: - 📁 Paths 🗑 Clear Temp
    
    func clearTempFolder() {
        
        let fileManager = FileManager.default
        let tempFolderPath = FigmaData.pathTemporaryDocument()
        do {
            let filePaths = try fileManager.contentsOfDirectory(atPath: tempFolderPath)
            for filePath in filePaths {
                let resultPath = "\(tempFolderPath)/\(filePath)"
                try fileManager.removeItem(atPath: resultPath)
            }
        } catch {
            print("Could not clear temp folder: \(error)")
        }
    }
    
    //MARK: - 💾📄 Save Local File.xib
    
    class func save(text: String, toDirectory directory: String, path_: String? = nil, withFileName fileName: String) {
        
        func append(toPath path: String, withPathComponent pathComponent: String) -> String? {
            if var pathURL = URL(string: path) {
                pathURL.appendPathComponent(pathComponent)
                return pathURL.absoluteString
            }
            return nil
        }
        
        guard var filePath: String = append(toPath: directory, withPathComponent: fileName) else {
            print("🚨 Error")
            return
        }
        
        if let path_ = path_ {
            filePath = path_
        }
        
        do {
            
            try text.write(toFile: filePath, atomically: true, encoding: .utf8)
        } catch {
            print("🚨 Error", error)
            return
        }
    }
    
    //MARK: - 💾📄 Save Local .json
    
    class func createImageJsonFile(path: String, path_: String, name: String) {
        
        let text = """
        {
          "images" : [
            {
              "filename" : "\(name).png",
              "idiom" : "universal",
              "scale" : "1x"
            },
            {
              "idiom" : "universal",
              "scale" : "2x"
            },
            {
              "idiom" : "universal",
              "scale" : "3x"
            }
          ],
          "info" : {
            "author" : "xcode",
            "version" : 1
          }
        }
        """
        
        FigmaData.save(text: text,
                       toDirectory: path,
                       path_: path_ + "/Contents.json",
                       withFileName: "Contents.json")
        
    }
    
    //MARK: - 🏞⬇️ Image Download
    
    class func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    class func downloadImage(url: URL, completion: ((_ image: UIImage) -> Void)? = nil) {

        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            if let image = UIImage(data: data) {
//                DispatchQueue.main.async() {
                    completion?(image)
//                }
            }
        }
    }
    
    class func saveImageXcassets(image: UIImage, name: String) {
        
        let path = pathXibImages()
        let name_ = name + ".imageset"
        
        guard let localURL = URL(string: path) else { return }
        let dataPath = localURL.appendingPathComponent(name_)
        let filterPath = dataPath.absoluteString
        
        let path_ = path + "/" + name_
        
        if FileManager.default.fileExists(atPath: filterPath) {
            
            FigmaData.createImageJsonFile(path: filterPath, path_: path_, name: name)
            FigmaData.save(image: image, path: filterPath, name: name)
            
        } else {
            if let createdFolderPath = createFolder(path: path, name: name_) {
                
                FigmaData.createImageJsonFile(path: createdFolderPath, path_: path_, name: name)
                FigmaData.save(image: image, path: createdFolderPath, name: name)
            }
        }
    }
    
    //MARK: 🏞💾 Image Save Local
    
    class func save(image: UIImage, path: String? = nil, name: String) {
        
        guard let data = image.pngData() else { return }
        
        let p = FigmaData.pathXibImages()
        var a = "file://\(p)/"
        
        if let path = path {
            a = "file://\(path)/"
        }
        
        guard let urlPathA = URL(string: a) else { return }
        let urlPath = urlPathA.appendingPathComponent("\(name).png")
        
        do {
            try data.write(to: urlPath)
            print(" 🏞 \(urlPath.absoluteString)")
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: 🏞📤 Image Load Local
    
    class func load(imageName: String, path: String? = nil) -> UIImage? {
        
        let pat = pathXibImages()
        let name_ = imageName + ".imageset"
        guard let localURL = URL(string: pat) else { return nil }
        let dataPath = localURL.appendingPathComponent(name_)
        let filterPath = dataPath.absoluteString
        
        
        let p = filterPath // FigmaData.pathXibImages()
        var a = "file://\(p)/"
        
        if let path = path {
            a = "file://\(path)/"
        }
        
        guard let url = URL(string: a) else { return nil }
        let urlPath = url.appendingPathComponent("\(imageName).png")
        
        do {
            let imageData = try Data(contentsOf: urlPath)
            // print(" 📤 \(urlPath.absoluteString)")
            return UIImage(data: imageData)
            
        } catch {
            
        }
        return nil
    }
    
    //MARK: 🏞⁉️ Check File Exists Path
    
    class func checkImageExists(imageName: String) -> Bool {
        
        let path = FigmaData.pathXibImages() + "/" + imageName + ".imageset" + "/" + imageName + ".png"
        
        if FileManager.default.fileExists(atPath: path) {
            return true
        } else {
            return false
        }
    }
    
    
    
    //MARK: - Request Figma
    
    func requestFiles(projectKey: String, completion: FigmaData.Completion?) {
        
        response = nil
        imagesURLs = nil
        
        request(key: projectKey, type: .Files, compJson: { [weak self] (data, json: [String:Any]?) in
            guard let json = json else { return }
            guard let _self = self else { return }
            
            _self.response = FigmaResponse(json)
            
            guard (_self.imagesURLs != nil) else { return }
            completion?()
            
        })
        
        request(key: projectKey, type: .Images, compJson: { [weak self] (data, json: [String:Any]?) in
            guard let json = json else { return }
            guard let _self = self else { return }
            
            guard let meta = json["meta"] as? [String: Any] else { return }
            guard let images = meta["images"] as? [String: String] else { return }
            _self.imagesURLs = images
                
            guard (_self.response != nil) else { return }
            completion?()
        })
        
    }
    
    func requestComponent(key: String, nodeId: String, format: RequestComponentFormat, compJson: FigmaData.CompletionJSON? = nil) {
        
        let srtURL = "\(apiURLComponent)\(key)/?ids=\(nodeId)&scale=\(3.0)&format=\(format.rawValue)"
        
        guard let url = URL(string: srtURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["X-Figma-Token" : token]
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    guard let currentData: Data = data, error == nil else { return }
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
    
    func request(key: String, type: RequestType, compJson: FigmaData.CompletionJSON? = nil) {
        
        let typeURL = (type == .Images ? "/images" : "")
        
//        var srtURL = "\(apiURL)\(FigmaData.documentId.RuStAm4iK.rawValue)\(typeURL)"
        
        let srtURL = "\(apiURL)\(key)\(typeURL)"
        
        guard let url = URL(string: srtURL) else {
            
            compJson?(Data(), [ "err" : "url" ])
            return
        }
        
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
    
    
    func checkProjectRequest(key: String, complectionExists: FigmaData.CompletionString? = nil) {
        
        request(key: key, type: .Files, compJson: { (data, json: [String:Any]?) in
            
            guard let json = json else { return }
            if ((json["err"] as? String) != nil) {
                complectionExists?(nil)
                return
            }
            
            guard let name = json["name"] as? String else { return }
            
            complectionExists?(name)
        })
    }
}
