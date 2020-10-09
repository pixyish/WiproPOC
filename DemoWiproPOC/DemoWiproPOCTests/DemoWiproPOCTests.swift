//
//  DemoWiproPOCTests.swift
//  DemoWiproPOCTests
//
//  Created by Piyush on 08/10/20.
//  Copyright © 2020 Piyush. All rights reserved.
//

import XCTest
@testable import DemoWiproPOC

class DemoWiproPOCTests: XCTestCase {

    var controller:WPListViewController?
    var viewModel:WPListViewModel?
    
    override func setUpWithError() throws {
        controller = WPListViewController()
        viewModel = WPListViewModel()
    }
    func testAllDataLoaded(){
        var array : [Any] = []
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: KConstant.url)!
        let expectation = XCTestExpectation(description: "GET \(url)")
        
        let task = session.dataTask(with: url) { data, response, error in
            // if there is no error for this  response
            
            guard error == nil else {
                print ("error: \(error!)")
                XCTAssert(false,"giving error") // Here StatusCode is accessible inside the block
                expectation.fulfill()
                return
            }
            // if there is some data  from this  response
            guard let content = data else {
                print("there is no data")
                XCTAssert(false,"if the data from server is empty") // Here StatusCode is accessible inside the block
                           
                expectation.fulfill()
                return
            }
            let str_data = String(data: content, encoding: .isoLatin1)?.data(using: .utf8)
            // serialise the data  into Dictionary
            guard let json = (try? JSONSerialization.jsonObject(with: str_data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                XCTAssert(false,"Not containing JSON") // Here StatusCode is accessible inside the block
                expectation.fulfill()
                
                return
            }
            print("json response dictionary is \n \(json)")
            if let array_data = json["rows"] as? [Any]{
                array = array_data
                XCTAssertGreaterThan(array.count, 0)
            }

        }
        task.resume()
    }
    
    func testControllerHasTableView() {
        XCTAssertNotNil(controller?.tblView,
                        "Controller should have a tableview")
    }
    
    
    override func tearDownWithError() throws {
        viewModel = nil
        controller = nil
    }
    

    func testNetworkConnection() {
        let networkConnection:Bool = viewModel?.isNetworkConnected(controller: controller ?? WPListViewController()) ?? false
        XCTAssertTrue(networkConnection)
    }

    func testApiCall() {
        
        var listRows: [Rows]?
        WPApiCall.sharedInstance.listAPI(view: controller?.view ?? UIView()) { (success, message, response) in
            if let rows = response?.rows  {
                listRows = rows
            }
            
            if let rowCount = listRows {
                XCTAssertGreaterThan(rowCount.count, 0)
            }
            
        }
        
        
    }
    
    func testURLPath() {
      
        let mockURLSession  = MockURLSession()
      WPApiCall.sharedInstance.session = mockURLSession
        WPApiCall.sharedInstance.listAPI(view: controller?.view ?? UIView()) { (success, message, response) in
            
      }
        XCTAssertEqual(WPApiCall.sharedInstance.session?.cachedUrl?.host, "dl.dropboxusercontent.com")
        XCTAssertEqual(WPApiCall.sharedInstance.session?.cachedUrl?.path, "/s/2iodh4vg0eortkl/facts.json")
    }
    
    func testTableFeatures() {
        controller?.listModelView.setTableViewUI(controller: controller)
        XCTAssertNotNil(controller?.tblView.dataSource)
        XCTAssertNotNil(controller?.tblView.refreshControl)
    }
    
    func testReloadTableRows()  {
        controller?.listModelView.setTableViewUI(controller: controller)
        let row = Rows(with: "sdf", description: "sdf", imgHref: "sdf")
        controller?.arrayDataList = [row]
        controller?.listModelView.reloadTableWithEmptyRows()
        XCTAssertTrue(controller?.arrayDataList.count ?? 5 == 0)
        
    }
    
    func testCheckWithFilledArray()  {
        controller?.listModelView.setTableViewUI(controller: controller)
        let row = Rows(with: "sdf", description: "sdf", imgHref: "sdf")
        controller?.listModelView.reloadTableWithRows(rows: [row])
        
        let numberOfRows = controller?.tblView.numberOfRows(inSection: 0) ?? 0
        XCTAssertTrue(numberOfRows > 0)
    }
    
    func testCell() {
        let cell = WPListTableViewCell(style: .subtitle, reuseIdentifier: KConstant.cellIdentifier)
        XCTAssertNotNil(cell)
    }
    
    func testCellInfo() {
        let cell = WPListTableViewCell(style: .subtitle, reuseIdentifier: KConstant.cellIdentifier)
        let row = Rows(with: "Public", description: "Normal vote", imgHref: "sdf")
        cell.setCellInfo(info: row)
        let cellTitle = cell.textLabel?.text ?? ""
        XCTAssertEqual(cellTitle,"Public")
    }
}
