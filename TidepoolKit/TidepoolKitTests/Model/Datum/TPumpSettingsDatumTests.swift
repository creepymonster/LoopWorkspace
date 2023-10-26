//
//  TPumpSettingsDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/11/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TPumpSettingsDatumTests: XCTestCase {
    static let pumpSettings = TPumpSettingsDatum(
        time: Date.test,
        activeScheduleName: "Activated",
        automatedDelivery: true,
        basal: TPumpSettingsDatumBasalTests.basal,
        basalRateSchedule: [TPumpSettingsDatumBasalRateStartTests.basalRateStart, TPumpSettingsDatumBasalRateStartTests.basalRateStart],
        basalRateSchedules: [
            "zero": [],
            "one": [TPumpSettingsDatumBasalRateStartTests.basalRateStart],
            "two": [TPumpSettingsDatumBasalRateStartTests.basalRateStart, TPumpSettingsDatumBasalRateStartTests.basalRateStart]
        ],
        bloodGlucoseSafetyLimit: 123.45,
        bloodGlucoseTargetPhysicalActivity: TBloodGlucoseTargetTests.target,
        bloodGlucoseTargetPreprandial: TBloodGlucoseTargetTests.target,
        bloodGlucoseTargetSchedule: [TBloodGlucoseStartTargetTests.startTarget, TBloodGlucoseStartTargetTests.startTarget],
        bloodGlucoseTargetSchedules: [
            "zero": [],
            "one": [TBloodGlucoseStartTargetTests.startTarget],
            "two": [TBloodGlucoseStartTargetTests.startTarget, TBloodGlucoseStartTargetTests.startTarget]
        ],
        bolus: TPumpSettingsDatumBolusTests.bolus,
        carbohydrateRatioSchedule: [TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStart, TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStart],
        carbohydrateRatioSchedules: [
            "zero": [],
            "one": [TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStart],
            "two": [TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStart, TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStart]
        ],
        display: TPumpSettingsDatumDisplayTests.display,
        firmwareVersion: "1.2.3",
        hardwareVersion: "2.3.4",
        insulinFormulation: TInsulinDatumFormulationTests.formulation,
        insulinModel: TPumpSettingsDatumInsulinModelTests.insulinModel,
        insulinSensitivitySchedule: [TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStart, TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStart],
        insulinSensitivitySchedules: [
            "zero": [],
            "one": [TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStart],
            "two": [TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStart, TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStart]
        ],
        manufacturers: ["Alfa", "Romeo"],
        model: "Spider",
        name: "My Car",
        overridePresets: [
            "zero": TPumpSettingsDatumOverridePresetTests.overridePreset,
            "one": TPumpSettingsDatumOverridePresetTests.overridePreset
        ],
        scheduleTimeZoneOffset: -28800,
        serialNumber: "1234567890",
        softwareVersion: "3.4.5",
        units: TPumpSettingsDatumUnitsTests.units
    )
    static let pumpSettingsJSONDictionary: [String: Any] = [
        "type": "pumpSettings",
        "time": Date.testJSONString,
        "activeSchedule": "Activated",
        "automatedDelivery": true,
        "basal": TPumpSettingsDatumBasalTests.basalJSONDictionary,
        "basalSchedule": [TPumpSettingsDatumBasalRateStartTests.basalRateStartJSONDictionary, TPumpSettingsDatumBasalRateStartTests.basalRateStartJSONDictionary],
        "basalSchedules": [
            "zero": [],
            "one": [TPumpSettingsDatumBasalRateStartTests.basalRateStartJSONDictionary],
            "two": [TPumpSettingsDatumBasalRateStartTests.basalRateStartJSONDictionary, TPumpSettingsDatumBasalRateStartTests.basalRateStartJSONDictionary]
        ],
        "bgSafetyLimit": 123.45,
        "bgTargetPhysicalActivity": TBloodGlucoseTargetTests.targetJSONDictionary,
        "bgTargetPreprandial": TBloodGlucoseTargetTests.targetJSONDictionary,
        "bgTarget": [TBloodGlucoseStartTargetTests.startTargetJSONDictionary, TBloodGlucoseStartTargetTests.startTargetJSONDictionary],
        "bgTargets": [
            "zero": [],
            "one": [TBloodGlucoseStartTargetTests.startTargetJSONDictionary],
            "two": [TBloodGlucoseStartTargetTests.startTargetJSONDictionary, TBloodGlucoseStartTargetTests.startTargetJSONDictionary]
        ],
        "bolus": TPumpSettingsDatumBolusTests.bolusJSONDictionary,
        "carbRatio": [TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStartJSONDictionary, TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStartJSONDictionary],
        "carbRatios": [
            "zero": [],
            "one": [TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStartJSONDictionary],
            "two": [TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStartJSONDictionary, TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStartJSONDictionary]
        ],
        "display": TPumpSettingsDatumDisplayTests.displayJSONDictionary,
        "firmwareVersion": "1.2.3",
        "hardwareVersion": "2.3.4",
        "insulinFormulation": TInsulinDatumFormulationTests.formulationJSONDictionary,
        "insulinModel": TPumpSettingsDatumInsulinModelTests.insulinModelJSONDictionary,
        "insulinSensitivity": [TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStartJSONDictionary, TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStartJSONDictionary],
        "insulinSensitivities": [
            "zero": [],
            "one": [TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStartJSONDictionary],
            "two": [TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStartJSONDictionary, TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStartJSONDictionary]
        ],
        "manufacturers": ["Alfa", "Romeo"],
        "model": "Spider",
        "name": "My Car",
        "overridePresets": [
            "zero": TPumpSettingsDatumOverridePresetTests.overridePresetJSONDictionary,
            "one": TPumpSettingsDatumOverridePresetTests.overridePresetJSONDictionary
        ],
        "scheduleTimeZoneOffset": -480,
        "serialNumber": "1234567890",
        "softwareVersion": "3.4.5",
        "units": TPumpSettingsDatumUnitsTests.unitsJSONDictionary
    ]
    
    func testInitializer() {
        let pumpSettings = TPumpSettingsDatumTests.pumpSettings
        XCTAssertEqual(pumpSettings.activeScheduleName, "Activated")
        XCTAssertEqual(pumpSettings.automatedDelivery, true)
        XCTAssertEqual(pumpSettings.basal, TPumpSettingsDatumBasalTests.basal)
        XCTAssertEqual(pumpSettings.basalRateSchedule, [TPumpSettingsDatumBasalRateStartTests.basalRateStart, TPumpSettingsDatumBasalRateStartTests.basalRateStart])
        XCTAssertEqual(pumpSettings.basalRateSchedules, [
            "zero": [],
            "one": [TPumpSettingsDatumBasalRateStartTests.basalRateStart],
            "two": [TPumpSettingsDatumBasalRateStartTests.basalRateStart, TPumpSettingsDatumBasalRateStartTests.basalRateStart]
        ])
        XCTAssertEqual(pumpSettings.bloodGlucoseSafetyLimit, 123.45)
        XCTAssertEqual(pumpSettings.bloodGlucoseTargetPhysicalActivity, TBloodGlucoseTargetTests.target)
        XCTAssertEqual(pumpSettings.bloodGlucoseTargetPreprandial, TBloodGlucoseTargetTests.target)
        XCTAssertEqual(pumpSettings.bloodGlucoseTargetSchedule, [TBloodGlucoseStartTargetTests.startTarget, TBloodGlucoseStartTargetTests.startTarget])
        XCTAssertEqual(pumpSettings.bloodGlucoseTargetSchedules, [
            "zero": [],
            "one": [TBloodGlucoseStartTargetTests.startTarget],
            "two": [TBloodGlucoseStartTargetTests.startTarget, TBloodGlucoseStartTargetTests.startTarget]
        ])
        XCTAssertEqual(pumpSettings.bolus, TPumpSettingsDatumBolusTests.bolus)
        XCTAssertEqual(pumpSettings.carbohydrateRatioSchedule, [TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStart, TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStart])
        XCTAssertEqual(pumpSettings.carbohydrateRatioSchedules, [
            "zero": [],
            "one": [TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStart],
            "two": [TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStart, TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStart]
        ])
        XCTAssertEqual(pumpSettings.display, TPumpSettingsDatumDisplayTests.display)
        XCTAssertEqual(pumpSettings.firmwareVersion, "1.2.3")
        XCTAssertEqual(pumpSettings.hardwareVersion, "2.3.4")
        XCTAssertEqual(pumpSettings.insulinFormulation, TInsulinDatumFormulationTests.formulation)
        XCTAssertEqual(pumpSettings.insulinModel, TPumpSettingsDatumInsulinModelTests.insulinModel)
        XCTAssertEqual(pumpSettings.insulinSensitivitySchedule, [TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStart, TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStart])
        XCTAssertEqual(pumpSettings.insulinSensitivitySchedules, [
            "zero": [],
            "one": [TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStart],
            "two": [TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStart, TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStart]
        ])
        XCTAssertEqual(pumpSettings.manufacturers, ["Alfa", "Romeo"])
        XCTAssertEqual(pumpSettings.model, "Spider")
        XCTAssertEqual(pumpSettings.name, "My Car")
        XCTAssertEqual(pumpSettings.overridePresets, [
            "zero": TPumpSettingsDatumOverridePresetTests.overridePreset,
            "one": TPumpSettingsDatumOverridePresetTests.overridePreset
        ])
        XCTAssertEqual(pumpSettings.scheduleTimeZoneOffset, -28800)
        XCTAssertEqual(pumpSettings.serialNumber, "1234567890")
        XCTAssertEqual(pumpSettings.softwareVersion, "3.4.5")
        XCTAssertEqual(pumpSettings.units, TPumpSettingsDatumUnitsTests.units)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpSettingsDatumTests.pumpSettings, TPumpSettingsDatumTests.pumpSettingsJSONDictionary)
    }
}

