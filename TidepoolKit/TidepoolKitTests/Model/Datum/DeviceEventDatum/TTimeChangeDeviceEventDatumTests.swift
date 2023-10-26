//
//  TTimeChangeDeviceEventDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/8/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TTimeChangeDeviceEventDatumTests: XCTestCase {
    static let timeChangeDeviceEvent = TTimeChangeDeviceEventDatum(time: Date.test,
                                                                   from: TTimeChangeDeviceEventDatumInfoTests.info,
                                                                   to: TTimeChangeDeviceEventDatumInfoTests.info,
                                                                   method: .manual)
    static let timeChangeDeviceEventJSONDictionary: [String: Any] = [
        "type": "deviceEvent",
        "subType": "timeChange",
        "time": Date.testJSONString,
        "from": TTimeChangeDeviceEventDatumInfoTests.infoJSONDictionary,
        "to": TTimeChangeDeviceEventDatumInfoTests.infoJSONDictionary,
        "method": "manual"
    ]
    
    func testInitializer() {
        let timeChangeDeviceEvent = TTimeChangeDeviceEventDatumTests.timeChangeDeviceEvent
        XCTAssertEqual(timeChangeDeviceEvent.from, TTimeChangeDeviceEventDatumInfoTests.info)
        XCTAssertEqual(timeChangeDeviceEvent.to, TTimeChangeDeviceEventDatumInfoTests.info)
        XCTAssertEqual(timeChangeDeviceEvent.method, .manual)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TTimeChangeDeviceEventDatumTests.timeChangeDeviceEvent, TTimeChangeDeviceEventDatumTests.timeChangeDeviceEventJSONDictionary)
    }
}

class TTimeChangeDeviceEventDatumMethodTests: XCTestCase {
    func testMethod() {
        XCTAssertEqual(TTimeChangeDeviceEventDatum.Method.automatic.rawValue, "automatic")
        XCTAssertEqual(TTimeChangeDeviceEventDatum.Method.manual.rawValue, "manual")
    }
}

class TTimeChangeDeviceEventDatumInfoTests: XCTestCase {
    static let info = TTimeChangeDeviceEventDatum.Info(time: Date.testJSONString, timeZoneName: "America/Los_Angeles")
    static let infoJSONDictionary: [String: Any] = [
        "time": Date.testJSONString,
        "timeZoneName": "America/Los_Angeles"
    ]
    
    func testInitializer() {
        let info = TTimeChangeDeviceEventDatumInfoTests.info
        XCTAssertEqual(info.time, Date.testJSONString)
        XCTAssertEqual(info.timeZoneName, "America/Los_Angeles")
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TTimeChangeDeviceEventDatumInfoTests.info, TTimeChangeDeviceEventDatumInfoTests.infoJSONDictionary)
    }
}

class TTimeChangeDeviceEventDatumChangeTests: XCTestCase {
    static let change = TTimeChangeDeviceEventDatum.Change(from: Date.testJSONString, to: Date.testJSONString, agent: .manual)
    static let changeJSONDictionary: [String: Any] = [
        "from": Date.testJSONString,
        "to": Date.testJSONString,
        "agent": "manual"
    ]
    
    func testInitializer() {
        let change = TTimeChangeDeviceEventDatumChangeTests.change
        XCTAssertEqual(change.from, Date.testJSONString)
        XCTAssertEqual(change.to, Date.testJSONString)
        XCTAssertEqual(change.agent, .manual)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TTimeChangeDeviceEventDatumChangeTests.change, TTimeChangeDeviceEventDatumChangeTests.changeJSONDictionary)
    }
}

class TTimeChangeDeviceEventDatumChangeAgentTests: XCTestCase {
    func testAgent() {
        XCTAssertEqual(TTimeChangeDeviceEventDatum.Change.Agent.automatic.rawValue, "automatic")
        XCTAssertEqual(TTimeChangeDeviceEventDatum.Change.Agent.manual.rawValue, "manual")
    }
}

extension TTimeChangeDeviceEventDatum {
    func isEqual(to other: TTimeChangeDeviceEventDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.from == other.from &&
            self.to == other.to &&
            self.method == other.method &&
            self.change == other.change
    }
}
