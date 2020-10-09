//
//  WPListViewController+Delegate.swift
//  DemoWiproPOC
//
//  Created by Piyush on 09/10/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import UIKit

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
        // update UI using the response here
        self.navigationItem.title = title
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        listModelView.reloadTableWithRows(rows: Rows)
    }
    
    func getApiError(errMsg: String) {
        listModelView.reloadTableWithEmptyRows()
    }
}
