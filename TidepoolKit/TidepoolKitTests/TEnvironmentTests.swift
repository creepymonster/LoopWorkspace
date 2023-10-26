//
//  TEnvironmentTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 3/3/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TEnvironmentTests: XCTestCase {
    static let environment = TEnvironment(host: "test.tidepool.org", port: 443)
    static let environmentJSONDictionary: [String: Any] = [
        "host": "test.tidepool.org",
        "port": 443
    ]

    func testInitializer() {
        let environment = TEnvironmentTests.environment
        XCTAssertEqual(environment.host, "test.tidepool.org")
        XCTAssertEqual(environment.port, 443)
    }

    func testURLWithPort80() {
        let url = TEnvironment(host: "test.tidepool.org", port: 80).url()
        XCTAssertNotNil(url)
        XCTAssertEqual(url!.absoluteString, "http://test.tidepool.org/")
    }

    func testURLWithPort443() {
        let url = TEnvironment(host: "test.tidepool.org", port: 443).url()
        XCTAssertNotNil(url)
        XCTAssertEqual(url!.absoluteString, "https://test.tidepool.org/")
    }

    func testURLWithPortOther() {
        let url = TEnvironment(host: "test.tidepool.org", port: 3000).url()
        XCTAssertNotNil(url)
        XCTAssertEqual(url!.absoluteString, "http://test.tidepool.org:3000/")
    }

    func testURLWithPathWithoutPrefix() {
        let url = TEnvironmentTests.environment.url(path: "alpha/beta")
        XCTAssertNotNil(url)
        XCTAssertEqual(url!.absoluteString, "https://test.tidepool.org/alpha/beta")
    }

    func testURLWithPathWithPrefix() {
        let url = TEnvironmentTests.environment.url(path: "/alpha/beta")
        XCTAssertNotNil(url)
        XCTAssertEqual(url!.absoluteString, "https://test.tidepool.org/alpha/beta")
    }

    func testURLWithQueryItems() {
        let queryItems = [URLQueryItem(name: "foo", value: "one"), URLQueryItem(name: "bar", value: "two")]
        let url = TEnvironmentTests.environment.url(path: "/alpha/beta", queryItems: queryItems)
        XCTAssertNotNil(url)
        XCTAssertEqual(url!.absoluteString, "https://test.tidepool.org/alpha/beta?foo=one&bar=two")
    }

    func testDescription() {
        XCTAssertEqual(TEnvironmentTests.environment.description, "test.tidepool.org:443")
    }

    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TEnvironmentTests.environment, TEnvironmentTests.environmentJSONDictionary)
    }
}
