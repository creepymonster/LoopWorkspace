//
//  JSONDecoderTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 3/3/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TJSONDecoderTests: XCTestCase {
    func testTidepoolJSONDecoder() {
        func assertDateDecoding() throws {
            let data = "\"\(Date.testJSONString)\"".data(using: .utf8)
            XCTAssertNotNil(data)
            if let data = data {
                XCTAssertEqual(try JSONDecoder.tidepool.decode(Date.self, from: data), Date.test)
            }
        }
        XCTAssertNoThrow(try assertDateDecoding())
    }
}
