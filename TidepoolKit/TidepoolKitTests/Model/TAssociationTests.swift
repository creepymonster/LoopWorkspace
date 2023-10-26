//
//  TAssociationTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/5/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TAssociationTests: XCTestCase {
    static let association = TAssociation(type: .blob, id: "123456", reason: "Any reason is acceptable.")
    static let assocationJSONDictionary: [String: Any] = [
        "type": "blob",
        "id": "123456",
        "reason": "Any reason is acceptable."
    ]
    
    func testInitializerWithTypeBlob() {
        let association = TAssociation(type: .blob, id: "234567", reason: "Any reason is acceptable.")
        XCTAssertEqual(association.type, .blob)
        XCTAssertEqual(association.id, "234567")
        XCTAssertEqual(association.reason, "Any reason is acceptable.")
    }
    
    func testInitializerWithTypeDatum() {
        let association = TAssociation(type: .datum, id: "345678", reason: "Any reason is acceptable.")
        XCTAssertEqual(association.type, .datum)
        XCTAssertEqual(association.id, "345678")
        XCTAssertEqual(association.reason, "Any reason is acceptable.")
    }
    
    func testInitializerWithTypeImage() {
        let association = TAssociation(type: .image, id: "456789", reason: "Any reason is acceptable.")
        XCTAssertEqual(association.type, .image)
        XCTAssertEqual(association.id, "456789")
        XCTAssertEqual(association.reason, "Any reason is acceptable.")
    }
    
    func testInitializerWithTypeURL() {
        let association = TAssociation(type: .url, url: "https://www.tidepool.org", reason: "Any reason is acceptable.")
        XCTAssertEqual(association.type, .url)
        XCTAssertEqual(association.url, "https://www.tidepool.org")
        XCTAssertEqual(association.reason, "Any reason is acceptable.")
    }
    
    func testCodableAsJSONWithTypeBlob() {
        let association = TAssociation(type: .blob, id: "234567", reason: "Any reason is acceptable.")
        XCTAssertCodableAsJSON(association, ["type": "blob", "id": "234567", "reason": "Any reason is acceptable."])
    }
    
    func testCodableAsJSONWithTypeDatum() {
        let association = TAssociation(type: .datum, id: "345678", reason: "Any reason is acceptable.")
        XCTAssertCodableAsJSON(association, ["type": "datum", "id": "345678", "reason": "Any reason is acceptable."])
    }
    
    func testCodableAsJSONWithTypeImage() {
        let association = TAssociation(type: .image, id: "456789", reason: "Any reason is acceptable.")
        XCTAssertCodableAsJSON(association, ["type": "image", "id": "456789", "reason": "Any reason is acceptable."])
    }
    
    func testCodableAsJSONWithTypeURL() {
        let association = TAssociation(type: .url, url: "https://www.tidepool.org", reason: "Any reason is acceptable.")
        XCTAssertCodableAsJSON(association, ["type": "url", "url": "https://www.tidepool.org", "reason": "Any reason is acceptable."])
    }
}

class TAssociationAssociationTypeTests: XCTestCase {
    func testAssociationType() {
        XCTAssertEqual(TAssociation.AssociationType.blob.rawValue, "blob")
        XCTAssertEqual(TAssociation.AssociationType.datum.rawValue, "datum")
        XCTAssertEqual(TAssociation.AssociationType.image.rawValue, "image")
        XCTAssertEqual(TAssociation.AssociationType.url.rawValue, "url")
    }
}
