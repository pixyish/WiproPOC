//
//  WPListViewModel.swift
//  DemoWiproPOC
//
//  Created by Piyush on 09/10/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import UIKit

protocol WPListViewModelDelegate:class {
    func getDataFromApicall(Rows:[Rows],title:String)
    func getApiError(errMsg:String)
}

class WPListViewModel: NSObject {
    
    weak var delegate:WPListViewModelDelegate?
    var listVC:WPListViewController?
    func isNetworkConnected(controller:UIViewController) -> Bool {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
           controller.showAlert(_title_str: "You are not connected to the internet")
           return false
           
        case .online(.wwan):
           print("Connected via WWAN")
        case .online(.wiFi):
           print("Connected via WiFi")
        }
        return true
    }
    
    func callApi(controller:UIViewController) {
        let objController = controller
        if self.isNetworkConnected(controller: objController) {
            WPApiCall.sharedInstance.listAPI(view: controller.view) { [weak objController] (success, message, response) in
                DispatchQueue.main.async {
                    if success && message.isEmpty {
                        guard let rows = response?.rows  else {
                            return
                        }
                        self.delegate?.getDataFromApicall(Rows: rows, title: response?.title ?? "List")
                    } else {
                        self.delegate?.getApiError(errMsg: message)
                    }
                    Loader.hideIndicator(View: objController?.view ?? UIView())
                }
            }
        }
    }
    
    func setTableViewUI(controller:UIViewController?) {
        if let listVC = controller as? WPListViewController {
            self.listVC = listVC
            let view = listVC.view
            // Setting Autolayout Anchor programatically
            listVC.tblView.translatesAutoresizingMaskIntoConstraints = false
            listVC.tblView.topAnchor.constraint(equalTo:view!.safeAreaLayoutGuide.topAnchor).isActive = true
            listVC.tblView.leftAnchor.constraint(equalTo:view!.safeAreaLayoutGuide.leftAnchor).isActive = true
            listVC.tblView.rightAnchor.constraint(equalTo:view!.safeAreaLayoutGuide.rightAnchor).isActive = true
            listVC.tblView.bottomAnchor.constraint(equalTo:view!.safeAreaLayoutGuide.bottomAnchor).isActive = true
           
            // set delegate and properties
            listVC.tblView.dataSource = listVC
            listVC.tblView.delegate = listVC
            // register table view cell
            listVC.tblView.register(UITableViewCell.self, forCellReuseIdentifier: KConstant.cellIdentifier)
            listVC.tblView.rowHeight = UITableView.automaticDimension
            listVC.tblView.estimatedRowHeight = 44
            // implementing pull to refresh functionality in tableview
            listVC.tblView.refreshControl = listVC.refreshControl
            listVC.listModelView.delegate = listVC
            listVC.listModelView.callApi(controller: listVC)
        }
    }
    
    func reloadTableWithRows(rows:[Rows]) {
        listVC?.arrayDataList.removeAll()
        listVC?.arrayDataList = rows
        listVC?.tblView.reloadData()
    }
    
    func reloadTableWithEmptyRows() {
        listVC?.arrayDataList.removeAll()
        listVC?.tblView.reloadData()
    }
}
