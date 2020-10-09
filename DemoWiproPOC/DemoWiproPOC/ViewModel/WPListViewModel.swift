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
    
}
