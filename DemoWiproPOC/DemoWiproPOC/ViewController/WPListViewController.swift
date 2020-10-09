//
//  WPListViewController.swift
//  DemoWiproPOC
//
//  Created by Piyush on 08/10/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import UIKit

class WPListViewController: UIViewController {
    
    var tblView = UITableView()
    let refreshControl = UIRefreshControl()
    var arrayDataList = [Rows]()
    var listModelView = WPListViewModel()
    
    //MARK :- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    //MARK :- Private Methods
    func setUI() {
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        self.view.addSubview(tblView)
        listModelView.setTableViewUI(controller: self)
        refreshControl.addTarget(self, action: #selector(refreshItemData(_:)), for: .valueChanged)
    }
    
    //pull feature
    @objc private func refreshItemData(_ sender: Any) {
        // Fetch item Data by using pull to refresh
        listModelView.callApi(controller: self)
        self.refreshControl.endRefreshing()
    }
}


