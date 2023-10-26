//
//  TPrescriptionClaimTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 4/30/21.
//  Copyright © 2021 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TPrescriptionClaimTests: XCTestCase {
    static let prescriptionClaim = TPrescriptionClaim(accessCode: "ABCDEF", birthday: "2004-01-04")
    static let prescriptionClaimJSONDictionary: [String: Any] = [
        "accessCode": "ABCDEF",
        "birthday": "2004-01-04"
    ]
    
    func testInitializer() {
        let prescriptionClaim = TPrescriptionClaimTests.prescriptionClaim
        XCTAssertEqual(prescriptionClaim.accessCode, "ABCDEF")
        XCTAssertEqual(prescriptionClaim.birthday, "2004-01-04")
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPrescriptionClaimTests.prescriptionClaim, TPrescriptionClaimTests.prescriptionClaimJSONDictionary)
    }
}
