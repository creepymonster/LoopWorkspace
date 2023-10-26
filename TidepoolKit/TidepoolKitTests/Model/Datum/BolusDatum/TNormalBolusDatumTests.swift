//
//  TNormalBolusDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/8/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TNormalBolusDatumTests: XCTestCase {
    static let normalBolus = TNormalBolusDatum(time: Date.test,
                                               normal: 1.23,
                                               expectedNormal: 2.34,
                                               insulinFormulation: TInsulinDatumFormulationTests.formulation)
    static let normalBolusJSONDictionary: [String: Any] = [
        "type": "bolus",
        "subType": "normal",
        "time": Date.testJSONString,
        "normal": 1.23,
        "expectedNormal": 2.34,
        "insulinFormulation": TInsulinDatumFormulationTests.formulationJSONDictionary
    ]
    
    func testInitializer() {
        let normalBolus = TNormalBolusDatumTests.normalBolus
        XCTAssertEqual(normalBolus.normal, 1.23)
        XCTAssertEqual(normalBolus.expectedNormal, 2.34)
        XCTAssertEqual(normalBolus.insulinFormulation, TInsulinDatumFormulationTests.formulation)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TNormalBolusDatumTests.normalBolus, TNormalBolusDatumTests.normalBolusJSONDictionary)
    }
}

extension TNormalBolusDatum {
    func isEqual(to other: TNormalBolusDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.normal == other.normal &&
            self.expectedNormal == other.expectedNormal &&
            self.insulinFormulation == other.insulinFormulation
    }
}
