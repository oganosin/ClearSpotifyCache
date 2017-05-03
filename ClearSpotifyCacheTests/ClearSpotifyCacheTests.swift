//
//  ClearSpotifyCacheTests.swift
//  ClearSpotifyCacheTests
//
//  Created by Tsuyoshi Ogasawara on 4/9/17.
//  Copyright © 2017 Tsuyoshi Ogasawara. All rights reserved.
//

import XCTest
@testable import ClearSpotifyCache

class ClearSpotifyCacheTests: XCTestCase {
    let obj = SpotifyCache()
    
    override func setUp() {
        super.setUp()
        let _ = self.obj.terminateSpotifyApp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_terminateSpotifyApp() {
        XCTAssert(self.obj.isRunning()==false)
        XCTAssert(self.obj.launchSpotifyApp())
        XCTAssert(self.obj.isRunning())
        XCTAssert(self.obj.terminateSpotifyApp())
        XCTAssertFalse(self.obj.isRunning())
        XCTAssert(self.obj.removeCashDir())
    }
    
    /*func testLaunch() {
        self.measure() {
            XCTAssert(self.obj.launchSpotifyApp())
            XCTAssert(self.obj.terminateSpotifyApp())
        }
        
    }*/

}
