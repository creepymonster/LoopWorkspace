//
//  Sample.swift
//  TidepoolKit Example
//
//  Created by Darin Krauss on 3/4/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import Foundation
import TidepoolKit

struct Sample {
    struct Datum {
        static func data(fullyAdorned: Bool = true) -> [TDatum] {
            var data: [TDatum] = [
                TAlertDatum(time: Date(),
                            name: "Alert One"),
                TAutomatedBasalDatum(time: Date(),
                                     duration: 300000,
                                     expectedDuration: 600000,
                                     rate: 1.25,
                                     scheduleName: "Auto",
                                     insulinFormulation: insulinFormulation),
                TScheduledBasalDatum(time: Date(),
                                     duration: 150000,
                                     expectedDuration: 300000,
                                     rate: 1.0,
                                     scheduleName: "Schedule",
                                     insulinFormulation: insulinFormulation),
                TSuspendedBasalDatum(time: Date(),
                                     duration: 100000,
                                     expectedDuration: 200000,
                                     suppressed: temporaryBasalSuppressed),
                TTemporaryBasalDatum(time: Date(),
                                     duration: 50000,
                                     expectedDuration: 100000,
                                     rate: 1.5,
                                     percent: 1.5,
                                     insulinFormulation: insulinFormulation,
                                     suppressed: scheduledBasalSuppressed),
                TBloodKetoneDatum(time: Date(),
                                  value: 3.1),
                TCombinationBolusDatum(time: Date(),
                                       normal: 1.0,
                                       expectedNormal: 2.0,
                                       extended: 0.0,
                                       expectedExtended: 3.0,
                                       duration: .minutes(0),
                                       expectedDuration: .minutes(30)),
                TExtendedBolusDatum(time: Date(),
                                    extended: 1.0,
                                    expectedExtended: 3.0,
                                    duration: .minutes(10),
                                    expectedDuration: .minutes(30)),
                TNormalBolusDatum(time: Date(),
                                  normal: 1.25,
                                  expectedNormal: 2.5),
                TCalculatorDatum(time: Date(),
                                 insulinOnBoard: 1.75,
                                 bloodGlucoseInput: 155,
                                 insulinSensitivity: 45,
                                 carbohydrateInput: 30,
                                 insulinCarbohydrateRatio: 15,
                                 bloodGlucoseTarget: TCalculatorDatum.BloodGlucoseTarget(low: 100, high: 110),
                                 recommended: TCalculatorDatum.Recommended(net: 1.25, carbohydrate: 2.0, correction: 1.0),
                                 bolus: TNormalBolusDatum(time: Date(),normal: 1.25),
                                 units: .milligramsPerDeciliter),
                TCBGDatum(time: Date(),
                          value: 123,
                          units: .milligramsPerDeciliter),
                TCGMSettingsDatum(time: Date(),
                                  manufacturers: ["Acme Pump Company", "Acme CGM Company"],
                                  model: "Super Deluxe",
                                  name: "My CGM",
                                  serialNumber: "999666333",
                                  transmitterId: "A1B2C3",
                                  units: .milligramsPerDeciliter,
                                  defaultAlerts: cgmSettingsAlerts,
                                  scheduledAlerts: [TCGMSettingsDatum.ScheduledAlert(name: "Default",
                                                                                     days: ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"],
                                                                                     start: 0,
                                                                                     end: 64800000,
                                                                                     alerts: cgmSettingsAlerts),
                                                    TCGMSettingsDatum.ScheduledAlert(name: "Mondays",
                                                                                     days: ["monday"],
                                                                                     start: 0,
                                                                                     end: 64800000,
                                                                                     alerts: cgmSettingsAlerts)]),
                TControllerSettingsDatum(time: Date(),
                                         device: TControllerSettingsDatum.Device(manufacturers: ["Acme Controller Company"],
                                                                                 model: "Nifty Controller",
                                                                                 name: "My Controller",
                                                                                 softwareVersion: "1.2.3"),
                                         notifications: TControllerSettingsDatum.Notifications(authorization: .authorized,
                                                                                               alert: true,
                                                                                               criticalAlert: true)),
                TControllerStatusDatum(time: Date(),
                                       battery: TControllerStatusDatum.Battery(state: .charging,
                                                                               remaining: 0.72,
                                                                               units: .percent)),
                TAlarmDeviceEventDatum(time: Date(),
                                       alarmType: .noDelivery,
                                       status: statusDeviceEventDatum),
                TCalibrationDeviceEventDatum(time: Date(),
                                             value: 167,
                                             units: .milligramsPerDeciliter),
                TPrimeDeviceEventDatum(time: Date(),
                                       volume: 0.25,
                                       target: .cannula),
                TPumpSettingsOverrideDeviceEventDatum(time: Date(),
                                                      overrideType: .preset,
                                                      overridePreset: "Running"),
                TReservoirChangeDeviceEventDatum(time: Date(),
                                                 status: statusDeviceEventDatum),
                TStatusDeviceEventDatum(time: Date(),
                                        name: .resumed,
                                        duration: .seconds(500),
                                        expectedDuration: .seconds(1000),
                                        reason: TDictionary(["five": 5])),
                TTimeChangeDeviceEventDatum(time: Date(),
                                            from: TTimeChangeDeviceEventDatum.Info(timeZoneName: "America/Los_Angeles"),
                                            to: TTimeChangeDeviceEventDatum.Info(timeZoneName: "America/New_York"),
                                            method: .automatic),
                TDosingDecisionDatum(time: Date(),
                                     reason: "bolus",
                                     carbohydratesOnBoard: TDosingDecisionDatum.CarbohydratesOnBoard(time: Date(), amount: 2.34),
                                     insulinOnBoard: TDosingDecisionDatum.InsulinOnBoard(time: Date(), amount: -1.23),
                                     bloodGlucoseTargetSchedule: [TBloodGlucose.StartTarget(start: .hours(0), low: 100, high: 110),
                                                                  TBloodGlucose.StartTarget(start: .hours(12), low: 110, high: 120)],
                                     historicalBloodGlucose: [TDosingDecisionDatum.BloodGlucose(time: Date(timeIntervalSinceNow: -.minutes(10)), value: 121.2),
                                                              TDosingDecisionDatum.BloodGlucose(time: Date(timeIntervalSinceNow: -.minutes(5)), value: 122.3),
                                                              TDosingDecisionDatum.BloodGlucose(time: Date(), value: 123.4)],
                                     forecastBloodGlucose: [TDosingDecisionDatum.BloodGlucose(time: Date(timeIntervalSinceNow: .minutes(5)), value: 124.5),
                                                            TDosingDecisionDatum.BloodGlucose(time: Date(timeIntervalSinceNow: .minutes(10)), value: 125.6),
                                                            TDosingDecisionDatum.BloodGlucose(time: Date(timeIntervalSinceNow: .minutes(15)), value: 126.7)],
                                     recommendedBasal: TDosingDecisionDatum.RecommendedBasal(rate: 0.12, duration: .minutes(30)),
                                     recommendedBolus: TDosingDecisionDatum.RecommendedBolus(amount: 3.45),
                                     requestedBolus: TDosingDecisionDatum.RequestedBolus(amount: 2.5),
                                     units: TDosingDecisionDatum.Units(bloodGlucose: .milligramsPerDeciliter, carbohydrate: .grams, insulin: .units)),
                TFoodDatum(time: Date(),
                           name: "Darn Good Snack",
                           amount: TFoodDatum.Amount(1.0, "cups"),
                           brand: "Acme Foods",
                           code: "1234567890",
                           meal: .other,
                           mealOther: "midnight snack",
                           nutrition: foodNutrition,
                           ingredients: [foodIngredient, foodIngredient]),
                TInsulinDatum(time: Date(),
                              dose: TInsulinDatum.Dose(active: 1.23,
                                                       correction: 2.34,
                                                       food: 3.45,
                                                       total: 4.56),
                              formulation: insulinFormulation,
                              site: "Forehead"),
                TPhysicalActivityDatum(time: Date(),
                                       name: "Exercise",
                                       aggregate: true,
                                       activityType: .other,
                                       activityTypeOther: "extremeSports",
                                       duration: TPhysicalActivityDatum.Duration(1.2, .hours),
                                       distance: TPhysicalActivityDatum.Distance(5.0, .kilometers),
                                       elevationChange: TPhysicalActivityDatum.ElevationChange(500, .meters),
                                       flight: TPhysicalActivityDatum.Flight(count: 160),
                                       lap: TPhysicalActivityDatum.Lap(1, TPhysicalActivityDatum.Distance(5.0, .kilometers)),
                                       step: TPhysicalActivityDatum.Step(count: 12345),
                                       reportedIntensity: .high,
                                       energy: TPhysicalActivityDatum.Energy(800, .kilocalories)),
                TPumpSettingsDatum(time: Date(),
                                   activeScheduleName: "Default",
                                   automatedDelivery: true,
                                   basal: TPumpSettingsDatum.Basal(rateMaximum: TPumpSettingsDatum.Basal.RateMaximum(3),
                                                                   temporary: TPumpSettingsDatum.Basal.Temporary(.unitsPerHour)),
                                   basalRateSchedules: ["Default": [TPumpSettingsDatum.BasalRateStart(start: .hours(0), rate: 1.0),
                                                                    TPumpSettingsDatum.BasalRateStart(start: .hours(12), rate: 1.5)]],
                                   bloodGlucoseSafetyLimit: 70,
                                   bloodGlucoseTargetPhysicalActivity: TBloodGlucose.Target(low: 150, high: 160),
                                   bloodGlucoseTargetPreprandial: TBloodGlucose.Target(low: 80, high: 90),
                                   bloodGlucoseTargetSchedules: ["Default": [TBloodGlucose.StartTarget(start: .hours(0), low: 100, high: 110),
                                                                             TBloodGlucose.StartTarget(start: .hours(12), low: 110, high: 120)]],
                                   bolus: TPumpSettingsDatum.Bolus(amountMaximum: TPumpSettingsDatum.Bolus.AmountMaximum(10),
                                                                   calculator: TPumpSettingsDatum.Bolus.Calculator(enabled: true,
                                                                                                                   insulin: TPumpSettingsDatum.Bolus.Calculator.Insulin(5, .hours)),
                                                                   extended: TPumpSettingsDatum.Bolus.Extended(enabled: true)),
                                   carbohydrateRatioSchedules: ["Default": [TPumpSettingsDatum.CarbohydrateRatioStart(start: .hours(0), amount: 15),
                                                                            TPumpSettingsDatum.CarbohydrateRatioStart(start: .hours(12), amount: 20)]],
                                   display: TPumpSettingsDatum.Display(bloodGlucose: TPumpSettingsDatum.Display.BloodGlucose(.milligramsPerDeciliter)),
                                   insulinModel: TPumpSettingsDatum.InsulinModel(modelType: .rapidAdult, actionDuration: .hours(6), actionPeakOffset: .hours(1)),
                                   insulinSensitivitySchedules: ["Default": [TPumpSettingsDatum.InsulinSensitivityStart(start: .hours(0), amount: 45),
                                                                             TPumpSettingsDatum.InsulinSensitivityStart(start: .hours(12), amount: 60)]],
                                   manufacturers: ["Acme Pump Company"],
                                   model: "Ultra Deluxe",
                                   name: "My Pump",
                                   scheduleTimeZoneOffset: -480,
                                   serialNumber: "a1b2c3d4e5",
                                   units: TPumpSettingsDatum.Units(bloodGlucose: .milligramsPerDeciliter, carbohydrate: .grams, insulin: .units)),
                TPumpStatusDatum(time: Date(),
                                 basalDelivery: TPumpStatusDatum.BasalDelivery(state: .temporary,
                                                                               dose: TPumpStatusDatum.BasalDelivery.Dose(startTime: Date(),
                                                                                                                         endTime: Date(),
                                                                                                                         rate: 2.34,
                                                                                                                         amountDelivered: 1.23)),
                                 battery: TPumpStatusDatum.Battery(time: Date(), remaining: 0.56),
                                 bolusDelivery: TPumpStatusDatum.BolusDelivery(state: .delivering,
                                                                               dose: TPumpStatusDatum.BolusDelivery.Dose(startTime: Date(),
                                                                                                                         amount: 4.56,
                                                                                                                         amountDelivered: 3.45)),
                                 reservoir: TPumpStatusDatum.Reservoir(time: Date(), remaining: 78.9)),
                TReportedStateDatum(time: Date(),
                                    states: [TReportedStateDatum.State(.alcohol, severity: 5),
                                             TReportedStateDatum.State(.other, stateOther: "confused")]),
                TSMBGDatum(time: Date(),
                           value: 10.3,
                           units: .millimolesPerLiter,
                           subType: .manual),
                TWaterDatum(time: Date(),
                            amount: TWaterDatum.Amount(1, .liters))
            ]
            
            if fullyAdorned {
                data = adorn(data: data, fullyAdorned: fullyAdorned)
            }
            return data
        }

