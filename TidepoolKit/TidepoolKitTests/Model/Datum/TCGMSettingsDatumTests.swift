//
//  TCGMSettingsDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/7/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TCGMSettingsDatumTests: XCTestCase {
    static let cgmSettings = TCGMSettingsDatum(time: Date.test,
                                               firmwareVersion: "10.11.12",
                                               hardwareVersion: "11.12.13",
                                               manufacturers: ["Alfa", "Romeo"],
                                               model: "Spider",
                                               name: "My Car",
                                               serialNumber: "1234567890",
                                               softwareVersion: "12.13.14",
                                               transmitterId: "ABCDEF",
                                               units: .milligramsPerDeciliter,
                                               defaultAlerts: TCGMSettingsDatumAlertsTests.alerts,
                                               scheduledAlerts: [TCGMSettingsDatumScheduledAlertTests.scheduledAlert, TCGMSettingsDatumScheduledAlertTests.scheduledAlert])
    static let cgmSettingsJSONDictionary: [String: Any] = [
        "type": "cgmSettings",
        "time": Date.testJSONString,
        "firmwareVersion": "10.11.12",
        "hardwareVersion": "11.12.13",
        "manufacturers": ["Alfa", "Romeo"],
        "model": "Spider",
        "name": "My Car",
        "serialNumber": "1234567890",
        "softwareVersion": "12.13.14",
        "transmitterId": "ABCDEF",
        "units": "mg/dL",
        "defaultAlerts": TCGMSettingsDatumAlertsTests.alertsJSONDictionary,
        "scheduledAlerts": [TCGMSettingsDatumScheduledAlertTests.scheduledAlertJSONDictionary, TCGMSettingsDatumScheduledAlertTests.scheduledAlertJSONDictionary]
    ]
    
    func testInitializer() {
        let cgmSettings = TCGMSettingsDatumTests.cgmSettings
        XCTAssertEqual(cgmSettings.firmwareVersion, "10.11.12")
        XCTAssertEqual(cgmSettings.hardwareVersion, "11.12.13")
        XCTAssertEqual(cgmSettings.manufacturers, ["Alfa", "Romeo"])
        XCTAssertEqual(cgmSettings.model, "Spider")
        XCTAssertEqual(cgmSettings.name, "My Car")
        XCTAssertEqual(cgmSettings.serialNumber, "1234567890")
        XCTAssertEqual(cgmSettings.softwareVersion, "12.13.14")
        XCTAssertEqual(cgmSettings.transmitterId, "ABCDEF")
        XCTAssertEqual(cgmSettings.units, .milligramsPerDeciliter)
        XCTAssertEqual(cgmSettings.defaultAlerts, TCGMSettingsDatumAlertsTests.alerts)
        XCTAssertEqual(cgmSettings.scheduledAlerts, [TCGMSettingsDatumScheduledAlertTests.scheduledAlert, TCGMSettingsDatumScheduledAlertTests.scheduledAlert])
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TCGMSettingsDatumTests.cgmSettings, TCGMSettingsDatumTests.cgmSettingsJSONDictionary)
    }
}

class TCGMSettingsDatumAlertsTests: XCTestCase {
    static let alerts = TCGMSettingsDatum.Alerts(enabled: true,
                                                 urgentLow: TCGMSettingsDatumAlertsLevelAlertTests.levelAlert,
                                                 urgentLowPredicted: TCGMSettingsDatumAlertsLevelAlertTests.levelAlert,
                                                 low: TCGMSettingsDatumAlertsLevelAlertTests.levelAlert,
                                                 lowPredicted: TCGMSettingsDatumAlertsLevelAlertTests.levelAlert,
                                                 high: TCGMSettingsDatumAlertsLevelAlertTests.levelAlert,
                                                 highPredicted: TCGMSettingsDatumAlertsLevelAlertTests.levelAlert,
                                                 fall: TCGMSettingsDatumAlertsRateAlertTests.rateAlert,
                                                 rise: TCGMSettingsDatumAlertsRateAlertTests.rateAlert,
                                                 noData: TCGMSettingsDatumAlertsDurationAlertTests.durationAlert,
                                                 outOfRange: TCGMSettingsDatumAlertsDurationAlertTests.durationAlert)
    static let alertsJSONDictionary: [String: Any] = [
        "enabled": true,
        "urgentLow": TCGMSettingsDatumAlertsLevelAlertTests.levelAlertJSONDictionary,
        "urgentLowPredicted": TCGMSettingsDatumAlertsLevelAlertTests.levelAlertJSONDictionary,
        "low": TCGMSettingsDatumAlertsLevelAlertTests.levelAlertJSONDictionary,
        "lowPredicted": TCGMSettingsDatumAlertsLevelAlertTests.levelAlertJSONDictionary,
        "high": TCGMSettingsDatumAlertsLevelAlertTests.levelAlertJSONDictionary,
        "highPredicted": TCGMSettingsDatumAlertsLevelAlertTests.levelAlertJSONDictionary,
        "fall": TCGMSettingsDatumAlertsRateAlertTests.rateAlertJSONDictionary,
        "rise": TCGMSettingsDatumAlertsRateAlertTests.rateAlertJSONDictionary,
        "noData": TCGMSettingsDatumAlertsDurationAlertTests.durationAlertJSONDictionary,
        "outOfRange": TCGMSettingsDatumAlertsDurationAlertTests.durationAlertJSONDictionary
    ]
    
