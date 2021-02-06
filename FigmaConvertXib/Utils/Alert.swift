//
//  Alert.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 07.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func alertSelect(pages: [FigmaPage], callback: ((Int) -> Void)? = nil) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        var i = 0
        for page in pages {
            
            let action = UIAlertAction(title: page.name, style: .default) { (action) -> Void in
                guard let index = alert.actions.firstIndex(of: action) else { return }
                callback?(index)
            }
            
            alert.addAction(action)
            i += 1
        }
        
        alert.addAction( UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertField(title: String? = nil, message: String? = nil, placeholder: String? = nil, addCancel: Bool = false, callback: ((String) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let save = UIAlertAction(title: "Ok", style: .default) { _ in
            
            guard let text = alert.textFields?[0].text else { return }
            if text.count <= 0 { return }
            
            callback?(text)
        }
        alert.addAction(save)
        
        alert.addTextField { (textField) in
            
            if let placeholder = placeholder {
                textField.placeholder = placeholder
            }
            textField.textColor = .red
        }
        
        if addCancel {
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in
                
            }
            alert.addAction(cancelAction)
        }

        self.present(alert, animated: true, completion: nil)
    }
    
    func alertMessage(title: String? = nil, message: String? = nil, callback: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//        let ok = UIAlertAction(title: "Ok", style: .default) { _ in
//            callback?()
//        }
//        alert.addAction(ok)
        let cancel = UIAlertAction(title: "Ok", style: .destructive) { (alertAction) in
            callback?()
        }
        alert.addAction(cancel)
        self.present(alert, animated:true, completion: nil)
    }
}


