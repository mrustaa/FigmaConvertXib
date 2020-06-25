

import UIKit

class FigmaViewController: UIViewController {
    
    //MARK: - Properties
    
    var figmaImagesURLs: [String: String] = [:]
    
    var convertToViews: FigmaConvertToViews!
    var convertToXib: FigmaConvertToXib!
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let pathFile: String = #file
        let arrayFilesName: [String] = #file.split(separator: "/").map({String($0)})
        let resultPathFinal: String = pathFile.replacingOccurrences(of: arrayFilesName.last!, with: "Xib")
        
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
        
        FigmaData.current.requestFiles(completion: { [weak self] in
            guard let _self = self else { return }
            guard let page = FigmaData.current.page else { return }
            _self.convertToViews.add(page: page, mainView: _self.view)
            _self.convertToXib.add(page: page)
        })
    }
    
    
    
    
}