class TPumpSettingsDatumBasalTests: XCTestCase {
    static let basal = TPumpSettingsDatum.Basal(
        rateMaximum: TPumpSettingsDatumBasalRateMaximumTests.rateMaximum,
        temporary: TPumpSettingsDatumBasalTemporaryTests.temporary
    )
    static let basalJSONDictionary: [String: Any] = [
        "rateMaximum": TPumpSettingsDatumBasalRateMaximumTests.rateMaximumJSONDictionary,
        "temporary": TPumpSettingsDatumBasalTemporaryTests.temporaryJSONDictionary
    ]
    
    func testInitializer() {
        let basal = TPumpSettingsDatumBasalTests.basal
        XCTAssertEqual(basal.rateMaximum, TPumpSettingsDatumBasalRateMaximumTests.rateMaximum)
        XCTAssertEqual(basal.temporary, TPumpSettingsDatumBasalTemporaryTests.temporary)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpSettingsDatumBasalTests.basal, TPumpSettingsDatumBasalTests.basalJSONDictionary)
    }
}

class TPumpSettingsDatumBasalRateMaximumTests: XCTestCase {
    static let rateMaximum = TPumpSettingsDatum.Basal.RateMaximum(1.23, .unitsPerHour)
    static let rateMaximumJSONDictionary: [String: Any] = [
        "value": 1.23,
        "units": "Units/hour"
    ]
    
