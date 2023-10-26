//
//  DataResponse.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 2/28/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

struct DataResponse: Codable {
    var data: [TDatum]
    var malformed: TAPI.MalformedResult

    init(data: [TDatum] = [], malformed: TAPI.MalformedResult = [:]) {
        self.data = data
        self.malformed = malformed
    }
    
    init(from decoder: Decoder) throws {
        self.init()
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            let superDecoder = try container.superDecoder()
            let superContainer = try superDecoder.container(keyedBy: CodingKeys.self)
            do {
                var datum: TDatum?
                let type = try superContainer.decode(TDatum.DatumType.self, forKey: .type)
                switch type {
                case .alert:
                    datum = try TAlertDatum(from: superDecoder)
                case .basal:
                    let deliveryType = try superContainer.decode(TBasalDatum.DeliveryType.self, forKey: .deliveryType)
                    switch deliveryType {
                    case .automated:
                        datum = try TAutomatedBasalDatum(from: superDecoder)
                    case .scheduled:
                        datum = try TScheduledBasalDatum(from: superDecoder)
                    case .suspended:
                        datum = try TSuspendedBasalDatum(from: superDecoder)
                    case .temporary:
                        datum = try TTemporaryBasalDatum(from: superDecoder)
                    }
                case .bloodKetone:
                    datum = try TBloodKetoneDatum(from: superDecoder)
                case .bolus:
                    let subType = try superContainer.decode(TBolusDatum.SubType.self, forKey: .subType)
                    switch subType {
                    case .automated:
                        datum = try TAutomatedBolusDatum(from: superDecoder)
                    case .combination:
                        datum = try TCombinationBolusDatum(from: superDecoder)
                    case .extended:
                        datum = try TExtendedBolusDatum(from: superDecoder)
                    case .normal:
                        datum = try TNormalBolusDatum(from: superDecoder)
                    }
                case .calculator:
                    datum = try TCalculatorDatum(from: superDecoder)
                case .cbg:
                    datum = try TCBGDatum(from: superDecoder)
                case .cgmSettings:
                    datum = try TCGMSettingsDatum(from: superDecoder)
                case .controllerSettings:
                    datum = try TControllerSettingsDatum(from: superDecoder)
                case .controllerStatus:
                    datum = try TControllerStatusDatum(from: superDecoder)
                case .deviceEvent:
                    let subType = try superContainer.decode(TDeviceEventDatum.SubType.self, forKey: .subType)
                    switch subType {
                    case .alarm:
                        datum = try TAlarmDeviceEventDatum(from: superDecoder)
                    case .calibration:
                        datum = try TCalibrationDeviceEventDatum(from: superDecoder)
                    case .prime:
                        datum = try TPrimeDeviceEventDatum(from: superDecoder)
                    case .pumpSettingsOverride:
                        datum = try TPumpSettingsOverrideDeviceEventDatum(from: superDecoder)
                    case .reservoirChange:
                        datum = try TReservoirChangeDeviceEventDatum(from: superDecoder)
                    case .status:
                        datum = try TStatusDeviceEventDatum(from: superDecoder)
                    case .timeChange:
                        datum = try TTimeChangeDeviceEventDatum(from: superDecoder)
                    }
                case .dosingDecision:
                    datum = try TDosingDecisionDatum(from: superDecoder)
                case .food:
                    datum = try TFoodDatum(from: superDecoder)
                case .insulin:
                    datum = try TInsulinDatum(from: superDecoder)
                case .physicalActivity:
                    datum = try TPhysicalActivityDatum(from: superDecoder)
                case .pumpSettings:
                    datum = try TPumpSettingsDatum(from: superDecoder)
                case .pumpStatus:
                    datum = try TPumpStatusDatum(from: superDecoder)
                case .reportedState:
                    datum = try TReportedStateDatum(from: superDecoder)
                case .smbg:
                    datum = try TSMBGDatum(from: superDecoder)
                case .water:
                    datum = try TWaterDatum(from: superDecoder)
                default:
                    break // DEPRECATED: Ignore
                }
                if let datum = datum {
                    data.append(datum)
                }
            } catch {
                let malformedContainer = try superDecoder.container(keyedBy: JSONCodingKeys.self)
                malformed[String(container.currentIndex)] = try malformedContainer.decode([String: Any].self)
            }
        }
    }

    func encode(to encoder: Encoder) throws {
        try data.encode(to: encoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case type
        case subType
        case deliveryType
    }
}
