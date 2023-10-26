//
//  TSessionTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 3/3/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TSessionTests: XCTestCase {
    static let session = TSession(environment: TEnvironmentTests.environment,
                                  authenticationToken: "test-authentication-token",
                                  userId: "1234567890",
                                  trace: "test-trace",
                                  createdDate: Date.test)
    static let sessionJSONDictionary: [String: Any] = [
        "environment": TEnvironmentTests.environmentJSONDictionary,
        "authenticationToken": "test-authentication-token",
        "userId": "1234567890",
        "trace": "test-trace",
        "createdDate": Date.testJSONString
    ]

    func testInitializer() {
        let session = TSessionTests.session
        XCTAssertEqual(session.environment, TEnvironmentTests.environment)
        XCTAssertEqual(session.authenticationToken, "test-authentication-token")
        XCTAssertEqual(session.userId, "1234567890")
        XCTAssertEqual(session.trace, "test-trace")
        XCTAssertEqual(session.createdDate, Date.test)
    }

    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TSessionTests.session, TSessionTests.sessionJSONDictionary)
    }

    func testInitializerFromExistingSession() {
        let session = TSession(session: TSessionTests.session, authenticationToken: "refreshed-authentication-token")
        XCTAssertEqual(session.environment, TEnvironmentTests.environment)
        XCTAssertEqual(session.authenticationToken, "refreshed-authentication-token")
        XCTAssertEqual(session.userId, "1234567890")
        XCTAssertEqual(session.trace, "test-trace")
        XCTAssertNotEqual(session.createdDate, Date.test)
    }
}
