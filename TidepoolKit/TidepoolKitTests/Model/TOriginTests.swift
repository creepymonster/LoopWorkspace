//
//  TOriginTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/5/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TOriginTests: XCTestCase {
    static let origin = TOrigin(id: "abcdef",
                                name: "Test Origin",
                                version: "1.2.3",
                                type: .device,
                                time: Date.test,
                                payload: TDictionary(["a": "b", "c": 0]))
    static let originJSONDictionary: [String: Any] = [
        "id": "abcdef",
        "name": "Test Origin",
        "version": "1.2.3",
        "type": "device",
        "time": Date.testJSONString,
        "payload": ["a": "b", "c": 0]
    ]
    
    func testInitializer() {
        let origin = TOriginTests.origin
        XCTAssertEqual(origin.id, "abcdef")
        XCTAssertEqual(origin.name, "Test Origin")
        XCTAssertEqual(origin.version, "1.2.3")
        XCTAssertEqual(origin.time, Date.test)
        XCTAssertEqual(origin.type, .device)
        XCTAssertEqual(origin.payload, TDictionary(["a": "b", "c": 0]))
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TOriginTests.origin, TOriginTests.originJSONDictionary)
    }
}

class TOriginOriginTypeTests: XCTestCase {
    func testOriginType() {
        XCTAssertEqual(TOrigin.OriginType.application.rawValue, "application")
        XCTAssertEqual(TOrigin.OriginType.device.rawValue, "device")
        XCTAssertEqual(TOrigin.OriginType.manual.rawValue, "manual")
        XCTAssertEqual(TOrigin.OriginType.service.rawValue, "service")
    }
}
