//
//  TInfoTests.swift
//  TidepoolKitTests
//
//  Created by Rick Pasetto on 9/7/21.
//  Copyright © 2021 Tidepool Project. All rights reserved.
//

import XCTest
@testable import TidepoolKit

class TInfoTests: XCTestCase {
    static let info = TInfo(versions: TInfo.Versions(loop: TInfo.Versions.Loop(minimumSupported: "1.2.0", criticalUpdateNeeded: ["1.1.0"])))
    static let infoJSONDictionary: [String: Any] = [
        "versions": [
            "loop": [
                "minimumSupported": "1.2.0",
                "criticalUpdateNeeded": [ "1.1.0" ]
            ]
        ]
    ]
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TInfoTests.info, TInfoTests.infoJSONDictionary)
    }
}
