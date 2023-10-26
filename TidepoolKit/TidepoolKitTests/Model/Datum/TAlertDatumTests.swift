//
//  TAlertDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 2/1/22.
//  Copyright © 2022 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TAlertDatumTests: XCTestCase {
    static let alert = TAlertDatum(time: Date.test,
                                   name: "Alert One",
                                   priority: .critical,
                                   trigger: .delayed,
                                   triggerDelay: .minutes(15),
                                   sound: .name,
                                   soundName: "Beep Beep",
                                   issuedTime: Date.test,
                                   acknowledgedTime: Date.test,
                                   retractedTime: Date.test)
    static let alertJSONDictionary: [String: Any] = [
        "type": "alert",
        "time": Date.testJSONString,
        "name": "Alert One",
        "priority": "critical",
        "trigger": "delayed",
        "triggerDelay": 900,
        "sound": "name",
        "soundName": "Beep Beep",
        "issuedTime": Date.testJSONString,
        "acknowledgedTime": Date.testJSONString,
        "retractedTime": Date.testJSONString
    ]

    func testInitializer() {
        let alert = TAlertDatumTests.alert
        XCTAssertEqual(alert.name, "Alert One")
        XCTAssertEqual(alert.priority, .critical)
        XCTAssertEqual(alert.trigger, .delayed)
        XCTAssertEqual(alert.triggerDelay, .minutes(15))
        XCTAssertEqual(alert.sound, .name)
        XCTAssertEqual(alert.soundName, "Beep Beep")
        XCTAssertEqual(alert.issuedTime, Date.test)
        XCTAssertEqual(alert.acknowledgedTime, Date.test)
        XCTAssertEqual(alert.retractedTime, Date.test)
    }

    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TAlertDatumTests.alert, TAlertDatumTests.alertJSONDictionary)
    }
}

class TAlertDatumPriorityTests: XCTestCase {
    func testPriority() {
        XCTAssertEqual(TAlertDatum.Priority.critical.rawValue, "critical")
        XCTAssertEqual(TAlertDatum.Priority.normal.rawValue, "normal")
        XCTAssertEqual(TAlertDatum.Priority.timeSensitive.rawValue, "timeSensitive")
    }
}

class TAlertDatumSoundTests: XCTestCase {
    func testSound() {
        XCTAssertEqual(TAlertDatum.Sound.name.rawValue, "name")
        XCTAssertEqual(TAlertDatum.Sound.silence.rawValue, "silence")
        XCTAssertEqual(TAlertDatum.Sound.vibrate.rawValue, "vibrate")
    }
}

class TAlertDatumTriggerTests: XCTestCase {
    func testTrigger() {
        XCTAssertEqual(TAlertDatum.Trigger.delayed.rawValue, "delayed")
        XCTAssertEqual(TAlertDatum.Trigger.immediate.rawValue, "immediate")
        XCTAssertEqual(TAlertDatum.Trigger.repeating.rawValue, "repeating")
    }
}

extension TAlertDatum {
    func isEqual(to other: TAlertDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.name == other.name &&
            self.priority == other.priority &&
            self.trigger == other.trigger &&
            self.triggerDelay == other.triggerDelay &&
            self.sound == other.sound &&
            self.soundName == other.soundName &&
            self.issuedTime == other.issuedTime &&
            self.acknowledgedTime == other.acknowledgedTime &&
            self.retractedTime == other.retractedTime
    }
}