    func testInitializer() {
        let alerts = TCGMSettingsDatumAlertsTests.alerts
        XCTAssertEqual(alerts.enabled, true)
        XCTAssertEqual(alerts.urgentLow, TCGMSettingsDatumAlertsLevelAlertTests.levelAlert)
        XCTAssertEqual(alerts.urgentLowPredicted, TCGMSettingsDatumAlertsLevelAlertTests.levelAlert)
        XCTAssertEqual(alerts.low, TCGMSettingsDatumAlertsLevelAlertTests.levelAlert)
        XCTAssertEqual(alerts.lowPredicted, TCGMSettingsDatumAlertsLevelAlertTests.levelAlert)
        XCTAssertEqual(alerts.high, TCGMSettingsDatumAlertsLevelAlertTests.levelAlert)
        XCTAssertEqual(alerts.highPredicted, TCGMSettingsDatumAlertsLevelAlertTests.levelAlert)
        XCTAssertEqual(alerts.fall, TCGMSettingsDatumAlertsRateAlertTests.rateAlert)
        XCTAssertEqual(alerts.rise, TCGMSettingsDatumAlertsRateAlertTests.rateAlert)
        XCTAssertEqual(alerts.noData, TCGMSettingsDatumAlertsDurationAlertTests.durationAlert)
        XCTAssertEqual(alerts.outOfRange, TCGMSettingsDatumAlertsDurationAlertTests.durationAlert)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TCGMSettingsDatumAlertsTests.alerts, TCGMSettingsDatumAlertsTests.alertsJSONDictionary)
    }
}

class TCGMSettingsDatumAlertsDurationAlertTests: XCTestCase {
    static let durationAlert = TCGMSettingsDatum.Alerts.DurationAlert(enabled: true,
                                                                      duration: 1.23,
                                                                      units: .minutes,
                                                                      snooze: TCGMSettingsDatumAlertsSnoozeTests.snooze)
    static let durationAlertJSONDictionary: [String: Any] = [
        "enabled": true,
        "duration": 1.23,
        "units": "minutes",
        "snooze": TCGMSettingsDatumAlertsSnoozeTests.snoozeJSONDictionary
    ]
    
    func testInitializer() {
        let durationAlert = TCGMSettingsDatumAlertsDurationAlertTests.durationAlert
        XCTAssertEqual(durationAlert.enabled, true)
        XCTAssertEqual(durationAlert.duration, 1.23)
        XCTAssertEqual(durationAlert.units, .minutes)
        XCTAssertEqual(durationAlert.snooze, TCGMSettingsDatumAlertsSnoozeTests.snooze)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TCGMSettingsDatumAlertsDurationAlertTests.durationAlert, TCGMSettingsDatumAlertsDurationAlertTests.durationAlertJSONDictionary)
    }
}

class TCGMSettingsDatumAlertsDurationAlertUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TCGMSettingsDatum.Alerts.DurationAlert.Units.hours.rawValue, "hours")
        XCTAssertEqual(TCGMSettingsDatum.Alerts.DurationAlert.Units.minutes.rawValue, "minutes")
        XCTAssertEqual(TCGMSettingsDatum.Alerts.DurationAlert.Units.seconds.rawValue, "seconds")
    }
}

class TCGMSettingsDatumAlertsLevelAlertTests: XCTestCase {
    static let levelAlert = TCGMSettingsDatum.Alerts.LevelAlert(enabled: true,
                                                                level: 1.23,
                                                                units: .milligramsPerDeciliter,
                                                                snooze: TCGMSettingsDatumAlertsSnoozeTests.snooze)
    static let levelAlertJSONDictionary: [String: Any] = [
        "enabled": true,
        "level": 1.23,
        "units": "mg/dL",
        "snooze": TCGMSettingsDatumAlertsSnoozeTests.snoozeJSONDictionary
    ]
    
    func testInitializer() {
        let levelAlert = TCGMSettingsDatumAlertsLevelAlertTests.levelAlert
        XCTAssertEqual(levelAlert.enabled, true)
        XCTAssertEqual(levelAlert.level, 1.23)
        XCTAssertEqual(levelAlert.units, .milligramsPerDeciliter)
        XCTAssertEqual(levelAlert.snooze, TCGMSettingsDatumAlertsSnoozeTests.snooze)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TCGMSettingsDatumAlertsLevelAlertTests.levelAlert, TCGMSettingsDatumAlertsLevelAlertTests.levelAlertJSONDictionary)
    }
}

