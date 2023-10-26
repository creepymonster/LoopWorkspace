//
//  JSONEncoderTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 3/3/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TJSONEncoderTests: XCTestCase {
    func testTidepoolJSONEncoder() {
        func assertDateEncoding() throws {
            let data = try JSONEncoder.tidepool.encode(Date.test)
            XCTAssertEqual(String(data: data, encoding: .utf8), "\"\(Date.testJSONString)\"")
        }
        XCTAssertNoThrow(try assertDateEncoding())
    }
}
