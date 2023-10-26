//
//  TWaterDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/8/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TWaterDatumTests: XCTestCase {
    static let water = TWaterDatum(time: Date.test, amount: TWaterDatumAmountTests.amount)
    static let waterJSONDictionary: [String: Any] = [
        "type": "water",
        "time": Date.testJSONString,
        "amount": TWaterDatumAmountTests.amountJSONDictionary
    ]
    
    func testInitializer() {
        let water = TWaterDatumTests.water
        XCTAssertEqual(water.amount, TWaterDatumAmountTests.amount)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TWaterDatumTests.water, TWaterDatumTests.waterJSONDictionary)
    }
}

class TWaterDatumAmountTests: XCTestCase {
    static let amount = TWaterDatum.Amount(1.23, .liters)
    static let amountJSONDictionary: [String: Any] = [
        "value": 1.23,
        "units": "liters"
    ]
    
    func testInitializer() {
        let amount = TWaterDatumAmountTests.amount
        XCTAssertEqual(amount.value, 1.23)
        XCTAssertEqual(amount.units, .liters)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TWaterDatumAmountTests.amount, TWaterDatumAmountTests.amountJSONDictionary)
    }
}

class TWaterDatumAmountUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TWaterDatum.Amount.Units.milliliters.rawValue, "milliliters")
        XCTAssertEqual(TWaterDatum.Amount.Units.ounces.rawValue, "ounces")
        XCTAssertEqual(TWaterDatum.Amount.Units.liters.rawValue, "liters")
        XCTAssertEqual(TWaterDatum.Amount.Units.gallons.rawValue, "gallons")
    }
}

extension TWaterDatum {
    func isEqual(to other: TWaterDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.amount == other.amount
    }
}
