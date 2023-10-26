//
//  TScheduledBasalDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/8/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TScheduledBasalDatumTests: XCTestCase {
    static let scheduledBasal = TScheduledBasalDatum(time: Date.test,
                                                     duration: 123.456,
                                                     expectedDuration: 234.567,
                                                     rate: 1.23,
                                                     scheduleName: "One",
                                                     insulinFormulation: TInsulinDatumFormulationTests.formulation)
    static let scheduledBasalJSONDictionary: [String: Any] = [
        "type": "basal",
        "deliveryType": "scheduled",
        "time": Date.testJSONString,
        "duration": 123456,
        "expectedDuration": 234567,
        "rate": 1.23,
        "scheduleName": "One",
        "insulinFormulation": TInsulinDatumFormulationTests.formulationJSONDictionary
    ]
    
    func testInitializer() {
        let scheduledBasal = TScheduledBasalDatumTests.scheduledBasal
        XCTAssertEqual(scheduledBasal.duration, 123.456)
        XCTAssertEqual(scheduledBasal.expectedDuration, 234.567)
        XCTAssertEqual(scheduledBasal.rate, 1.23)
        XCTAssertEqual(scheduledBasal.scheduleName, "One")
        XCTAssertEqual(scheduledBasal.insulinFormulation, TInsulinDatumFormulationTests.formulation)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TScheduledBasalDatumTests.scheduledBasal, TScheduledBasalDatumTests.scheduledBasalJSONDictionary)
    }
}

class TScheduledBasalDatumSuppressedTests: XCTestCase {
    static let suppressed = TScheduledBasalDatum.Suppressed(rate: 2.34,
                                                            scheduleName: "Two",
                                                            insulinFormulation: TInsulinDatumFormulationTests.formulation,
                                                            annotations: [TDictionary(["a": "b", "c": 0]), TDictionary(["alpha": "bravo"])])
    static let suppressedJSONDictionary: [String: Any] = [
        "type": "basal",
        "deliveryType": "scheduled",
        "rate": 2.34,
        "scheduleName": "Two",
        "insulinFormulation": TInsulinDatumFormulationTests.formulationJSONDictionary,
        "annotations": [["a": "b", "c": 0], ["alpha": "bravo"]]
    ]
    
    func testInitializer() {
        let suppressed = TScheduledBasalDatumSuppressedTests.suppressed
        XCTAssertEqual(suppressed.type, .basal)
        XCTAssertEqual(suppressed.deliveryType, .scheduled)
        XCTAssertEqual(suppressed.rate, 2.34)
        XCTAssertEqual(suppressed.scheduleName, "Two")
        XCTAssertEqual(suppressed.insulinFormulation, TInsulinDatumFormulationTests.formulation)
        XCTAssertEqual(suppressed.annotations, [TDictionary(["a": "b", "c": 0]), TDictionary(["alpha": "bravo"])])
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TScheduledBasalDatumSuppressedTests.suppressed, TScheduledBasalDatumSuppressedTests.suppressedJSONDictionary)
    }
}

extension TScheduledBasalDatum {
    func isEqual(to other: TScheduledBasalDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.rate == other.rate &&
            self.scheduleName == other.scheduleName &&
            self.insulinFormulation == other.insulinFormulation
    }
}

extension TScheduledBasalDatum.Suppressed {
    func isEqual(to other: TScheduledBasalDatum.Suppressed) -> Bool {
        return super.isEqual(to: other) &&
            self.rate == other.rate &&
            self.scheduleName == other.scheduleName
    }
}
