

import UIKit


class FigmaViewController: StoryboardController {
    
    //MARK: - Properties
    
    var projectKey: String = ""
    
    var scrollView: UIScrollView!
    
    var figmaImagesURLs: [String: String] = [:]
    
    var convertToViews: FigmaConvertToViews!
    var convertToXib: FigmaConvertToXib!
    
    var FigmaNode: UIView?
    
    //MARK: - Life Cycle
    
    class func instantiate(projectKey: String) -> FigmaViewController {
        let vc = super.instantiate() as! FigmaViewController
//        let vc = FigmaViewController()
        vc.projectKey = projectKey
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.frame.size.height = view.bounds.height //- 64
        scrollView.delegate = self
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(scrollView)
        
        let pathFile: String = #file
        let arrayFilesName: [String] = #file.split(separator: "/").map({String($0)})
        let resultPathFinal: String = pathFile.replacingOccurrences(of: arrayFilesName.last!, with: "Xib")
        
        print(resultPathFinal)
        
        convertToViews = FigmaConvertToViews()
        convertToXib = FigmaConvertToXib()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let doneItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(buttonRefreshAction))
//        navigationItem.rightBarButtonItem = doneItem
        
        updateFigmaFiles()
    }
    
    //MARK: - Update Action Request
    
    @IBAction func buttonRefreshAction() {
        updateFigmaFiles()
    }
    
    @IBAction func resetZoom(_ sender: Any) {
        scrollView.zoomScale = 1.0
    }
    
    func updateFigmaFiles() {
        
//        var text: String? = nil
//        if let t = titleTextField.text, t.count > 0 {
//            text = t
//        }
//        FigmaData.current.pathImageAssets() 
        
        loadingSpiner(show: true)
        
        FigmaData.current.requestFiles(projectKey: projectKey, completion: { [weak self] in
            
            loadingSpiner(show: false)
            
            guard let _self = self,
                let response: FigmaResponse = FigmaData.current.response,
                !response.document.pages.isEmpty,
                let imagesURLs = FigmaData.current.imagesURLs else { return }
            
            let page: FigmaPage = response.document.pages[0]
            
            let FigmaNode: (UIView, FigmaNode) = _self.convertToViews.add(page: page, projectKey: _self.projectKey, imagesURLs: imagesURLs)
            _self.FigmaNode = FigmaNode.0
            
            let newResult = FigmaNode.1.xib()
            
            FigmaData.save(text: newResult,
                           toDirectory: FigmaData.current.pathXib(),
                           withFileName: "new_result.xib")
            
//            FigmaNode.1.downloadImages(URLs: imagesURLs)
            
            _self.addFigmaNode(view: FigmaNode.0)
//            _self.convertToXib.add(page: FigmaNode.1, imagesURLs: imagesURLs)
        })
    }
    
    func addFigmaNode(view: UIView) {

        var size: CGSize = view.bounds.size
        
        if size.width < scrollView.frame.width {
            size.width = scrollView.frame.width
        }
        if size.height < scrollView.frame.height {
            size.height = scrollView.frame.height
        }
        
        for view in scrollView.subviews {
            view.removeFromSuperview()
        }
        
        /*ScrollView Zoom Code  02*/
        scrollView.minimumZoomScale = 0.25
        scrollView.maximumZoomScale = 6.0
        
        scrollView.contentSize = size
        scrollView.backgroundColor = view.backgroundColor
        scrollView.addSubview(view)
    }
    
    
}

extension FigmaViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//       titleTextField.endEditing(true)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return FigmaNode
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//        let zoomScale = scrollView.zoomScale
        
//        print(" \(zoomScale) ")
        
        let w = Double(scrollView.bounds.size.width - scrollView.contentSize.width)
        let h = Double(scrollView.bounds.size.height - scrollView.contentSize.height)
        
        let offsetX = max( w * 0.5, 0.0)
        let offsetY = max( h * 0.5, 0.0)
        // adjust the center of image view
        FigmaNode?.center = CGPoint(x: scrollView.contentSize.width * 0.5 + CGFloat(offsetX), y: scrollView.contentSize.height * 0.5 + CGFloat(offsetY))
        
//
//        FigmaNode?.bounds = CGRect(x: 0, y: 0, width: 100 * zoomScale, height: 100 * zoomScale)
//        FigmaNode?.layer.setAffineTransform( CGAffineTransform(scaleX: 1.0 / zoomScale, y: 1.0 / zoomScale) )
//
    }
}
