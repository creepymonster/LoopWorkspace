//
//  TPumpStatusDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 3/6/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TPumpStatusDatumTests: XCTestCase {
    static let pumpStatus = TPumpStatusDatum(time: Date.test,
                                             basalDelivery: TPumpStatusDatumBasalDeliveryTests.basalDelivery,
                                             battery: TPumpStatusDatumBatteryTests.battery,
                                             bolusDelivery: TPumpStatusDatumBolusDeliveryTests.bolusDelivery,
                                             deliveryIndeterminant: false,
                                             reservoir: TPumpStatusDatumReservoirTests.reservoir)
    static let pumpStatusJSONDictionary: [String: Any] = [
        "type": "pumpStatus",
        "time": Date.testJSONString,
        "basalDelivery": TPumpStatusDatumBasalDeliveryTests.basalDeliveryJSONDictionary,
        "battery": TPumpStatusDatumBatteryTests.batteryJSONDictionary,
        "bolusDelivery": TPumpStatusDatumBolusDeliveryTests.bolusDeliveryJSONDictionary,
        "deliveryIndeterminant": false,
        "reservoir": TPumpStatusDatumReservoirTests.reservoirJSONDictionary
    ]

    func testInitializer() {
        let pumpStatus = TPumpStatusDatumTests.pumpStatus
        XCTAssertEqual(pumpStatus.basalDelivery, TPumpStatusDatumBasalDeliveryTests.basalDelivery)
        XCTAssertEqual(pumpStatus.battery, TPumpStatusDatumBatteryTests.battery)
        XCTAssertEqual(pumpStatus.bolusDelivery, TPumpStatusDatumBolusDeliveryTests.bolusDelivery)
        XCTAssertEqual(pumpStatus.deliveryIndeterminant, false)
        XCTAssertEqual(pumpStatus.reservoir, TPumpStatusDatumReservoirTests.reservoir)
    }

    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpStatusDatumTests.pumpStatus, TPumpStatusDatumTests.pumpStatusJSONDictionary)
    }
}

class TPumpStatusDatumBasalDeliveryTests: XCTestCase {
    static let basalDelivery = TPumpStatusDatum.BasalDelivery(state: .temporary, time: Date.test, dose: TPumpStatusDatumBasalDeliveryDoseTests.dose)
    static let basalDeliveryJSONDictionary: [String: Any] = [
        "state": "temporary",
        "time": Date.testJSONString,
        "dose": TPumpStatusDatumBasalDeliveryDoseTests.doseJSONDictionary
    ]

    func testInitializer() {
        let basalDelivery = TPumpStatusDatumBasalDeliveryTests.basalDelivery
        XCTAssertEqual(basalDelivery.state, .temporary)
        XCTAssertEqual(basalDelivery.time, Date.test)
        XCTAssertEqual(basalDelivery.dose, TPumpStatusDatumBasalDeliveryDoseTests.dose)
    }

    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpStatusDatumBasalDeliveryTests.basalDelivery, TPumpStatusDatumBasalDeliveryTests.basalDeliveryJSONDictionary)
    }
}

class TPumpStatusDatumBasalDeliveryStateTests: XCTestCase {
    func testState() {
        XCTAssertEqual(TPumpStatusDatum.BasalDelivery.State.cancelingTemporary.rawValue, "cancelingTemporary")
        XCTAssertEqual(TPumpStatusDatum.BasalDelivery.State.initiatingTemporary.rawValue, "initiatingTemporary")
        XCTAssertEqual(TPumpStatusDatum.BasalDelivery.State.resuming.rawValue, "resuming")
        XCTAssertEqual(TPumpStatusDatum.BasalDelivery.State.scheduled.rawValue, "scheduled")
        XCTAssertEqual(TPumpStatusDatum.BasalDelivery.State.suspended.rawValue, "suspended")
        XCTAssertEqual(TPumpStatusDatum.BasalDelivery.State.suspending.rawValue, "suspending")
        XCTAssertEqual(TPumpStatusDatum.BasalDelivery.State.temporary.rawValue, "temporary")
    }
}

class TPumpStatusDatumBasalDeliveryDoseTests: XCTestCase {
    static let dose = TPumpStatusDatum.BasalDelivery.Dose(startTime: Date.test, endTime: Date.test, rate: 2.34, amountDelivered: 1.23)
    static let doseJSONDictionary: [String: Any] = [
        "startTime": Date.testJSONString,
        "endTime": Date.testJSONString,
        "rate": 2.34,
        "amountDelivered": 1.23
    ]

    func testInitializer() {
        let dose = TPumpStatusDatumBasalDeliveryDoseTests.dose
        XCTAssertEqual(dose.startTime, Date.test)
        XCTAssertEqual(dose.endTime, Date.test)
        XCTAssertEqual(dose.rate, 2.34)
        XCTAssertEqual(dose.amountDelivered, 1.23)
    }

    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpStatusDatumBasalDeliveryDoseTests.dose, TPumpStatusDatumBasalDeliveryDoseTests.doseJSONDictionary)
    }
}

