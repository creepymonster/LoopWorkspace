//
//  TAutomatedBolusDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 1/7/22.
//  Copyright © 2022 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TAutomatedBolusDatumTests: XCTestCase {
    static let automatedBolus = TAutomatedBolusDatum(time: Date.test,
                                                     normal: 1.23,
                                                     expectedNormal: 2.34,
                                                     insulinFormulation: TInsulinDatumFormulationTests.formulation)
    static let automatedBolusJSONDictionary: [String: Any] = [
        "type": "bolus",
        "subType": "automated",
        "time": Date.testJSONString,
        "normal": 1.23,
        "expectedNormal": 2.34,
        "insulinFormulation": TInsulinDatumFormulationTests.formulationJSONDictionary
    ]

    func testInitializer() {
        let automatedBolus = TAutomatedBolusDatumTests.automatedBolus
        XCTAssertEqual(automatedBolus.normal, 1.23)
        XCTAssertEqual(automatedBolus.expectedNormal, 2.34)
        XCTAssertEqual(automatedBolus.insulinFormulation, TInsulinDatumFormulationTests.formulation)
    }

    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TAutomatedBolusDatumTests.automatedBolus, TAutomatedBolusDatumTests.automatedBolusJSONDictionary)
    }
}

extension TAutomatedBolusDatum {
    func isEqual(to other: TAutomatedBolusDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.normal == other.normal &&
            self.expectedNormal == other.expectedNormal &&
            self.insulinFormulation == other.insulinFormulation
    }
}
