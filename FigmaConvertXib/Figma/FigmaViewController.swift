

import UIKit

class FigmaViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet weak var titleTextField: UITextField!
    var scrollView: UIScrollView!
    
    var figmaImagesURLs: [String: String] = [:]
    
    var convertToViews: FigmaConvertToViews!
    var convertToXib: FigmaConvertToXib!
    
    var figmaView: UIView?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.frame.size.height = scrollView.frame.height - 64
        scrollView.delegate = self
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
        
        let doneItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(buttonRefreshAction))
        navigationItem.rightBarButtonItem = doneItem
        
        updateFigmaFiles()
    }
    
    //MARK: - Update Action Request
    
    @objc func buttonRefreshAction() {
        updateFigmaFiles()
    }
    
    func updateFigmaFiles() {
        
        var text: String? = nil
        if let t = titleTextField.text, t.count > 0 {
            text = t
        }
        
        FigmaData.current.requestFiles(documentId: text, completion: { [weak self] in
            guard let _self = self,
                let page = FigmaData.current.resporse?.document.pages[0],
                let imagesURLs = FigmaData.current.imagesURLs else { return }
            
            let figmaView: (UIView, F_View) = _self.convertToViews.add(page: page, imagesURLs: imagesURLs)
            _self.figmaView = figmaView.0
            
            _self.addFigmaView(view: figmaView.0)
            
            
//            _self.convertToViews.add(view: page, imagesURLs: imagesURLs, mainView: _self.view)
            _self.convertToXib.add(page: figmaView.1, imagesURLs: imagesURLs)
        })
    }
    
    func addFigmaView(view: UIView) {

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
       titleTextField.endEditing(true)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return figmaView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let zoomScale = scrollView.zoomScale
        
        print(" \(zoomScale) ")
        
        let w = Double(scrollView.bounds.size.width - scrollView.contentSize.width)
        let h = Double(scrollView.bounds.size.height - scrollView.contentSize.height)
        
        let offsetX = max( w * 0.5, 0.0)
        let offsetY = max( h * 0.5, 0.0)
        // adjust the center of image view
        figmaView?.center = CGPoint(x: scrollView.contentSize.width * 0.5 + CGFloat(offsetX), y: scrollView.contentSize.height * 0.5 + CGFloat(offsetY))
        
//
//        figmaView?.bounds = CGRect(x: 0, y: 0, width: 100 * zoomScale, height: 100 * zoomScale)
//        figmaView?.layer.setAffineTransform( CGAffineTransform(scaleX: 1.0 / zoomScale, y: 1.0 / zoomScale) )
//
    }
}