    func testInitializer() {
        let rateMaximum = TPumpSettingsDatumBasalRateMaximumTests.rateMaximum
        XCTAssertEqual(rateMaximum.value, 1.23)
        XCTAssertEqual(rateMaximum.units, .unitsPerHour)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpSettingsDatumBasalRateMaximumTests.rateMaximum, TPumpSettingsDatumBasalRateMaximumTests.rateMaximumJSONDictionary)
    }
}

class TPumpSettingsDatumBasalRateMaximumUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TPumpSettingsDatum.Basal.RateMaximum.Units.unitsPerHour.rawValue, "Units/hour")
    }
}

class TPumpSettingsDatumBasalTemporaryTests: XCTestCase {
    static let temporary = TPumpSettingsDatum.Basal.Temporary(.unitsPerHour)
    static let temporaryJSONDictionary: [String: Any] = [
        "type": "Units/hour",
    ]
    
    func testInitializer() {
        let temporary = TPumpSettingsDatumBasalTemporaryTests.temporary
        XCTAssertEqual(temporary.type, .unitsPerHour)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpSettingsDatumBasalTemporaryTests.temporary, TPumpSettingsDatumBasalTemporaryTests.temporaryJSONDictionary)
    }
}

class TPumpSettingsDatumBasalTemporaryTemporaryTypeTests: XCTestCase {
    func testTemporaryType() {
        XCTAssertEqual(TPumpSettingsDatum.Basal.Temporary.TemporaryType.off.rawValue, "off")
        XCTAssertEqual(TPumpSettingsDatum.Basal.Temporary.TemporaryType.percent.rawValue, "percent")
        XCTAssertEqual(TPumpSettingsDatum.Basal.Temporary.TemporaryType.unitsPerHour.rawValue, "Units/hour")
    }
}

