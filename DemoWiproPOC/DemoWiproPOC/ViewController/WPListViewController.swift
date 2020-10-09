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
    private let refreshControl = UIRefreshControl()
    private var arrayDataList = [Rows]()
    private var listModelView = WPListViewModel()
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
        // implementing pull to refresh functionality in tableview
        self.tblView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshItemData(_:)), for: .valueChanged)
        listModelView.delegate = self
        listModelView.callApi(controller: self)
    }
    
    //pull feature
    @objc private func refreshItemData(_ sender: Any) {
        // Fetch item Data by using pull to refresh
        listModelView.callApi(controller: self)
        self.refreshControl.endRefreshing()
    }
    
    
}

// MARK :- UITableViewDataSource,UITableViewDelegate
extension WPListViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayDataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = WPListTableViewCell(style: .subtitle, reuseIdentifier: KConstant.cellIdentifier)
        if self.arrayDataList.count > indexPath.row {
            let dataInfo = self.arrayDataList[indexPath.row]
            cell.setCellInfo(info: dataInfo)
        }
        return cell
    }
}

extension WPListViewController:WPListViewModelDelegate {
    func getDataFromApicall(Rows: [Rows],title:String) {
        self.arrayDataList.removeAll()
        self.arrayDataList = Rows
        // update UI using the response here
        self.navigationItem.title = title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.tblView.reloadData()
    }
    
    func getApiError(errMsg: String) {
        self.arrayDataList.removeAll()
        self.tblView.reloadData()
    }
    
    
}