class TCGMSettingsDatumAlertsRateAlertTests: XCTestCase {
    static let rateAlert = TCGMSettingsDatum.Alerts.RateAlert(enabled: true,
                                                              rate: 1.23,
                                                              units: .milligramsPerDeciliterPerMinute,
                                                              snooze: TCGMSettingsDatumAlertsSnoozeTests.snooze)
    static let rateAlertJSONDictionary: [String: Any] = [
        "enabled": true,
        "rate": 1.23,
        "units": "mg/dL/minute",
        "snooze": TCGMSettingsDatumAlertsSnoozeTests.snoozeJSONDictionary
    ]
    
    func testInitializer() {
        let rateAlert = TCGMSettingsDatumAlertsRateAlertTests.rateAlert
        XCTAssertEqual(rateAlert.enabled, true)
        XCTAssertEqual(rateAlert.rate, 1.23)
        XCTAssertEqual(rateAlert.units, .milligramsPerDeciliterPerMinute)
        XCTAssertEqual(rateAlert.snooze, TCGMSettingsDatumAlertsSnoozeTests.snooze)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TCGMSettingsDatumAlertsRateAlertTests.rateAlert, TCGMSettingsDatumAlertsRateAlertTests.rateAlertJSONDictionary)
    }
}

class TCGMSettingsDatumAlertsRateAlertUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TCGMSettingsDatum.Alerts.RateAlert.Units.milligramsPerDeciliterPerMinute.rawValue, "mg/dL/minute")
        XCTAssertEqual(TCGMSettingsDatum.Alerts.RateAlert.Units.millimolesPerLiterPerMinute.rawValue, "mmol/L/minute")
    }
}

class TCGMSettingsDatumAlertsSnoozeTests: XCTestCase {
    static let snooze = TCGMSettingsDatum.Alerts.Snooze(1.23, .minutes)
    static let snoozeJSONDictionary: [String: Any] = [
        "duration": 1.23,
        "units": "minutes"
    ]
    
    func testInitializer() {
        let snooze = TCGMSettingsDatumAlertsSnoozeTests.snooze
        XCTAssertEqual(snooze.duration, 1.23)
        XCTAssertEqual(snooze.units, .minutes)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TCGMSettingsDatumAlertsSnoozeTests.snooze, TCGMSettingsDatumAlertsSnoozeTests.snoozeJSONDictionary)
    }
}

class TCGMSettingsDatumAlertsSnoozeUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TCGMSettingsDatum.Alerts.Snooze.Units.hours.rawValue, "hours")
        XCTAssertEqual(TCGMSettingsDatum.Alerts.Snooze.Units.minutes.rawValue, "minutes")
        XCTAssertEqual(TCGMSettingsDatum.Alerts.Snooze.Units.seconds.rawValue, "seconds")
    }
}

class TCGMSettingsDatumScheduledAlertTests: XCTestCase {
    static let scheduledAlert = TCGMSettingsDatum.ScheduledAlert(name: "Test", days: ["sunday", "monday"], start: 123.456, end: 234.567, alerts: TCGMSettingsDatumAlertsTests.alerts)
    static let scheduledAlertJSONDictionary: [String: Any] = [
        "name": "Test",
        "days": ["sunday", "monday"],
        "start": 123456,
        "end": 234567,
        "alerts": TCGMSettingsDatumAlertsTests.alertsJSONDictionary
    ]
    
    func testInitializer() {
        let scheduledAlert = TCGMSettingsDatumScheduledAlertTests.scheduledAlert
        XCTAssertEqual(scheduledAlert.name, "Test")
        XCTAssertEqual(scheduledAlert.days, ["sunday", "monday"])
        XCTAssertEqual(scheduledAlert.start, 123.456)
        XCTAssertEqual(scheduledAlert.end, 234.567)
        XCTAssertEqual(scheduledAlert.alerts, TCGMSettingsDatumAlertsTests.alerts)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TCGMSettingsDatumScheduledAlertTests.scheduledAlert, TCGMSettingsDatumScheduledAlertTests.scheduledAlertJSONDictionary)
    }
}

extension TCGMSettingsDatum {
    func isEqual(to other: TCGMSettingsDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.firmwareVersion == other.firmwareVersion &&
            self.hardwareVersion == other.hardwareVersion &&
            self.manufacturers == other.manufacturers &&
            self.model == other.model &&
            self.name == other.name &&
            self.serialNumber == other.serialNumber &&
            self.softwareVersion == other.softwareVersion &&
            self.transmitterId == other.transmitterId &&
            self.units == other.units &&
            self.defaultAlerts == other.defaultAlerts &&
            self.scheduledAlerts == other.scheduledAlerts &&
            self.highAlertsDEPRECATED == other.highAlertsDEPRECATED &&
            self.lowAlertsDEPRECATED == other.lowAlertsDEPRECATED &&
            self.outOfRangeAlertsDEPRECATED == other.outOfRangeAlertsDEPRECATED &&
            self.rateOfChangeAlertsDEPRECATED == other.rateOfChangeAlertsDEPRECATED
    }
}
