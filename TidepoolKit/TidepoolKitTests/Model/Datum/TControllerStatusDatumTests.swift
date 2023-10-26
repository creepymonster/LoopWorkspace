//
//  TControllerStatusDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 10/28/21.
//  Copyright © 2021 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TControllerStatusDatumTests: XCTestCase {
    static let controllerStatus = TControllerStatusDatum(time: Date.test,
                                                         battery: TControllerStatusDatumBatteryTests.battery)
    static let controllerStatusJSONDictionary: [String: Any] = [
        "type": "controllerStatus",
        "time": Date.testJSONString,
        "battery": TControllerStatusDatumBatteryTests.batteryJSONDictionary,
    ]
    
    func testInitializer() {
        let controllerStatus = TControllerStatusDatumTests.controllerStatus
        XCTAssertEqual(controllerStatus.battery, TControllerStatusDatumBatteryTests.battery)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TControllerStatusDatumTests.controllerStatus, TControllerStatusDatumTests.controllerStatusJSONDictionary)
    }
}

class TControllerStatusDatumBatteryTests: XCTestCase {
    static let battery = TControllerStatusDatum.Battery(time: Date.test,
                                                        state: .charging,
                                                        remaining: 0.75,
                                                        units: .percent)
    static let batteryJSONDictionary: [String: Any] = [
        "time": Date.testJSONString,
        "state": "charging",
        "remaining": 0.75,
        "units": "percent"
    ]
    
    func testInitializer() {
        let battery = TControllerStatusDatumBatteryTests.battery
        XCTAssertEqual(battery.time, Date.test)
        XCTAssertEqual(battery.state, .charging)
        XCTAssertEqual(battery.remaining, 0.75)
        XCTAssertEqual(battery.units, .percent)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TControllerStatusDatumBatteryTests.battery, TControllerStatusDatumBatteryTests.batteryJSONDictionary)
    }
}

class TControllerStatusDatumBatteryStateTests: XCTestCase {
    func testTraining() {
        XCTAssertEqual(TControllerStatusDatum.Battery.State.unplugged.rawValue, "unplugged")
        XCTAssertEqual(TControllerStatusDatum.Battery.State.charging.rawValue, "charging")
        XCTAssertEqual(TControllerStatusDatum.Battery.State.full.rawValue, "full")
    }
}

class TControllerStatusDatumBatteryUnitsTests: XCTestCase {
    func testTraining() {
        XCTAssertEqual(TControllerStatusDatum.Battery.Units.percent.rawValue, "percent")
    }
}

extension TControllerStatusDatum {
    func isEqual(to other: TControllerStatusDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.battery == other.battery
    }
}
