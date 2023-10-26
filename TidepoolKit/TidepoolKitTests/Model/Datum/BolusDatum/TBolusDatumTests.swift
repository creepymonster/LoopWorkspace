//
//  TBolusDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/8/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TBolusDatumTests: XCTestCase {
    static let bolus = TBolusDatum(.normal, time: Date.test, insulinFormulation: TInsulinDatumFormulationTests.formulation)
    static let bolusJSONDictionary: [String: Any] = [
        "type": "bolus",
        "subType": "normal",
        "time": Date.testJSONString,
        "insulinFormulation": TInsulinDatumFormulationTests.formulationJSONDictionary
    ]
    
    func testInitializer() {
        let bolus = TBolusDatumTests.bolus
        XCTAssertEqual(bolus.subType, .normal)
        XCTAssertEqual(bolus.insulinFormulation, TInsulinDatumFormulationTests.formulation)
    }
}

class TBolusDatumSubTypeTests: XCTestCase {
    func testSubType() {
        XCTAssertEqual(TBolusDatum.SubType.automated.rawValue, "automated")
        XCTAssertEqual(TBolusDatum.SubType.combination.rawValue, "dual/square")
        XCTAssertEqual(TBolusDatum.SubType.extended.rawValue, "square")
        XCTAssertEqual(TBolusDatum.SubType.normal.rawValue, "normal")
    }
}

extension TBolusDatum {
    func isEqual(to other: TBolusDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.subType == other.subType &&
            self.insulinFormulation == other.insulinFormulation
    }
}
