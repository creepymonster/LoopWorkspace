//
//  TCombinationBolusDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/8/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TCombinationBolusDatumTests: XCTestCase {
    static let combinationBolus = TCombinationBolusDatum(time: Date.test,
                                                         normal: 1.23,
                                                         expectedNormal: 2.34,
                                                         extended: 3.45,
                                                         expectedExtended: 4.56,
                                                         duration: 123.456,
                                                         expectedDuration: 234.567,
                                                         insulinFormulation: TInsulinDatumFormulationTests.formulation)
    static let combinationBolusJSONDictionary: [String: Any] = [
        "type": "bolus",
        "subType": "dual/square",
        "time": Date.testJSONString,
        "normal": 1.23,
        "expectedNormal": 2.34,
        "extended": 3.45,
        "expectedExtended": 4.56,
        "duration": 123456,
        "expectedDuration": 234567,
        "insulinFormulation": TInsulinDatumFormulationTests.formulationJSONDictionary
    ]
    
    func testInitializer() {
        let combinationBolus = TCombinationBolusDatumTests.combinationBolus
        XCTAssertEqual(combinationBolus.normal, 1.23)
        XCTAssertEqual(combinationBolus.expectedNormal, 2.34)
        XCTAssertEqual(combinationBolus.extended, 3.45)
        XCTAssertEqual(combinationBolus.expectedExtended, 4.56)
        XCTAssertEqual(combinationBolus.duration, 123.456)
        XCTAssertEqual(combinationBolus.expectedDuration, 234.567)
        XCTAssertEqual(combinationBolus.insulinFormulation, TInsulinDatumFormulationTests.formulation)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TCombinationBolusDatumTests.combinationBolus, TCombinationBolusDatumTests.combinationBolusJSONDictionary)
    }
}

extension TCombinationBolusDatum {
    func isEqual(to other: TCombinationBolusDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.normal == other.normal &&
            self.expectedNormal == other.expectedNormal &&
            self.extended == other.extended &&
            self.expectedExtended == other.expectedExtended &&
            self.duration == other.duration &&
            self.expectedDuration == other.expectedDuration &&
            self.insulinFormulation == other.insulinFormulation
    }
}
