//
//  StoryboardController.swift
//  PatternsSwift
//
//  Created by mrustaa on 20/04/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

@IBDesignable
class StoryboardController: UIViewController {    
    
    class func instantiate() -> UIViewController {
        return fromStoryboardController()
    }

    class func fromStoryboardController() -> UIViewController {
        let className = String(describing: self)
        
        let storyboard = UIStoryboard.init(name: className, bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: className)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
}

extension StoryboardController: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
