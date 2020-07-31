

import UIKit


class FigmaViewController: StoryboardController {
    
    //MARK: - Properties
    
    @IBOutlet weak var navBarTitleButton: UIButton!
    var scrollView: UIScrollView!
    
    // MARK: Data
    
    var projectKey: String = ""
    var figmaResponse: FigmaResponse!
    var convertToViews: FigmaConvertToViews!
    var figmaView: UIView?
    
    //MARK: - Life Cycle
    
    class func instantiate(projectKey: String) -> FigmaViewController {
           let vc = super.instantiate() as! FigmaViewController
               vc.projectKey = projectKey
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBarTitleButton.setTitle("", for: .normal)
        navBarTitleButton.frame.size.width = UIScreen.main.bounds.size.width
        // navBarTitleButton.backgroundColor = .red
        navBarTitleButton.titleLabel?.numberOfLines = 1
        navBarTitleButton.titleLabel?.adjustsFontSizeToFitWidth = true
        navBarTitleButton.titleLabel?.lineBreakMode = .byClipping
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.frame.size.height = view.bounds.height
        scrollView.delegate = self
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(scrollView)
        
        convertToViews = FigmaConvertToViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateFigmaFiles()
    }
    
    //MARK: - Update Action Request
    
    @IBAction func resetZoom() {
        scrollView.zoomScale = 1.0
    }
    
    @IBAction func buttonRefreshAction() {
        updateFigmaFiles()
    }
    
    @IBAction func buttonChangePageAction() {
        alertSelect(pages: figmaResponse.document.pages) { [weak self] (index) in
            guard let _self = self else { return }
            _self.updatePage(index: index)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        main(delay: 0.35) { [weak self] in
            guard let __self = self else { return }
            UIView.animate(withDuration: 0.35) {
                __self.scrollViewDidZoom(__self.scrollView)
            }
        }
        
    }
    
    func updateFigmaFiles() {
        
        loadingSpiner(show: true)
        
        FigmaData.current.requestFiles(projectKey: projectKey, completion: { [weak self] in
            
            loadingSpiner(show: false)
            
            guard let _self = self,
                let response: FigmaResponse = FigmaData.current.response,
                !response.document.pages.isEmpty else { return }
            
            _self.figmaResponse = response
            
            _self.updatePage(index: 0)
        })
    }
    
    func updatePage(index: Int) {
        
        if figmaResponse.document.pages.count < index { return }
        
        let page: FigmaPage = figmaResponse.document.pages[index]
        guard let imagesURLs = FigmaData.current.imagesURLs else { return }
        
        navBarTitleButton.setTitle(page.name, for: .normal)
        
        let viewNode: (UIView, FigmaNode) = convertToViews.add(page: page,
                                                               projectKey: projectKey,
                                                               imagesURLs: imagesURLs)
        
        addScrollView(figmaView: viewNode.0)
        
        FigmaData.save(text: viewNode.1.xib(),
                       toDirectory: FigmaData.pathXib(),
                       withFileName: "result.xib")
    }
    
    func addScrollView(figmaView: UIView) {
        
        self.figmaView = figmaView
        addFigmaNode(view: figmaView)
        scrollViewDidZoom(scrollView)
        resetZoom()
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
        
        scrollView.minimumZoomScale = 0.01
        scrollView.maximumZoomScale = 6.0
        
        scrollView.contentSize = size
        scrollView.backgroundColor = view.backgroundColor
        scrollView.addSubview(view)
    }
    
}

extension FigmaViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return figmaView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
        let w = Double(scrollView.bounds.size.width  - scrollView.contentSize.width)
        let h = Double(scrollView.bounds.size.height - scrollView.contentSize.height)
        
        let offsetX = max(w * 0.5, 0.0)
        let offsetY = max(h * 0.5, 0.0)
        figmaView?.center = CGPoint(x: scrollView.contentSize.width  * 0.5 + CGFloat(offsetX),
                                    y: scrollView.contentSize.height * 0.5 + CGFloat(offsetY))
    }
}
