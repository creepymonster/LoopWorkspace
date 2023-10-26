//
//  TBloodGlucoseTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/5/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TBloodGlucoseUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TBloodGlucose.Units.milligramsPerDeciliter.rawValue, "mg/dL")
        XCTAssertEqual(TBloodGlucose.Units.millimolesPerLiter.rawValue, "mmol/L")
    }
}

class TBloodGlucoseTrendTests: XCTestCase {
    func testTrend() {
        XCTAssertEqual(TBloodGlucose.Trend.constant.rawValue, "constant")
        XCTAssertEqual(TBloodGlucose.Trend.slowFall.rawValue, "slowFall")
        XCTAssertEqual(TBloodGlucose.Trend.slowRise.rawValue, "slowRise")
        XCTAssertEqual(TBloodGlucose.Trend.moderateFall.rawValue, "moderateFall")
        XCTAssertEqual(TBloodGlucose.Trend.moderateRise.rawValue, "moderateRise")
        XCTAssertEqual(TBloodGlucose.Trend.rapidFall.rawValue, "rapidFall")
        XCTAssertEqual(TBloodGlucose.Trend.rapidRise.rawValue, "rapidRise")
    }
}

class TBloodGlucoseTargetTests: XCTestCase {
    static let target = TBloodGlucose.Target(target: 1.23)
    static let targetJSONDictionary: [String: Any] = [
        "target": 1.23
    ]
    
    func testInitializerWithTarget() {
        let target = TBloodGlucose.Target(target: 1.23)
        XCTAssertEqual(target.target, 1.23)
    }
    
    func testInitializerWithTargetAndRange() {
        let target = TBloodGlucose.Target(target: 1.23, range: 2.34)
        XCTAssertEqual(target.target, 1.23)
        XCTAssertEqual(target.range, 2.34)
    }
    
    func testInitializerWithTargetAndHigh() {
        let target = TBloodGlucose.Target(target: 1.23, high: 2.34)
        XCTAssertEqual(target.target, 1.23)
        XCTAssertEqual(target.high, 2.34)
    }
    
    func testInitializerWithLowAndHigh() {
        let target = TBloodGlucose.Target(low: 1.23, high: 2.34)
        XCTAssertEqual(target.low, 1.23)
        XCTAssertEqual(target.high, 2.34)
    }
    
    func testCodableAsJSONWithTarget() {
        let target = TBloodGlucose.Target(target: 1.23)
        XCTAssertCodableAsJSON(target, ["target": 1.23])
    }
    
    func testCodableAsJSONWithTargetAndRange() {
        let target = TBloodGlucose.Target(target: 1.23, range: 2.34)
        XCTAssertCodableAsJSON(target, ["target": 1.23, "range": 2.34])
    }
    
    func testCodableAsJSONWithTargetAndHigh() {
        let target = TBloodGlucose.Target(target: 1.23, high: 2.34)
        XCTAssertCodableAsJSON(target, ["target": 1.23, "high": 2.34])
    }
    
    func testCodableAsJSONWithLowAndHigh() {
        let target = TBloodGlucose.Target(low: 1.23, high: 2.34)
        XCTAssertCodableAsJSON(target, ["low": 1.23, "high": 2.34])
    }
}

class TBloodGlucoseStartTargetTests: XCTestCase {
    static let startTarget = TBloodGlucose.StartTarget(start: 12345.678, target: 1.23)
    static let startTargetJSONDictionary: [String: Any] = [
        "start": 12345678,
        "target": 1.23
    ]

    func testInitializerWithTarget() {
        let startTarget = TBloodGlucose.StartTarget(start: 12345.678, target: 1.23)
        XCTAssertEqual(startTarget.start, 12345.678)
        XCTAssertEqual(startTarget.target, 1.23)
    }

    func testInitializerWithTargetAndRange() {
        let startTarget = TBloodGlucose.StartTarget(start: 12345.678, target: 1.23, range: 2.34)
        XCTAssertEqual(startTarget.start, 12345.678)
        XCTAssertEqual(startTarget.target, 1.23)
        XCTAssertEqual(startTarget.range, 2.34)
    }

