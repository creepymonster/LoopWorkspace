//
//  TPumpSettingsOverrideDeviceEventDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 10/28/21.
//  Copyright © 2021 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TPumpSettingsOverrideDeviceEventDatumTests: XCTestCase {
    static let pumpSettingsOverrideDeviceEvent = TPumpSettingsOverrideDeviceEventDatum(time: Date.test,
                                                                                       overrideType: .preset,
                                                                                       overridePreset: "Preset Override",
                                                                                       method: .manual,
                                                                                       duration: .minutes(40),
                                                                                       expectedDuration: .minutes(45),
                                                                                       bloodGlucoseTarget: TBloodGlucoseTargetTests.target,
                                                                                       basalRateScaleFactor: 1.2,
                                                                                       carbohydrateRatioScaleFactor: 0.83333333,
                                                                                       insulinSensitivityScaleFactor: 0.83333333,
                                                                                       units: TPumpSettingsOverrideDeviceEventDatumUnitsTests.units)
    static let pumpSettingsOverrideDeviceEventJSONDictionary: [String: Any] = [
        "type": "deviceEvent",
        "subType": "pumpSettingsOverride",
        "time": Date.testJSONString,
        "overrideType": "preset",
        "overridePreset": "Preset Override",
        "method": "manual",
        "duration": 2400.0,
        "expectedDuration": 2700.0,
        "bgTarget": TBloodGlucoseTargetTests.targetJSONDictionary,
        "basalRateScaleFactor": 1.2,
        "carbRatioScaleFactor": 0.83333333,
        "insulinSensitivityScaleFactor": 0.83333333,
        "units": TPumpSettingsOverrideDeviceEventDatumUnitsTests.unitsJSONDictionary
    ]

    func testInitializer() {
        let pumpSettingsOverrideDeviceEvent = TPumpSettingsOverrideDeviceEventDatumTests.pumpSettingsOverrideDeviceEvent
        XCTAssertEqual(pumpSettingsOverrideDeviceEvent.overrideType, .preset)
        XCTAssertEqual(pumpSettingsOverrideDeviceEvent.overridePreset, "Preset Override")
        XCTAssertEqual(pumpSettingsOverrideDeviceEvent.method, .manual)
        XCTAssertEqual(pumpSettingsOverrideDeviceEvent.duration, .minutes(40))
        XCTAssertEqual(pumpSettingsOverrideDeviceEvent.expectedDuration, .minutes(45))
        XCTAssertEqual(pumpSettingsOverrideDeviceEvent.bloodGlucoseTarget, TBloodGlucoseTargetTests.target)
        XCTAssertEqual(pumpSettingsOverrideDeviceEvent.basalRateScaleFactor, 1.2)
        XCTAssertEqual(pumpSettingsOverrideDeviceEvent.carbohydrateRatioScaleFactor, 0.83333333)
        XCTAssertEqual(pumpSettingsOverrideDeviceEvent.insulinSensitivityScaleFactor, 0.83333333)
        XCTAssertEqual(pumpSettingsOverrideDeviceEvent.units, TPumpSettingsOverrideDeviceEventDatumUnitsTests.units)
    }

    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpSettingsOverrideDeviceEventDatumTests.pumpSettingsOverrideDeviceEvent, TPumpSettingsOverrideDeviceEventDatumTests.pumpSettingsOverrideDeviceEventJSONDictionary)
    }
}

class TPumpSettingsOverrideDeviceEventDatumOverrideTypeTests: XCTestCase {
    func testTraining() {
        XCTAssertEqual(TPumpSettingsOverrideDeviceEventDatum.OverrideType.custom.rawValue, "custom")
        XCTAssertEqual(TPumpSettingsOverrideDeviceEventDatum.OverrideType.physicalActivity.rawValue, "physicalActivity")
        XCTAssertEqual(TPumpSettingsOverrideDeviceEventDatum.OverrideType.preprandial.rawValue, "preprandial")
        XCTAssertEqual(TPumpSettingsOverrideDeviceEventDatum.OverrideType.preset.rawValue, "preset")
        XCTAssertEqual(TPumpSettingsOverrideDeviceEventDatum.OverrideType.sleep.rawValue, "sleep")
    }
}

class TPumpSettingsOverrideDeviceEventDatumMethodTests: XCTestCase {
    func testTraining() {
        XCTAssertEqual(TPumpSettingsOverrideDeviceEventDatum.Method.automatic.rawValue, "automatic")
        XCTAssertEqual(TPumpSettingsOverrideDeviceEventDatum.Method.manual.rawValue, "manual")
    }
}

class TPumpSettingsOverrideDeviceEventDatumUnitsTests: XCTestCase {
    static let units = TPumpSettingsOverrideDeviceEventDatum.Units(bloodGlucose: .milligramsPerDeciliter)
    static let unitsJSONDictionary: [String: Any] = [
        "bg": "mg/dL"
    ]

    func testInitializer() {
        let units = TPumpSettingsOverrideDeviceEventDatumUnitsTests.units
        XCTAssertEqual(units.bloodGlucose, .milligramsPerDeciliter)
    }

    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpSettingsOverrideDeviceEventDatumUnitsTests.units, TPumpSettingsOverrideDeviceEventDatumUnitsTests.unitsJSONDictionary)
    }
}

extension TPumpSettingsOverrideDeviceEventDatum {
    func isEqual(to other: TPumpSettingsOverrideDeviceEventDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.overrideType == other.overrideType &&
            self.overridePreset == other.overridePreset &&
            self.method == other.method &&
            self.duration == other.duration &&
            self.expectedDuration == other.expectedDuration &&
            self.bloodGlucoseTarget == other.bloodGlucoseTarget &&
            self.basalRateScaleFactor == other.basalRateScaleFactor &&
            self.carbohydrateRatioScaleFactor == other.carbohydrateRatioScaleFactor &&
            self.insulinSensitivityScaleFactor == other.insulinSensitivityScaleFactor &&
            self.units == other.units
    }
}
