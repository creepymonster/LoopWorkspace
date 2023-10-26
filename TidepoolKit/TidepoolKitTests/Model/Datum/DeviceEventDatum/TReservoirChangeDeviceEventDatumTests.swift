//
//  TReservoirChangeDeviceEventDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/8/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TReservoirChangeDeviceEventDatumTests: XCTestCase {
    static let reservoirChangeDeviceEvent = TReservoirChangeDeviceEventDatum(time: Date.test)
    static let reservoirChangeDeviceEventJSONDictionary: [String: Any] = [
        "type": "deviceEvent",
        "subType": "reservoirChange",
        "time": Date.testJSONString
    ]
    
    func testInitializer() {
        XCTAssertNotNil(TReservoirChangeDeviceEventDatumTests.reservoirChangeDeviceEvent)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TReservoirChangeDeviceEventDatumTests.reservoirChangeDeviceEvent, TReservoirChangeDeviceEventDatumTests.reservoirChangeDeviceEventJSONDictionary)
    }
}

extension TReservoirChangeDeviceEventDatum {
    func isEqual(to other: TReservoirChangeDeviceEventDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.status == other.status &&
            self.statusId == other.statusId
    }
}