    func testInitializerWithTargetAndHigh() {
        let startTarget = TBloodGlucose.StartTarget(start: 12345.678, target: 1.23, high: 2.34)
        XCTAssertEqual(startTarget.start, 12345.678)
        XCTAssertEqual(startTarget.target, 1.23)
        XCTAssertEqual(startTarget.high, 2.34)
    }

    func testInitializerWithLowAndHigh() {
        let startTarget = TBloodGlucose.StartTarget(start: 12345.678, low: 1.23, high: 2.34)
        XCTAssertEqual(startTarget.start, 12345.678)
        XCTAssertEqual(startTarget.low, 1.23)
        XCTAssertEqual(startTarget.high, 2.34)
    }

    func testCodableAsJSONWithTarget() {
        let startTarget = TBloodGlucose.StartTarget(start: 12345.678, target: 1.23)
        XCTAssertCodableAsJSON(startTarget, ["start": 12345678, "target": 1.23])
    }

    func testCodableAsJSONWithTargetAndRange() {
        let startTarget = TBloodGlucose.StartTarget(start: 12345.678, target: 1.23, range: 2.34)
        XCTAssertCodableAsJSON(startTarget, ["start": 12345678, "target": 1.23, "range": 2.34])
    }

    func testCodableAsJSONWithTargetAndHigh() {
        let startTarget = TBloodGlucose.StartTarget(start: 12345.678, target: 1.23, high: 2.34)
        XCTAssertCodableAsJSON(startTarget, ["start": 12345678, "target": 1.23, "high": 2.34])
    }

    func testCodableAsJSONWithLowAndHigh() {
        let startTarget = TBloodGlucose.StartTarget(start: 12345.678, low: 1.23, high: 2.34)
        XCTAssertCodableAsJSON(startTarget, ["start": 12345678, "low": 1.23, "high": 2.34])
    }
}

class TBloodGlucoseValueRangeTests: XCTestCase {
    func testMilligramsPerDeciliter() {
        XCTAssertEqual(TBloodGlucose.valueRange(for: .milligramsPerDeciliter), 0...1000)
    }

    func testMillimolesPerLiter() {
        XCTAssertEqual(TBloodGlucose.valueRange(for: .millimolesPerLiter), 0...55.0)
    }
}

class TBloodGlucoseClampTests: XCTestCase {
    func testMilligramsPerDeciliterOutOfRangeRangeLower() {
        XCTAssertEqual(TBloodGlucose.clamp(value: -0.1, for: .milligramsPerDeciliter), 0)
    }

    func testMilligramsPerDeciliterInRangeLower() {
        XCTAssertEqual(TBloodGlucose.clamp(value: 0, for: .milligramsPerDeciliter), 0)
    }

    func testMilligramsPerDeciliterInRangeUpper() {
        XCTAssertEqual(TBloodGlucose.clamp(value: 1000, for: .milligramsPerDeciliter), 1000)
    }

    func testMilligramsPerDeciliterOutOfRangeRangeUpper() {
        XCTAssertEqual(TBloodGlucose.clamp(value: 1000.1, for: .milligramsPerDeciliter), 1000)
    }

    func testMillimolesPerLiterOutOfRangeRangeLower() {
        XCTAssertEqual(TBloodGlucose.clamp(value: -0.1, for: .millimolesPerLiter), 0)
    }

    func testMillimolesPerLiterInRangeLower() {
        XCTAssertEqual(TBloodGlucose.clamp(value: 0, for: .millimolesPerLiter), 0)
    }

    func testMillimolesPerLiterInRangeUpper() {
        XCTAssertEqual(TBloodGlucose.clamp(value: 55.0, for: .millimolesPerLiter), 55.0)
    }

    func testMillimolesPerLiterOutOfRangeRangeUpper() {
        XCTAssertEqual(TBloodGlucose.clamp(value: 55.01, for: .millimolesPerLiter), 55.0)
    }
}