class TPumpSettingsDatumBasalRateStartTests: XCTestCase {
    static let basalRateStart = TPumpSettingsDatum.BasalRateStart(start: 12345.678, rate: 45.67)
    static let basalRateStartJSONDictionary: [String: Any] = [
        "start": 12345678,
        "rate": 45.67
    ]
    
    func testInitializer() {
        let basalRateStart = TPumpSettingsDatumBasalRateStartTests.basalRateStart
        XCTAssertEqual(basalRateStart.start, 12345.678)
        XCTAssertEqual(basalRateStart.rate, 45.67)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpSettingsDatumBasalRateStartTests.basalRateStart, TPumpSettingsDatumBasalRateStartTests.basalRateStartJSONDictionary)
    }
}

class TPumpSettingsDatumBolusTests: XCTestCase {
    static let bolus = TPumpSettingsDatum.Bolus(
        amountMaximum: TPumpSettingsDatumBolusAmountMaximumTests.amountMaximum,
        calculator: TPumpSettingsDatumBolusCalculatorTests.calculator,
        extended: TPumpSettingsDatumBolusExtendedTests.extended
    )
    static let bolusJSONDictionary: [String: Any] = [
        "amountMaximum": TPumpSettingsDatumBolusAmountMaximumTests.amountMaximumJSONDictionary,
        "calculator": TPumpSettingsDatumBolusCalculatorTests.calculatorJSONDictionary,
        "extended": TPumpSettingsDatumBolusExtendedTests.extendedJSONDictionary
    ]
    
    func testInitializer() {
        let bolus = TPumpSettingsDatumBolusTests.bolus
        XCTAssertEqual(bolus.amountMaximum, TPumpSettingsDatumBolusAmountMaximumTests.amountMaximum)
        XCTAssertEqual(bolus.calculator, TPumpSettingsDatumBolusCalculatorTests.calculator)
        XCTAssertEqual(bolus.extended, TPumpSettingsDatumBolusExtendedTests.extended)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpSettingsDatumBolusTests.bolus, TPumpSettingsDatumBolusTests.bolusJSONDictionary)
    }
}

class TPumpSettingsDatumBolusAmountMaximumTests: XCTestCase {
    static let amountMaximum = TPumpSettingsDatum.Bolus.AmountMaximum(1.23, .units)
    static let amountMaximumJSONDictionary: [String: Any] = [
        "value": 1.23,
        "units": "Units"
    ]
    
    func testInitializer() {
        let amountMaximum = TPumpSettingsDatumBolusAmountMaximumTests.amountMaximum
        XCTAssertEqual(amountMaximum.value, 1.23)
        XCTAssertEqual(amountMaximum.units, .units)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpSettingsDatumBolusAmountMaximumTests.amountMaximum, TPumpSettingsDatumBolusAmountMaximumTests.amountMaximumJSONDictionary)
    }
}