        fileprivate static var scheduledBasalSuppressed: TScheduledBasalDatum.Suppressed {
            return TScheduledBasalDatum.Suppressed(rate: 1.0,
                                                   scheduleName: "Schedule",
                                                   insulinFormulation: insulinFormulation,
                                                   annotations: [TDictionary(["two": 2])])
        }
        
        fileprivate static var temporaryBasalSuppressed: TTemporaryBasalDatum.Suppressed {
            return TTemporaryBasalDatum.Suppressed(rate: 1.5,
                                                   percent: 1.5,
                                                   insulinFormulation: insulinFormulation,
                                                   annotations: [TDictionary(["one": 1])],
                                                   suppressed: scheduledBasalSuppressed)
        }
        
        fileprivate static var statusDeviceEventDatum: TStatusDeviceEventDatum {
            return TStatusDeviceEventDatum(time: Date(),
                                           name: .suspended,
                                           duration: .minutes(6),
                                           expectedDuration: .minutes(12),
                                           reason: TDictionary(["one": 1]))
        }

        fileprivate static var foodIngredient: TFoodDatum.Ingredient {
            return TFoodDatum.Ingredient(name: "Everything",
                                         amount: TFoodDatum.Amount(1.0, "cups"),
                                         brand: "Acme Foods",
                                         code: "1234567890",
                                         nutrition: foodNutrition,
                                         ingredients: [TFoodDatum.Ingredient(name: "ether"),
                                                       TFoodDatum.Ingredient(name: "air")])
        }

