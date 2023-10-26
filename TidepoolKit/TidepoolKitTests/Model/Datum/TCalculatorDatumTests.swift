//
//  TCalculatorDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/6/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TCalculatorDatumTests: XCTestCase {
    static let calculator = TCalculatorDatum(time: Date.test,
                                             insulinOnBoard: 1.23,
                                             bloodGlucoseInput: 234,
                                             insulinSensitivity: 34.5,
                                             carbohydrateInput: 45.6,
                                             insulinCarbohydrateRatio: 56.7,
                                             bloodGlucoseTarget: TBloodGlucoseTargetTests.target,
                                             recommended: TCalculatorDatumRecommendedTests.recommended,
                                             units: .milligramsPerDeciliter)
    static let calculatorJSONDictionary: [String: Any] = [
        "type": "wizard",
        "time": Date.testJSONString,
        "insulinOnBoard": 1.23,
        "bgInput": 234,
        "insulinSensitivity": 34.5,
        "carbInput": 45.6,
        "insulinCarbRatio": 56.7,
        "bgTarget": TBloodGlucoseTargetTests.targetJSONDictionary,
        "recommended": TCalculatorDatumRecommendedTests.recommendedJSONDictionary,
        "units": "mg/dL"
    ]
    
    func testInitializer() {
        let calculator = TCalculatorDatumTests.calculator
        XCTAssertEqual(calculator.insulinOnBoard, 1.23)
        XCTAssertEqual(calculator.bloodGlucoseInput, 234)
        XCTAssertEqual(calculator.insulinSensitivity, 34.5)
        XCTAssertEqual(calculator.carbohydrateInput, 45.6)
        XCTAssertEqual(calculator.insulinCarbohydrateRatio, 56.7)
        XCTAssertEqual(calculator.bloodGlucoseTarget, TBloodGlucoseTargetTests.target)
        XCTAssertEqual(calculator.recommended, TCalculatorDatumRecommendedTests.recommended)
        XCTAssertEqual(calculator.units, .milligramsPerDeciliter)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TCalculatorDatumTests.calculator, TCalculatorDatumTests.calculatorJSONDictionary)
    }
}

class TCalculatorDatumRecommendedTests: XCTestCase {
    static let recommended = TCalculatorDatum.Recommended(net: 1.23, carbohydrate: 2.34, correction: 3.45)
    static let recommendedJSONDictionary: [String: Any] = [
        "net": 1.23,
        "carb": 2.34,
        "correction": 3.45
    ]
    
    func testInitializer() {
        let recommended = TCalculatorDatumRecommendedTests.recommended
        XCTAssertEqual(recommended.net, 1.23)
        XCTAssertEqual(recommended.carbohydrate, 2.34)
        XCTAssertEqual(recommended.correction, 3.45)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TCalculatorDatumRecommendedTests.recommended, TCalculatorDatumRecommendedTests.recommendedJSONDictionary)
    }
}

extension TCalculatorDatum {
    func isEqual(to other: TCalculatorDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.insulinOnBoard == other.insulinOnBoard &&
            self.bloodGlucoseInput == other.bloodGlucoseInput &&
            self.insulinSensitivity == other.insulinSensitivity &&
            self.carbohydrateInput == other.carbohydrateInput &&
            self.insulinCarbohydrateRatio == other.insulinCarbohydrateRatio &&
            self.bloodGlucoseTarget == other.bloodGlucoseTarget &&
            self.recommended == other.recommended &&
            self.bolus == other.bolus &&
            self.bolusId == other.bolusId &&
            self.units == other.units
    }
}
