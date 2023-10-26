//
//  TBasalDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/8/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TBasalDatumTests: XCTestCase {
    static let basal = TBasalDatum(.scheduled, time: Date.test, duration: 123.456, expectedDuration: 234.567)
    static let basalJSONDictionary: [String: Any] = [
        "type": "basal",
        "deliveryType": "scheduled",
        "time": Date.testJSONString,
        "duration": 123456,
        "expectedDuration": 234567
    ]
    
    func testInitializer() {
        let basal = TBasalDatumTests.basal
        XCTAssertEqual(basal.deliveryType, .scheduled)
        XCTAssertEqual(basal.duration, 123.456)
        XCTAssertEqual(basal.expectedDuration, 234.567)
    }
}

class TBasalDatumDeliveryTypeTests: XCTestCase {
    func testDeliveryType() {
        XCTAssertEqual(TBasalDatum.DeliveryType.automated.rawValue, "automated")
        XCTAssertEqual(TBasalDatum.DeliveryType.scheduled.rawValue, "scheduled")
        XCTAssertEqual(TBasalDatum.DeliveryType.suspended.rawValue, "suspend")
        XCTAssertEqual(TBasalDatum.DeliveryType.temporary.rawValue, "temp")
    }
}

class TBasalDatumSuppressedBasalTests: XCTestCase {
    static let suppressedBasal = TBasalDatum.SuppressedBasal(.scheduled,
                                                             insulinFormulation: TInsulinDatumFormulationTests.formulation,
                                                             annotations: [TDictionary(["a": "b", "c": 0]), TDictionary(["alpha": "bravo"])])
    static let suppressedBasalJSONDictionary: [String: Any] = [
        "type": "basal",
        "deliveryType": "scheduled",
        "insulinFormulation": TInsulinDatumFormulationTests.formulationJSONDictionary,
        "annotations": [["a": "b", "c": 0], ["alpha": "bravo"]]
    ]
    
    func testInitializer() {
        let suppressedBasal = TBasalDatumSuppressedBasalTests.suppressedBasal
        XCTAssertEqual(suppressedBasal.type, .basal)
        XCTAssertEqual(suppressedBasal.deliveryType, .scheduled)
        XCTAssertEqual(suppressedBasal.insulinFormulation, TInsulinDatumFormulationTests.formulation)
        XCTAssertEqual(suppressedBasal.annotations, [TDictionary(["a": "b", "c": 0]), TDictionary(["alpha": "bravo"])])
    }
}

extension TBasalDatum {
    func isEqual(to other: TBasalDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.deliveryType == other.deliveryType &&
            self.duration == other.duration &&
            self.expectedDuration == other.expectedDuration
    }
}

extension TBasalDatum.SuppressedBasal: Equatable {
    public static func == (lhs: TBasalDatum.SuppressedBasal, rhs: TBasalDatum.SuppressedBasal) -> Bool {
        switch (lhs, rhs) {
        case let (lhs as TAutomatedBasalDatum.Suppressed, rhs as TAutomatedBasalDatum.Suppressed):
            return lhs.isEqual(to: rhs)
        case let (lhs as TScheduledBasalDatum.Suppressed, rhs as TScheduledBasalDatum.Suppressed):
            return lhs.isEqual(to: rhs)
        case let (lhs as TTemporaryBasalDatum.Suppressed, rhs as TTemporaryBasalDatum.Suppressed):
            return lhs.isEqual(to: rhs)
        default:
            return false
        }
    }
    
    func isEqual(to other: TBasalDatum.SuppressedBasal) -> Bool {
        return self.type == other.type &&
            self.deliveryType == other.deliveryType &&
            self.insulinFormulation == other.insulinFormulation &&
            self.annotations == other.annotations
    }
}
