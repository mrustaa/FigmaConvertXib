//
//  ViewController.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 07.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: TableAdapterView!
    
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    @IBOutlet weak var shadowView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTable()
        
        tableView.selectIndexCallback = { (index: Int) in
            
            guard let key = LocalData.current.items[index]["key"] else { return }
            let vc = FigmaViewController.instantiate(projectKey: key)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        tableView.deleteIndexCallback = { (index: Int) in
            LocalData.current.items.remove(at: index)
            LocalData.current.save()
        }
    }
    
    @IBAction func addProject(_ sender: Any) {
        alertField(title: "Add figma project Key") { [weak self] (text: String) in
            
            loadingSpiner(show: true)
            
            FigmaData.current.checkProjectRequest(key: text) { [weak self]  (projectName: String?) in
                
                loadingSpiner(show: false)
                
                guard let _self = self else { return }
                guard let name = projectName else {
                    _self.alertMessage(title: "Error", message: "project does not exist")
                    return
                }
                
                _self.alertMessage(title: "Success", message: "added project")
                
                LocalData.current.items.append([
                    "name" : name,
                    "key" : text
                ])
                LocalData.current.save()
                
                _self.updateTable()
            }
        }
    }
    
    //MARK: - Update Table
    
    func updateTable() {
        var items: [TableAdapterItem] = []
        for item in LocalData.current.items {
            
            guard let name: String = item["name"] else { return }
            guard let key: String = item["key"] else { return }
            
            items.append( TitleTextItem(title: key, subtitle: name, editing: true) )
        }
        tableView.set(items: items, animated: true)
    }
    
    
    
    
}
