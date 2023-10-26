//
//  LoginResponseTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 10/29/21.
//  Copyright © 2021 Tidepool Project. All rights reserved.
//

import XCTest
@testable import TidepoolKit

class LoginResponseTests: XCTestCase {
    static let loginResponse = LoginResponse(userId: "1234567890",
                                              email: "test@tidepool.org",
                                              emailVerified: true,
                                              termsAccepted: "20211029T01:23:45Z")
    static let loginResponseJSONDictionary: [String: Any] = [
        "userid": "1234567890",
        "username": "test@tidepool.org",
        "emailVerified": true,
        "termsAccepted": "20211029T01:23:45Z"
    ]

    func testInitializer() {
        let loginResponse = LoginResponseTests.loginResponse
        XCTAssertEqual(loginResponse.userId, "1234567890")
        XCTAssertEqual(loginResponse.email, "test@tidepool.org")
        XCTAssertEqual(loginResponse.emailVerified, true)
        XCTAssertEqual(loginResponse.termsAccepted, "20211029T01:23:45Z")
    }

    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(LoginResponseTests.loginResponse, LoginResponseTests.loginResponseJSONDictionary)
    }
}