        fileprivate static var foodNutrition: TFoodDatum.Nutrition {
            return TFoodDatum.Nutrition(carbohydrate: TFoodDatum.Nutrition.Carbohydrate(net: 30, sugars: 10, dietaryFiber: 5, total: 35),
                                        fat: TFoodDatum.Nutrition.Fat(12),
                                        protein: TFoodDatum.Nutrition.Protein(8),
                                        energy: TFoodDatum.Nutrition.Energy(350, .kilocalories))
        }

        fileprivate static var insulinFormulation: TInsulinDatum.Formulation {
            return TInsulinDatum.Formulation(name: "My Formula",
                                             simple: TInsulinDatum.Formulation.Simple(actingType: .rapid,
                                                                                      brand: "Humalog",
                                                                                      concentration: TInsulinDatum.Formulation.Simple.Concentration(100, .unitsPerML)))
        }
        
        fileprivate static var cgmSettingsAlerts: TCGMSettingsDatum.Alerts {
            let snooze = TCGMSettingsDatum.Alerts.Snooze(30, .minutes)
            return TCGMSettingsDatum.Alerts(enabled: true,
                                            urgentLow: TCGMSettingsDatum.Alerts.LevelAlert(enabled: true, level: 55, units: .milligramsPerDeciliter, snooze: snooze),
                                            urgentLowPredicted: TCGMSettingsDatum.Alerts.LevelAlert(enabled: true, level: 55, units: .milligramsPerDeciliter, snooze: snooze),
                                            low: TCGMSettingsDatum.Alerts.LevelAlert(enabled: true, level: 70, units: .milligramsPerDeciliter, snooze: snooze),
                                            lowPredicted: TCGMSettingsDatum.Alerts.LevelAlert(enabled: true, level: 65, units: .milligramsPerDeciliter, snooze: snooze),
                                            high: TCGMSettingsDatum.Alerts.LevelAlert(enabled: true, level: 180, units: .milligramsPerDeciliter, snooze: snooze),
                                            highPredicted: TCGMSettingsDatum.Alerts.LevelAlert(enabled: true, level: 200, units: .milligramsPerDeciliter, snooze: snooze),
                                            fall: TCGMSettingsDatum.Alerts.RateAlert(enabled: true, rate: 3, units: .milligramsPerDeciliterPerMinute, snooze: snooze),
                                            rise: TCGMSettingsDatum.Alerts.RateAlert(enabled: true, rate: 3, units: .milligramsPerDeciliterPerMinute, snooze: snooze),
                                            noData: TCGMSettingsDatum.Alerts.DurationAlert(enabled: true, duration: 30, units: .minutes, snooze: snooze),
                                            outOfRange: TCGMSettingsDatum.Alerts.DurationAlert(enabled: true, duration: 1, units: .hours, snooze: snooze))
        }
        
