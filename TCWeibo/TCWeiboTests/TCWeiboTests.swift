//
//  TCWeiboTests.swift
//  TCWeiboTests
//
//  Created by TailC on 16/5/22.
//  Copyright © 2016年 TailC. All rights reserved.
//

import XCTest

class TCWeiboTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
		let a : Int = 3
		XCTAssertTrue(a == 0,"a is equeal to 0")
		
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
