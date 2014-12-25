//
//  DelayTest.swift
//  BYHelper
//
//  Created by ysq on 14/12/25.
//  Copyright (c) 2014年 ysq. All rights reserved.
//

import UIKit
import XCTest
import BYHelper

class DelayTest: XCTestCase {
    
    func testDelayAction(){
        
        let expectation = expectationWithDescription("delay action")
        
        delay(2, { () -> () in
            expectation.fulfill()
            XCTAssert(true, "success delay")
        })
        
        waitForExpectationsWithTimeout(3, handler: { (error) -> Void in
            XCTAssertNil(error, "\(error)")
        })
    }
    
    
    func testDelayCancelAction(){
        
        let expectation = expectationWithDescription("delay action")
        
        let task = delay(2, { () -> () in
            expectation.fulfill()
            XCTAssert(false, "delay cancel failure")
        })
        
        cancel(task)
        
        delay(3, { () -> () in
            expectation.fulfill()
            XCTAssert(true, "delay cancel success")
        })
        
        waitForExpectationsWithTimeout(4, handler: { (error) -> Void in
            XCTAssertNil(error, "\(error)")
        })
    }
    
}
