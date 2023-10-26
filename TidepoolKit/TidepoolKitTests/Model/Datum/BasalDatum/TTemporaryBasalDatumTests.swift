//
//  TTemporaryBasalDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/8/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TTemporaryBasalDatumTests: XCTestCase {
    static let temporaryBasal = TTemporaryBasalDatum(time: Date.test,
                                                     duration: 123.456,
                                                     expectedDuration: 234.567,
                                                     rate: 1.23,
                                                     percent: 0.75,
                                                     insulinFormulation: TInsulinDatumFormulationTests.formulation,
                                                     suppressed: TScheduledBasalDatumSuppressedTests.suppressed)
    static let temporaryBasalJSONDictionary: [String: Any] = [
        "type": "basal",
        "deliveryType": "temp",
        "time": Date.testJSONString,
        "duration": 123456,
        "expectedDuration": 234567,
        "rate": 1.23,
        "percent": 0.75,
        "insulinFormulation": TInsulinDatumFormulationTests.formulationJSONDictionary,
        "suppressed": TScheduledBasalDatumSuppressedTests.suppressedJSONDictionary
    ]
    
    func testInitializer() {
        let temporaryBasal = TTemporaryBasalDatumTests.temporaryBasal
        XCTAssertEqual(temporaryBasal.duration, 123.456)
        XCTAssertEqual(temporaryBasal.expectedDuration, 234.567)
        XCTAssertEqual(temporaryBasal.rate, 1.23)
        XCTAssertEqual(temporaryBasal.percent, 0.75)
        XCTAssertEqual(temporaryBasal.insulinFormulation, TInsulinDatumFormulationTests.formulation)
        XCTAssertEqual(temporaryBasal.suppressed, TScheduledBasalDatumSuppressedTests.suppressed)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TTemporaryBasalDatumTests.temporaryBasal, TTemporaryBasalDatumTests.temporaryBasalJSONDictionary)
    }
}

class TTemporaryBasalDatumSuppressedTests: XCTestCase {
    static let suppressed = TTemporaryBasalDatum.Suppressed(rate: 2.34,
                                                            percent: 1.5,
                                                            insulinFormulation: TInsulinDatumFormulationTests.formulation,
                                                            annotations: [TDictionary(["a": "b", "c": 0]), TDictionary(["alpha": "bravo"])],
                                                            suppressed: TScheduledBasalDatumSuppressedTests.suppressed)
    static let suppressedJSONDictionary: [String: Any] = [
        "type": "basal",
        "deliveryType": "temp",
        "rate": 2.34,
        "percent": 1.5,
        "insulinFormulation": TInsulinDatumFormulationTests.formulationJSONDictionary,
        "annotations": [["a": "b", "c": 0], ["alpha": "bravo"]],
        "suppressed": TScheduledBasalDatumSuppressedTests.suppressedJSONDictionary
    ]
    
    func testInitializer() {
        let suppressed = TTemporaryBasalDatumSuppressedTests.suppressed
        XCTAssertEqual(suppressed.type, .basal)
        XCTAssertEqual(suppressed.deliveryType, .temporary)
        XCTAssertEqual(suppressed.rate, 2.34)
        XCTAssertEqual(suppressed.percent, 1.5)
        XCTAssertEqual(suppressed.insulinFormulation, TInsulinDatumFormulationTests.formulation)
        XCTAssertEqual(suppressed.annotations, [TDictionary(["a": "b", "c": 0]), TDictionary(["alpha": "bravo"])])
        XCTAssertEqual(suppressed.suppressed, TScheduledBasalDatumSuppressedTests.suppressed)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TTemporaryBasalDatumSuppressedTests.suppressed, TTemporaryBasalDatumSuppressedTests.suppressedJSONDictionary)
    }
}

extension TTemporaryBasalDatum {
    func isEqual(to other: TTemporaryBasalDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.rate == other.rate &&
            self.percent == other.percent &&
            self.insulinFormulation == other.insulinFormulation &&
            self.suppressed == other.suppressed
    }
}

extension TTemporaryBasalDatum.Suppressed {
    func isEqual(to other: TTemporaryBasalDatum.Suppressed) -> Bool {
        return super.isEqual(to: other) &&
            self.rate == other.rate &&
            self.percent == other.percent &&
            self.suppressed == other.suppressed
    }
}
