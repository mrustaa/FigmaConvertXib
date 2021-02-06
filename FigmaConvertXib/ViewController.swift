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
        
        tableView.selectIndexCallback = { [weak self] (index: Int) in
            
            guard let _self = self else { return }
            guard let item = _self.tableView.items[index] as? TitleTextItem else { return }
            guard let data = item.cellData as? TitleTextCellData else { return }
            
            if let clss = data.clss {
                
                guard let storyboardClass = clss as? StoryboardController.Type else { return }
                let vc = storyboardClass.instantiate()
                _self.navigationController?.pushViewController(vc, animated: true)
                
            } else {
                guard let key = LocalData.current.projects[index]["key"] else { return }
                
                let vc = FigmaViewController.instantiate(projectKey: key)
                _self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        tableView.deleteIndexCallback = { (index: Int) in
            LocalData.current.projects.remove(at: index)
            LocalData.current.projectsSave()
        }
        
        if LocalData.current.token == nil {
            showAlertAddToken()
        }
        
    }
    
    func showAlertAddToken() {
        
        alertField(title: "Add Figma Token 🔑", placeholder: "Token") { [weak self] (text: String) in
            
            loadingSpiner(show: true)
            
            LocalData.current.token = text
            
            FigmaData.current.checkTokenRequest(complectionExists: { [weak self] (json: [String:Any]?) in
                
                loadingSpiner(show: false)
                
                guard let _self = self else { return }
                
                if json != nil {
                    LocalData.current.tokenSave()
                    _self.alertMessage(title: "Success", message: "added token")
                    
                } else {
                    _self.alertMessage(title: "Error", message: "invalid token") {
                        _self.showAlertAddToken()
                    }
                }
            })
        }
    }
    
    @IBAction func changeToken(_ sender: Any) {
        alertMessage(title: "Token 🔑", message: LocalData.current.token)
    }
    
    @IBAction func addProject(_ sender: Any) {
        alertField(title: "Add Figma project id", placeholder: "Project id", addCancel: true) { [weak self] (text: String) in
            
            loadingSpiner(show: true)
            
            FigmaData.current.checkProjectRequest(key: text) { [weak self] (projectName: String?) in
                
                loadingSpiner(show: false)
                
                guard let _self = self else { return }
                guard let name = projectName else {
                    _self.alertMessage(title: "Error", message: "project does not exist")
                    return
                }
                
                _self.alertMessage(title: "Success", message: "added project")
                
                LocalData.current.projects.append([
                    "name" : name,
                    "key" : text
                ])
                LocalData.current.projectsSave()
                
                _self.updateTable()
            }
        }
    }
    
    //MARK: - Update Table
    
    func updateTable() {
        var items: [TableAdapterItem] = []
        for item in LocalData.current.projects {
            
            guard let name: String = item["name"] else { return }
            guard let key:  String = item["key"]  else { return }
            
            items.append( TitleTextItem(title: key, subtitle: name, editing: true) )
        }
        
        tableView.set(items: items, animated: true)
    }
    
    
    
    
}