class TPumpSettingsDatumBolusCalculatorTests: XCTestCase {
    static let calculator = TPumpSettingsDatum.Bolus.Calculator(enabled: true, insulin: TPumpSettingsDatumBolusCalculatorInsulinTests.insulin)
    static let calculatorJSONDictionary: [String: Any] = [
        "enabled": true,
        "insulin": TPumpSettingsDatumBolusCalculatorInsulinTests.insulinJSONDictionary
    ]
    
    func testInitializer() {
        let calculator = TPumpSettingsDatumBolusCalculatorTests.calculator
        XCTAssertEqual(calculator.enabled, true)
        XCTAssertEqual(calculator.insulin, TPumpSettingsDatumBolusCalculatorInsulinTests.insulin)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpSettingsDatumBolusCalculatorTests.calculator, TPumpSettingsDatumBolusCalculatorTests.calculatorJSONDictionary)
    }
}

class TPumpSettingsDatumBolusCalculatorInsulinTests: XCTestCase {
    static let insulin = TPumpSettingsDatum.Bolus.Calculator.Insulin(1.23, .hours)
    static let insulinJSONDictionary: [String: Any] = [
        "duration": 1.23,
        "units": "hours"
    ]
    
    func testInitializer() {
        let insulin = TPumpSettingsDatumBolusCalculatorInsulinTests.insulin
        XCTAssertEqual(insulin.duration, 1.23)
        XCTAssertEqual(insulin.units, .hours)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpSettingsDatumBolusCalculatorInsulinTests.insulin, TPumpSettingsDatumBolusCalculatorInsulinTests.insulinJSONDictionary)
    }
}

class TPumpSettingsDatumBolusCalculatorInsulinUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TPumpSettingsDatum.Bolus.Calculator.Insulin.Units.hours.rawValue, "hours")
        XCTAssertEqual(TPumpSettingsDatum.Bolus.Calculator.Insulin.Units.minutes.rawValue, "minutes")
        XCTAssertEqual(TPumpSettingsDatum.Bolus.Calculator.Insulin.Units.seconds.rawValue, "seconds")
    }
}

class TPumpSettingsDatumBolusExtendedTests: XCTestCase {
    static let extended = TPumpSettingsDatum.Bolus.Extended(enabled: true)
    static let extendedJSONDictionary: [String: Any] = [
        "enabled": true,
    ]
    
    func testInitializer() {
        let extended = TPumpSettingsDatumBolusExtendedTests.extended
        XCTAssertEqual(extended.enabled, true)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpSettingsDatumBolusExtendedTests.extended, TPumpSettingsDatumBolusExtendedTests.extendedJSONDictionary)
    }
}

class TPumpSettingsDatumCarbohydrateRatioStartTests: XCTestCase {
    static let carbohydrateRatioStart = TPumpSettingsDatum.CarbohydrateRatioStart(start: 12345.678, amount: 45.67)
    static let carbohydrateRatioStartJSONDictionary: [String: Any] = [
        "start": 12345678,
        "amount": 45.67
    ]
    
    func testInitializer() {
        let carbohydrateRatioStart = TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStart
        XCTAssertEqual(carbohydrateRatioStart.start, 12345.678)
        XCTAssertEqual(carbohydrateRatioStart.amount, 45.67)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStart, TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStartJSONDictionary)
    }
}

class TPumpSettingsDatumDisplayTests: XCTestCase {
    static let display = TPumpSettingsDatum.Display(bloodGlucose: TPumpSettingsDatumDisplayBloodGlucoseTests.bloodGlucose)
    static let displayJSONDictionary: [String: Any] = [
        "bloodGlucose": TPumpSettingsDatumDisplayBloodGlucoseTests.bloodGlucoseJSONDictionary,
    ]
    
    func testInitializer() {
        let display = TPumpSettingsDatumDisplayTests.display
        XCTAssertEqual(display.bloodGlucose, TPumpSettingsDatumDisplayBloodGlucoseTests.bloodGlucose)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpSettingsDatumDisplayTests.display, TPumpSettingsDatumDisplayTests.displayJSONDictionary)
    }
}

class TPumpSettingsDatumDisplayBloodGlucoseTests: XCTestCase {
    static let bloodGlucose = TPumpSettingsDatum.Display.BloodGlucose(.milligramsPerDeciliter)
    static let bloodGlucoseJSONDictionary: [String: Any] = [
        "units": "mg/dL",
    ]
    