class TPumpStatusDatumBatteryTests: XCTestCase {
    static let battery = TPumpStatusDatum.Battery(time: Date.test, state: .unplugged, remaining: 0.12, units: .percent)
    static let batteryJSONDictionary: [String: Any] = [
        "time": Date.testJSONString,
        "state": "unplugged",
        "remaining": 0.12,
        "units": "percent"
    ]

    func testInitializer() {
        let battery = TPumpStatusDatumBatteryTests.battery
        XCTAssertEqual(battery.time, Date.test)
        XCTAssertEqual(battery.state, .unplugged)
        XCTAssertEqual(battery.remaining, 0.12)
        XCTAssertEqual(battery.units, .percent)
    }

    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpStatusDatumBatteryTests.battery, TPumpStatusDatumBatteryTests.batteryJSONDictionary)
    }
}

class TPumpStatusDatumBatteryStateTests: XCTestCase {
    func testState() {
        XCTAssertEqual(TPumpStatusDatum.Battery.State.unplugged.rawValue, "unplugged")
        XCTAssertEqual(TPumpStatusDatum.Battery.State.charging.rawValue, "charging")
        XCTAssertEqual(TPumpStatusDatum.Battery.State.full.rawValue, "full")
    }
}

class TPumpStatusDatumBatteryUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TPumpStatusDatum.Battery.Units.percent.rawValue, "percent")
    }
}

class TPumpStatusDatumBolusDeliveryTests: XCTestCase {
    static let bolusDelivery = TPumpStatusDatum.BolusDelivery(state: .delivering, dose: TPumpStatusDatumBolusDeliveryDoseTests.dose)
    static let bolusDeliveryJSONDictionary: [String: Any] = [
        "state": "delivering",
        "dose": TPumpStatusDatumBolusDeliveryDoseTests.doseJSONDictionary
    ]

    func testInitializer() {
        let bolusDelivery = TPumpStatusDatumBolusDeliveryTests.bolusDelivery
        XCTAssertEqual(bolusDelivery.state, .delivering)
        XCTAssertEqual(bolusDelivery.dose, TPumpStatusDatumBolusDeliveryDoseTests.dose)
    }

    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpStatusDatumBolusDeliveryTests.bolusDelivery, TPumpStatusDatumBolusDeliveryTests.bolusDeliveryJSONDictionary)
    }
}

class TPumpStatusDatumBolusDeliveryStateTests: XCTestCase {
    func testState() {
        XCTAssertEqual(TPumpStatusDatum.BolusDelivery.State.canceling.rawValue, "canceling")
        XCTAssertEqual(TPumpStatusDatum.BolusDelivery.State.delivering.rawValue, "delivering")
        XCTAssertEqual(TPumpStatusDatum.BolusDelivery.State.initiating.rawValue, "initiating")
        XCTAssertEqual(TPumpStatusDatum.BolusDelivery.State.none.rawValue, "none")
    }
}

class TPumpStatusDatumBolusDeliveryDoseTests: XCTestCase {
    static let dose = TPumpStatusDatum.BolusDelivery.Dose(startTime: Date.test, amount: 2.34, amountDelivered: 1.23)
    static let doseJSONDictionary: [String: Any] = [
        "startTime": Date.testJSONString,
        "amount": 2.34,
        "amountDelivered": 1.23
    ]

    func testInitializer() {
        let dose = TPumpStatusDatumBolusDeliveryDoseTests.dose
        XCTAssertEqual(dose.startTime, Date.test)
        XCTAssertEqual(dose.amount, 2.34)
        XCTAssertEqual(dose.amountDelivered, 1.23)
    }

    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpStatusDatumBolusDeliveryDoseTests.dose, TPumpStatusDatumBolusDeliveryDoseTests.doseJSONDictionary)
    }
}

class TPumpStatusDatumReservoirTests: XCTestCase {
    static let reservoir = TPumpStatusDatum.Reservoir(time: Date.test, remaining: 123.45)
    static let reservoirJSONDictionary: [String: Any] = [
        "time": Date.testJSONString,
        "remaining": 123.45,
        "units": "Units"
    ]

    func testInitializer() {
        let reservoir = TPumpStatusDatumReservoirTests.reservoir
        XCTAssertEqual(reservoir.time, Date.test)
        XCTAssertEqual(reservoir.remaining, 123.45)
        XCTAssertEqual(reservoir.units, .units)
    }

    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpStatusDatumReservoirTests.reservoir, TPumpStatusDatumReservoirTests.reservoirJSONDictionary)
    }
}

extension TPumpStatusDatum {
    func isEqual(to other: TPumpStatusDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.basalDelivery == other.basalDelivery &&
            self.battery == other.battery &&
            self.bolusDelivery == other.bolusDelivery &&
            self.deliveryIndeterminant == other.deliveryIndeterminant &&
            self.reservoir == other.reservoir
    }
}
