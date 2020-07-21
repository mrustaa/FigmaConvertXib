//
//  LoadSpiner.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 07.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit


func loadingSpiner(show: Bool) {
    
    guard let window = UIApplication.shared.windows.first else { return }
    
    let spinerTag = 44
    let shadowTag = 33
    
    let spiner: UIActivityIndicatorView
    let shadow: UIView
    
    if show {
        
        if (window.viewWithTag(shadowTag) != nil) { return }
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.tag = spinerTag
        indicator.center = window.center
        window.addSubview(indicator)
        
        let view = UIView(frame: window.frame)
        view.tag = shadowTag
        view.backgroundColor = .black
        view.alpha = 0
        window.addSubview(view)
        
        spiner = indicator
        shadow = view
        
        spiner.hidesWhenStopped = false
        spiner.startAnimating()
        
    } else {
        
        guard let indicator = window.viewWithTag(spinerTag) as? UIActivityIndicatorView else { return }
        guard let view = window.viewWithTag(shadowTag) else { return }
        
        spiner = indicator
        shadow = view
    }
    
    UIView.animate(withDuration: 0.35, animations: {
        
        if show {
            spiner.alpha = 1.0
            shadow.alpha = 0.25
        } else {
            spiner.alpha = 0.0
            shadow.alpha = 0
        }
        
    }, completion: { c in
        
        if !show {
            spiner.stopAnimating()
            spiner.hidesWhenStopped = true
            
            spiner.removeFromSuperview()
            shadow.removeFromSuperview()
        }
    })
}
