//
//  WPListViewController.swift
//  DemoWiproPOC
//
//  Created by Piyush on 08/10/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import UIKit

class WPListViewController: UIViewController {
    
    private var tblView = UITableView()
    private let refreshControl = UIRefreshControl()
    
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
        self.setTableViewUI()
    }
    
    func setTableViewUI() {
        // Setting Autolayout Anchor programatically
        self.tblView.translatesAutoresizingMaskIntoConstraints = false
        self.tblView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tblView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        self.tblView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        self.tblView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
       
        // set delegate and properties
        tblView.dataSource = self
        tblView.delegate = self
        // register table view cell
        self.tblView.register(UITableViewCell.self, forCellReuseIdentifier: KConstant.cellIdentifier)
        self.tblView.rowHeight = UITableView.automaticDimension
        self.tblView.estimatedRowHeight = 44
        // implement pull to refresh functionality in tableview
        self.tblView.refreshControl = refreshControl
        self.tblView.reloadData()
    }
    
}

// MARK :- UITableViewDataSource,UITableViewDelegate
extension WPListViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = WPListTableViewCell(style: .default, reuseIdentifier: KConstant.cellIdentifier)
        cell.setCellUI()
        if indexPath.row == 0 {
            cell.textLabel?.text = "Hello Piyush very nice for the first program, Hello Piyush very nice for the first program"
        } else {
            cell.textLabel?.text = "Hello very nice for the cell creation"
        }
        return cell
    }
    
    
}