    func testInitializer() {
        let bloodGlucose = TPumpSettingsDatumDisplayBloodGlucoseTests.bloodGlucose
        XCTAssertEqual(bloodGlucose.units, .milligramsPerDeciliter)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpSettingsDatumDisplayBloodGlucoseTests.bloodGlucose, TPumpSettingsDatumDisplayBloodGlucoseTests.bloodGlucoseJSONDictionary)
    }
}

class TPumpSettingsDatumInsulinModelTests: XCTestCase {
    static let insulinModel = TPumpSettingsDatum.InsulinModel(modelType: .rapidAdult, actionDelay: .minutes(10), actionDuration: .hours(6), actionPeakOffset: .hours(1))
    static let insulinModelJSONDictionary: [String: Any] = [
        "modelType": "rapidAdult",
        "actionDelay": 600,
        "actionDuration": 21600,
        "actionPeakOffset": 3600
    ]

    func testInitializer() {
        let insulinModel = TPumpSettingsDatumInsulinModelTests.insulinModel
        XCTAssertEqual(insulinModel.modelType, .rapidAdult)
        XCTAssertEqual(insulinModel.actionDelay, .minutes(10))
        XCTAssertEqual(insulinModel.actionDuration, .hours(6))
        XCTAssertEqual(insulinModel.actionPeakOffset, .hours(1))
    }

    func testInitializerWithModelTypeOther() {
        let insulinModel = TPumpSettingsDatum.InsulinModel(modelType: .other, modelTypeOther: "whatever")
        XCTAssertEqual(insulinModel.modelType, .other)
        XCTAssertEqual(insulinModel.modelTypeOther, "whatever")
    }

    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpSettingsDatumInsulinModelTests.insulinModel, TPumpSettingsDatumInsulinModelTests.insulinModelJSONDictionary)
    }

    func testCodableAsJSONWithModelTypeOther() {
        let insulinModel = TPumpSettingsDatum.InsulinModel(modelType: .other, modelTypeOther: "whatever")
        let insulinModelJSONDictionary: [String: Any] = [
            "modelType": "other",
            "modelTypeOther": "whatever"
        ]
        XCTAssertCodableAsJSON(insulinModel, insulinModelJSONDictionary)
    }
}

class TPumpSettingsDatumInsulinModelModelTypeTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TPumpSettingsDatum.InsulinModel.ModelType.fiasp.rawValue, "fiasp")
        XCTAssertEqual(TPumpSettingsDatum.InsulinModel.ModelType.other.rawValue, "other")
        XCTAssertEqual(TPumpSettingsDatum.InsulinModel.ModelType.rapidAdult.rawValue, "rapidAdult")
        XCTAssertEqual(TPumpSettingsDatum.InsulinModel.ModelType.rapidChild.rawValue, "rapidChild")
        XCTAssertEqual(TPumpSettingsDatum.InsulinModel.ModelType.walsh.rawValue, "walsh")
    }
}

class TPumpSettingsDatumInsulinSensitivityStartTests: XCTestCase {
    static let insulinSensitivityStart = TPumpSettingsDatum.InsulinSensitivityStart(start: 12345.678, amount: 45.67)
    static let insulinSensitivityStartJSONDictionary: [String: Any] = [
        "start": 12345678,
        "amount": 45.67
    ]
    
    func testInitializer() {
        let insulinSensitivityStart = TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStart
        XCTAssertEqual(insulinSensitivityStart.start, 12345.678)
        XCTAssertEqual(insulinSensitivityStart.amount, 45.67)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStart, TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStartJSONDictionary)
    }
}

