//
//  LoginItem.swift
//  ClearSpotifyCache
//
//  Created by Tsuyoshi Ogasawara on 2017/04/16.
//  Copyright © 2017年 Tsuyoshi Ogasawara. All rights reserved.
//

import XCTest

class LoginItemTests: XCTestCase {

    func testExist() {
        let obj = LoginItem()
        XCTAssert(obj.add(name: "ClearSpotifyCache",path: Bundle.main.bundlePath))
        XCTAssert(obj.exist(name: "ClearSpotifyCache"))
        XCTAssert(obj.delete(name: "ClearSpotifyCache"))
        XCTAssertFalse(obj.exist(name: "ClearSpotifyCache"))
    }
}