        fileprivate static var location: TLocation {
            return TLocation(name: "Home",
                             gps: TLocation.GPS(latitude: TLocation.GPS.Latitude(37.773972),
                                                longitude: TLocation.GPS.Longitude(-122.431297),
                                                elevation: TLocation.GPS.Elevation(50, .meters),
                                                floor: 31,
                                                horizontalAccuracy: TLocation.GPS.Accuracy(10, .meters),
                                                verticalAccuracy: TLocation.GPS.Accuracy(5, .meters),
                                                origin: origin))
        }

        fileprivate static var origin: TOrigin {
            return TOrigin(id: UUID().uuidString,
                           name: "Phone",
                           version: "1.2.3",
                           type: .device,
                           time: Date(),
                           payload: TDictionary(["one": 1]))
        }

        fileprivate static var annotations: [TDictionary] {
            return [TDictionary(["alpha": 1, "beta": ["two"]]),
                    TDictionary(["charlie": ["id": "three"]])]
        }

        fileprivate static var associations: [TAssociation] {
            return [TAssociation(type: .datum, id: "12345678901234567890123456789012", reason: "Any reason will do"),
                    TAssociation(type: .url, url: "https://tidepool.org")]
        }

        fileprivate static var notes: [String] {
            return ["First Note", "Second Note"]
        }

        fileprivate static var payload: TDictionary {
            return TDictionary(["foo": "bar"])
        }

        fileprivate static var tags: [String] {
            return ["First Tag", "Second Tag"]
        }

        fileprivate static func adorn(data: [TDatum], fullyAdorned: Bool = true) -> [TDatum] {
            return data.map { adorn(datum: $0, fullyAdorned: fullyAdorned) }
        }

        fileprivate static func adorn(datum: TDatum, fullyAdorned: Bool = true) -> TDatum {
            if fullyAdorned {
                datum.annotations = annotations
                datum.associations = associations
                datum.clockDriftOffset = 123.456
                datum.conversionOffset = 2.345
                datum.deviceId = "my-device-id"
                datum.deviceTime = "1999-12-31T12:34:45"
                datum.location = location
                datum.notes = notes
                datum.origin = origin
                datum.payload = payload
                datum.tags = tags
                datum.timeZone = TimeZone(identifier: "America/Los_Angeles")!
                datum.timeZoneOffset = .minutes(-480)
            } else {
                datum.origin = TOrigin(id: UUID().uuidString,
                                       name: Bundle.main.bundleIdentifier,
                                       version: Bundle.main.semanticVersion,
                                       type: .application)
            }
            return datum
        }
    }
}
