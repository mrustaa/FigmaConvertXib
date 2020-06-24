

import UIKit

class FigmaViewController: UIViewController {
    
    //MARK: - Properties
    
    var page: PageClass!
    
    var figmaImagesURLs: [String: String] = [:]
    
    var convertToViews: FigmaConvertToViews!
    var convertToXib: FigmaConvertToXib!
    
    //MARK: - Blocks
    
    typealias FigmaFilesCompletion = (_ page: PageClass) -> Void
    typealias FigmaRequestCompletion = (_ json: [String:Any]) -> Void
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let pathFile: String = #file
        let arrayFilesName: [String] = #file.split(separator: "/").map({String($0)})
        let resultPathFinal: String = pathFile.replacingOccurrences(of: arrayFilesName.last!, with: "Xib")
        
        print(pathFile)
        print(arrayFilesName)
        print(resultPathFinal)
        
        
        
        convertToViews = FigmaConvertToViews()
        convertToXib = FigmaConvertToXib()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let doneItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(buttonRefreshAction))
        navigationItem.rightBarButtonItem = doneItem
        
        updateFigmaFiles()
    }
    
    //MARK: - Update Action Request
    
    @objc func buttonRefreshAction() {
        updateFigmaFiles()
    }
    
    func updateFigmaFiles() {
        
        requestFigmaFiles(completion: { [weak self] (page: PageClass) in
            guard let _self = self else { return }

            _self.figmaResponse(page: page)
        })
    }
    
    func figmaResponse(page: PageClass) {
        
        self.page = page
        
        convertToViews.add(page: page, mainView: view)
        convertToXib.add(page: page)
    }
    
    func requestFigmaFiles(completion: FigmaFilesCompletion?) {
        
        requestFigma(url: "https://api.figma.com/v1/files/Zy47vycoawoNCIcEg8ygH5", completion: { (json: [String:Any]) in

            let fileResponse = FileResponse(json)
            if let page: PageClass = fileResponse.document?.children[0].children[0] {
                
                DispatchQueue.main.async {
                    completion?(page)
                }
            }
        })
        
        requestFigma(url: "https://api.figma.com/v1/files/Zy47vycoawoNCIcEg8ygH5/images", completion: { [weak self] (json: [String:Any]) in
            guard let _self = self else { return }
            
            if let meta = json["meta"] as? [String: Any] {
                if let images = meta["images"] as? [String: String] {
                    _self.figmaImagesURLs = images
                    _self.convertToViews.figmaImagesURLs = images
                    _self.convertToXib.figmaImagesURLs = images
                }
            }
            
        })
    }
    
    //MARK: - Request Figma
    
    func requestFigma(url: String, completion: FigmaRequestCompletion?) {
        
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["X-Figma-Token" : "44169-d6b5edd3-c479-475f-bee5-d0525b239ad0"]
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] {
                    completion?(json)
//                    print(" \(classNameString(json)) \n\n \(json) ")
                }
            } catch {
                print(error)
            }
        }).resume()
        
    }
    

    
    
    
    
}