class TPumpSettingsDatumOverridePresetTests: XCTestCase {
    static let overridePreset = TPumpSettingsDatum.OverridePreset(abbreviation: "🏄",
                                                                  duration: .minutes(30),
                                                                  bloodGlucoseTarget: TBloodGlucoseTargetTests.target,
                                                                  basalRateScaleFactor: 1.2,
                                                                  carbohydrateRatioScaleFactor: 0.83333333,
                                                                  insulinSensitivityScaleFactor: 0.83333333)
    static let overridePresetJSONDictionary: [String: Any] = [
        "abbreviation": "🏄",
        "duration": 1800,
        "bgTarget": TBloodGlucoseTargetTests.targetJSONDictionary,
        "basalRateScaleFactor": 1.2,
        "carbRatioScaleFactor": 0.83333333,
        "insulinSensitivityScaleFactor": 0.83333333
    ]

    func testInitializer() {
        let overridePreset = TPumpSettingsDatumOverridePresetTests.overridePreset
        XCTAssertEqual(overridePreset.abbreviation, "🏄")
        XCTAssertEqual(overridePreset.duration, .minutes(30))
        XCTAssertEqual(overridePreset.bloodGlucoseTarget, TBloodGlucoseTargetTests.target)
        XCTAssertEqual(overridePreset.basalRateScaleFactor, 1.2)
        XCTAssertEqual(overridePreset.carbohydrateRatioScaleFactor, 0.83333333)
        XCTAssertEqual(overridePreset.insulinSensitivityScaleFactor, 0.83333333)
    }

    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpSettingsDatumOverridePresetTests.overridePreset, TPumpSettingsDatumOverridePresetTests.overridePresetJSONDictionary)
    }
}

class TPumpSettingsDatumUnitsTests: XCTestCase {
    static let units = TPumpSettingsDatum.Units(bloodGlucose: .milligramsPerDeciliter, carbohydrate: .grams, insulin: .units)
    static let unitsJSONDictionary: [String: Any] = [
        "bg": "mg/dL",
        "carb": "grams",
        "insulin": "Units"
    ]
    
    func testInitializer() {
        let units = TPumpSettingsDatumUnitsTests.units
        XCTAssertEqual(units.bloodGlucose, .milligramsPerDeciliter)
        XCTAssertEqual(units.carbohydrate, .grams)
        XCTAssertEqual(units.insulin, .units)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPumpSettingsDatumUnitsTests.units, TPumpSettingsDatumUnitsTests.unitsJSONDictionary)
    }
}

extension TPumpSettingsDatum {
    func isEqual(to other: TPumpSettingsDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.activeScheduleName == other.activeScheduleName &&
            self.automatedDelivery == other.automatedDelivery &&
            self.basal == other.basal &&
            self.basalRateSchedule == other.basalRateSchedule &&
            self.basalRateSchedules == other.basalRateSchedules &&
            self.bloodGlucoseSafetyLimit == other.bloodGlucoseSafetyLimit &&
            self.bloodGlucoseTargetPhysicalActivity == other.bloodGlucoseTargetPhysicalActivity &&
            self.bloodGlucoseTargetPreprandial == other.bloodGlucoseTargetPreprandial &&
            self.bloodGlucoseTargetSchedule == other.bloodGlucoseTargetSchedule &&
            self.bloodGlucoseTargetSchedules == other.bloodGlucoseTargetSchedules &&
            self.bolus == other.bolus &&
            self.carbohydrateRatioSchedule == other.carbohydrateRatioSchedule &&
            self.carbohydrateRatioSchedules == other.carbohydrateRatioSchedules &&
            self.display == other.display &&
            self.firmwareVersion == other.firmwareVersion &&
            self.hardwareVersion == other.hardwareVersion &&
            self.insulinFormulation == other.insulinFormulation &&
            self.insulinModel == other.insulinModel &&
            self.insulinSensitivitySchedule == other.insulinSensitivitySchedule &&
            self.insulinSensitivitySchedules == other.insulinSensitivitySchedules &&
            self.manufacturers == other.manufacturers &&
            self.model == other.model &&
            self.name == other.name &&
            self.overridePresets == other.overridePresets &&
            self.scheduleTimeZoneOffset == other.scheduleTimeZoneOffset &&
            self.serialNumber == other.serialNumber &&
            self.softwareVersion == other.softwareVersion &&
            self.units == other.units
    }
}
