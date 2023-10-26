//
//  TExtendedBolusDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/8/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TExtendedBolusDatumTests: XCTestCase {
    static let extendedBolus = TExtendedBolusDatum(time: Date.test,
                                                   extended: 1.23,
                                                   expectedExtended: 2.34,
                                                   duration: 123.456,
                                                   expectedDuration: 234.567,
                                                   insulinFormulation: TInsulinDatumFormulationTests.formulation)
    static let extendedBolusJSONDictionary: [String: Any] = [
        "type": "bolus",
        "subType": "square",
        "time": Date.testJSONString,
        "extended": 1.23,
        "expectedExtended": 2.34,
        "duration": 123456,
        "expectedDuration": 234567,
        "insulinFormulation": TInsulinDatumFormulationTests.formulationJSONDictionary
    ]
    
    func testInitializer() {
        let extendedBolus = TExtendedBolusDatumTests.extendedBolus
        XCTAssertEqual(extendedBolus.extended, 1.23)
        XCTAssertEqual(extendedBolus.expectedExtended, 2.34)
        XCTAssertEqual(extendedBolus.duration, 123.456)
        XCTAssertEqual(extendedBolus.expectedDuration, 234.567)
        XCTAssertEqual(extendedBolus.insulinFormulation, TInsulinDatumFormulationTests.formulation)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TExtendedBolusDatumTests.extendedBolus, TExtendedBolusDatumTests.extendedBolusJSONDictionary)
    }
}

extension TExtendedBolusDatum {
    func isEqual(to other: TExtendedBolusDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.extended == other.extended &&
            self.expectedExtended == other.expectedExtended &&
            self.duration == other.duration &&
            self.expectedDuration == other.expectedDuration &&
            self.insulinFormulation == other.insulinFormulation
    }
}
