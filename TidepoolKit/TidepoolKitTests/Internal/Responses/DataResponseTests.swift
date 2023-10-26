//
//  DataResponseTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 10/29/21.
//  Copyright © 2021 Tidepool Project. All rights reserved.
//

import XCTest
@testable import TidepoolKit

class DataResponseTests: XCTestCase {
    static let dataResponse = DataResponse(data: [TAlertDatumTests.alert,
                                                  TAutomatedBasalDatumTests.automatedBasal,
                                                  TScheduledBasalDatumTests.scheduledBasal,
                                                  TSuspendedBasalDatumTests.suspendedBasal,
                                                  TTemporaryBasalDatumTests.temporaryBasal,
                                                  TBloodKetoneDatumTests.bloodKetone,
                                                  TAutomatedBolusDatumTests.automatedBolus,
                                                  TCombinationBolusDatumTests.combinationBolus,
                                                  TExtendedBolusDatumTests.extendedBolus,
                                                  TNormalBolusDatumTests.normalBolus,
                                                  TCalculatorDatumTests.calculator,
                                                  TCBGDatumTests.cbg,
                                                  TCGMSettingsDatumTests.cgmSettings,
                                                  TControllerSettingsDatumTests.controllerSettings,
                                                  TControllerStatusDatumTests.controllerStatus,
                                                  TAlarmDeviceEventDatumTests.alarmDeviceEvent,
                                                  TCalibrationDeviceEventDatumTests.calibrationDeviceEvent,
                                                  TPrimeDeviceEventDatumTests.primeDeviceEvent,
                                                  TPumpSettingsOverrideDeviceEventDatumTests.pumpSettingsOverrideDeviceEvent,
                                                  TReservoirChangeDeviceEventDatumTests.reservoirChangeDeviceEvent,
                                                  TStatusDeviceEventDatumTests.statusDeviceEvent,
                                                  TTimeChangeDeviceEventDatumTests.timeChangeDeviceEvent,
                                                  TDosingDecisionDatumTests.dosingDecision,
                                                  TFoodDatumTests.food,
                                                  TInsulinDatumTests.insulin,
                                                  TPhysicalActivityDatumTests.physicalActivity,
                                                  TPumpSettingsDatumTests.pumpSettings,
                                                  TPumpStatusDatumTests.pumpStatus,
                                                  TReportedStateDatumTests.reportedState,
                                                  TSMBGDatumTests.smbg,
                                                  TWaterDatumTests.water])
    static let dataResponseJSONArray = [
        TAlertDatumTests.alertJSONDictionary,
        TAutomatedBasalDatumTests.automatedBasalJSONDictionary,
        TScheduledBasalDatumTests.scheduledBasalJSONDictionary,
        TSuspendedBasalDatumTests.suspendedBasalJSONDictionary,
        TTemporaryBasalDatumTests.temporaryBasalJSONDictionary,
        TBloodKetoneDatumTests.bloodKetoneJSONDictionary,
        TAutomatedBolusDatumTests.automatedBolusJSONDictionary,
        TCombinationBolusDatumTests.combinationBolusJSONDictionary,
        TExtendedBolusDatumTests.extendedBolusJSONDictionary,
        TNormalBolusDatumTests.normalBolusJSONDictionary,
        TCalculatorDatumTests.calculatorJSONDictionary,
        TCBGDatumTests.cbgJSONDictionary,
        TCGMSettingsDatumTests.cgmSettingsJSONDictionary,
        TControllerSettingsDatumTests.controllerSettingsJSONDictionary,
        TControllerStatusDatumTests.controllerStatusJSONDictionary,
        TAlarmDeviceEventDatumTests.alarmDeviceEventJSONDictionary,
        TCalibrationDeviceEventDatumTests.calibrationDeviceEventJSONDictionary,
        TPrimeDeviceEventDatumTests.primeDeviceEventJSONDictionary,
        TPumpSettingsOverrideDeviceEventDatumTests.pumpSettingsOverrideDeviceEventJSONDictionary,
        TReservoirChangeDeviceEventDatumTests.reservoirChangeDeviceEventJSONDictionary,
        TStatusDeviceEventDatumTests.statusDeviceEventJSONDictionary,
        TTimeChangeDeviceEventDatumTests.timeChangeDeviceEventJSONDictionary,
        TDosingDecisionDatumTests.dosingDecisionJSONDictionary,
        TFoodDatumTests.foodJSONDictionary,
        TInsulinDatumTests.insulinJSONDictionary,
        TPhysicalActivityDatumTests.physicalActivityJSONDictionary,
        TPumpSettingsDatumTests.pumpSettingsJSONDictionary,
        TPumpStatusDatumTests.pumpStatusJSONDictionary,
        TReportedStateDatumTests.reportedStateJSONDictionary,
        TSMBGDatumTests.smbgJSONDictionary,
        TWaterDatumTests.waterJSONDictionary
    ]
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(DataResponseTests.dataResponse, DataResponseTests.dataResponseJSONArray)
    }
}

extension DataResponse: Equatable {
    public static func ==(lhs: DataResponse, rhs: DataResponse) -> Bool {
        return lhs.data == rhs.data &&
            NSDictionary(dictionary: lhs.malformed).isEqual(to: rhs.malformed)
    }
}
