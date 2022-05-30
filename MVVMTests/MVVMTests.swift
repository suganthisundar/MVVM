//
//  MVVMTests.swift
//  MVVMTests
//
//  Created by suganthi on 28/05/22.
//

import XCTest
@testable import MVVM

class MVVMTests: XCTestCase {

    var vc: NewsViewController!
    var sut: APIService?
    
    override func setUp()  {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: "newsVC") as? NewsViewController
        _ = vc.view
        sut = APIService()
    }

    override func tearDown() {
           sut = nil
           super.tearDown()
       }
    
     func test_initTableView()
    {
    XCTAssertNotNil(vc.tableView)
    }
    
    
    func test_setsDataSource() {
        XCTAssertNotNil(vc.tableView.dataSource, "Table datasource cannot be nil");
        
    }
    
    func test_fetch_top_stories() {
            
            let sut = self.sut!
            
            let expect = XCTestExpectation(description: "callback")
            
            sut.fetchTopStories(complete: { (success, topStories, error) in
                expect.fulfill()
                for story in topStories {
                    XCTAssertNotNil(story)
                }
                
            })
            
            wait(for: [expect], timeout: 3.1)
        }
        
    
}
