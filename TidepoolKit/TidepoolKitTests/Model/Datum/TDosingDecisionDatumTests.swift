//
//  TDosingDecisionDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 3/6/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TDosingDecisionDatumTests: XCTestCase {
    static let dosingDecision = TDosingDecisionDatum(time: Date.test,
                                                     reason: "Test",
                                                     originalFood: TDosingDecisionDatumFoodTests.food,
                                                     food: TDosingDecisionDatumFoodTests.food,
                                                     selfMonitoredBloodGlucose: TDosingDecisionDatumBloodGlucoseTests.bloodGlucose,
                                                     carbohydratesOnBoard: TDosingDecisionDatumCarbohydratesOnBoardTests.carbohydratesOnBoard,
                                                     insulinOnBoard: TDosingDecisionDatumInsulinOnBoardTests.insulinOnBoard,
                                                     bloodGlucoseTargetSchedule: [TBloodGlucoseStartTargetTests.startTarget,
                                                                                  TBloodGlucoseStartTargetTests.startTarget],
                                                     historicalBloodGlucose: [TDosingDecisionDatumBloodGlucoseTests.bloodGlucose,
                                                                              TDosingDecisionDatumBloodGlucoseTests.bloodGlucose],
                                                     forecastBloodGlucose: [TDosingDecisionDatumBloodGlucoseTests.bloodGlucose,
                                                                            TDosingDecisionDatumBloodGlucoseTests.bloodGlucose,
                                                                            TDosingDecisionDatumBloodGlucoseTests.bloodGlucose],
                                                     recommendedBasal: TDosingDecisionDatumRecommendedBasalTests.recommendedBasal,
                                                     recommendedBolus: TDosingDecisionDatumRecommendedBolusTests.recommendedBolus,
                                                     requestedBolus: TDosingDecisionDatumRequestedBolusTests.requestedBolus,
                                                     warnings: [TDosingDecisionDatumIssueTests.issue,
                                                                TDosingDecisionDatumIssueTests.issue],
                                                     errors: [TDosingDecisionDatumIssueTests.issue,
                                                              TDosingDecisionDatumIssueTests.issue],
                                                     scheduleTimeZoneOffset: .hours(7),
                                                     units: TDosingDecisionDatumUnitsTests.units)
    static let dosingDecisionJSONDictionary: [String: Any] = [
        "type": "dosingDecision",
        "time": Date.testJSONString,
        "reason": "Test",
        "originalFood": TDosingDecisionDatumFoodTests.foodJSONDictionary,
        "food": TDosingDecisionDatumFoodTests.foodJSONDictionary,
        "smbg": TDosingDecisionDatumBloodGlucoseTests.bloodGlucoseJSONDictionary,
        "carbsOnBoard": TDosingDecisionDatumCarbohydratesOnBoardTests.carbohydratesOnBoardJSONDictionary,
        "insulinOnBoard": TDosingDecisionDatumInsulinOnBoardTests.insulinOnBoardJSONDictionary,
        "bgTargetSchedule": [TBloodGlucoseStartTargetTests.startTargetJSONDictionary,
                             TBloodGlucoseStartTargetTests.startTargetJSONDictionary],
        "bgHistorical": [TDosingDecisionDatumBloodGlucoseTests.bloodGlucoseJSONDictionary,
                         TDosingDecisionDatumBloodGlucoseTests.bloodGlucoseJSONDictionary],
        "bgForecast": [TDosingDecisionDatumBloodGlucoseTests.bloodGlucoseJSONDictionary,
                       TDosingDecisionDatumBloodGlucoseTests.bloodGlucoseJSONDictionary,
                       TDosingDecisionDatumBloodGlucoseTests.bloodGlucoseJSONDictionary],
        "recommendedBasal": TDosingDecisionDatumRecommendedBasalTests.recommendedBasalJSONDictionary,
        "recommendedBolus": TDosingDecisionDatumRecommendedBolusTests.recommendedBolusJSONDictionary,
        "requestedBolus": TDosingDecisionDatumRequestedBolusTests.requestedBolusJSONDictionary,
        "warnings": [TDosingDecisionDatumIssueTests.issueJSONDictionary,
                     TDosingDecisionDatumIssueTests.issueJSONDictionary],
        "errors": [TDosingDecisionDatumIssueTests.issueJSONDictionary,
                   TDosingDecisionDatumIssueTests.issueJSONDictionary],
        "scheduleTimeZoneOffset": 420,
        "units": TDosingDecisionDatumUnitsTests.unitsJSONDictionary
    ]
    
    func testInitializer() {
        let dosingDecision = TDosingDecisionDatumTests.dosingDecision
        XCTAssertEqual(dosingDecision.time, Date.test)
        XCTAssertEqual(dosingDecision.reason, "Test")
        XCTAssertEqual(dosingDecision.originalFood, TDosingDecisionDatumFoodTests.food)
        XCTAssertEqual(dosingDecision.food, TDosingDecisionDatumFoodTests.food)
        XCTAssertEqual(dosingDecision.selfMonitoredBloodGlucose, TDosingDecisionDatumBloodGlucoseTests.bloodGlucose)
        XCTAssertEqual(dosingDecision.carbohydratesOnBoard, TDosingDecisionDatumCarbohydratesOnBoardTests.carbohydratesOnBoard)
        XCTAssertEqual(dosingDecision.insulinOnBoard, TDosingDecisionDatumInsulinOnBoardTests.insulinOnBoard)
        XCTAssertEqual(dosingDecision.bloodGlucoseTargetSchedule, [TBloodGlucoseStartTargetTests.startTarget,
                                                                   TBloodGlucoseStartTargetTests.startTarget])
        XCTAssertEqual(dosingDecision.historicalBloodGlucose, [TDosingDecisionDatumBloodGlucoseTests.bloodGlucose,
                                                               TDosingDecisionDatumBloodGlucoseTests.bloodGlucose])
        XCTAssertEqual(dosingDecision.forecastBloodGlucose, [TDosingDecisionDatumBloodGlucoseTests.bloodGlucose,
                                                             TDosingDecisionDatumBloodGlucoseTests.bloodGlucose,
                                                             TDosingDecisionDatumBloodGlucoseTests.bloodGlucose])
        XCTAssertEqual(dosingDecision.recommendedBasal, TDosingDecisionDatumRecommendedBasalTests.recommendedBasal)
        XCTAssertEqual(dosingDecision.recommendedBolus, TDosingDecisionDatumRecommendedBolusTests.recommendedBolus)
        XCTAssertEqual(dosingDecision.requestedBolus, TDosingDecisionDatumRequestedBolusTests.requestedBolus)
        XCTAssertEqual(dosingDecision.warnings, [TDosingDecisionDatumIssueTests.issue,
                                                 TDosingDecisionDatumIssueTests.issue])
        XCTAssertEqual(dosingDecision.errors, [TDosingDecisionDatumIssueTests.issue,
                                               TDosingDecisionDatumIssueTests.issue])
        XCTAssertEqual(dosingDecision.scheduleTimeZoneOffset, .hours(7))
        XCTAssertEqual(dosingDecision.units, TDosingDecisionDatumUnitsTests.units)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TDosingDecisionDatumTests.dosingDecision, TDosingDecisionDatumTests.dosingDecisionJSONDictionary)
    }
}

class TDosingDecisionDatumFoodTests: XCTestCase {
    static let food = TDosingDecisionDatum.Food(time: Date.test,
                                                nutrition: TFoodDatumNutritionTests.nutrition)
    static let foodJSONDictionary: [String: Any] = [
        "time": Date.testJSONString,
        "nutrition": TFoodDatumNutritionTests.nutritionJSONDictionary,
    ]
    
    func testInitializer() {
        let food = TDosingDecisionDatumFoodTests.food
        XCTAssertEqual(food.time, Date.test)
        XCTAssertEqual(food.nutrition, TFoodDatumNutritionTests.nutrition)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TDosingDecisionDatumFoodTests.food, TDosingDecisionDatumFoodTests.foodJSONDictionary)
    }
}

class TDosingDecisionDatumBloodGlucoseTests: XCTestCase {
    static let bloodGlucose = TDosingDecisionDatum.BloodGlucose(time: Date.test,
                                                                value: 123)
    static let bloodGlucoseJSONDictionary: [String: Any] = [
        "time": Date.testJSONString,
        "value": 123,
    ]
    
    func testInitializer() {
        let bloodGlucose = TDosingDecisionDatumBloodGlucoseTests.bloodGlucose
        XCTAssertEqual(bloodGlucose.time, Date.test)
        XCTAssertEqual(bloodGlucose.value, 123)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TDosingDecisionDatumBloodGlucoseTests.bloodGlucose, TDosingDecisionDatumBloodGlucoseTests.bloodGlucoseJSONDictionary)
    }
}

class TDosingDecisionDatumCarbohydratesOnBoardTests: XCTestCase {
    static let carbohydratesOnBoard = TDosingDecisionDatum.CarbohydratesOnBoard(time: Date.test,
                                                                                amount: 1.23)
    static let carbohydratesOnBoardJSONDictionary: [String: Any] = [
        "time": Date.testJSONString,
        "amount": 1.23,
    ]
    
    func testInitializer() {
        let carbohydratesOnBoard = TDosingDecisionDatumCarbohydratesOnBoardTests.carbohydratesOnBoard
        XCTAssertEqual(carbohydratesOnBoard.time, Date.test)
        XCTAssertEqual(carbohydratesOnBoard.amount, 1.23)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TDosingDecisionDatumCarbohydratesOnBoardTests.carbohydratesOnBoard, TDosingDecisionDatumCarbohydratesOnBoardTests.carbohydratesOnBoardJSONDictionary)
    }
}

class TDosingDecisionDatumInsulinOnBoardTests: XCTestCase {
    static let insulinOnBoard = TDosingDecisionDatum.InsulinOnBoard(time: Date.test,
                                                                    amount: 1.23)
    static let insulinOnBoardJSONDictionary: [String: Any] = [
        "time": Date.testJSONString,
        "amount": 1.23,
    ]
    
    func testInitializer() {
        let insulinOnBoard = TDosingDecisionDatumInsulinOnBoardTests.insulinOnBoard
        XCTAssertEqual(insulinOnBoard.time, Date.test)
        XCTAssertEqual(insulinOnBoard.amount, 1.23)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TDosingDecisionDatumInsulinOnBoardTests.insulinOnBoard, TDosingDecisionDatumInsulinOnBoardTests.insulinOnBoardJSONDictionary)
    }
}

class TDosingDecisionDatumRecommendedBasalTests: XCTestCase {
    static let recommendedBasal = TDosingDecisionDatum.RecommendedBasal(rate: 1.23,
                                                                        duration: 1800)
    static let recommendedBasalJSONDictionary: [String: Any] = [
        "rate": 1.23,
        "duration": 1800000
    ]
    
    func testInitializer() {
        let recommendedBasal = TDosingDecisionDatumRecommendedBasalTests.recommendedBasal
        XCTAssertEqual(recommendedBasal.rate, 1.23)
        XCTAssertEqual(recommendedBasal.duration, 1800)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TDosingDecisionDatumRecommendedBasalTests.recommendedBasal, TDosingDecisionDatumRecommendedBasalTests.recommendedBasalJSONDictionary)
    }
}

class TDosingDecisionDatumRecommendedBolusTests: XCTestCase {
    static let recommendedBolus = TDosingDecisionDatum.RecommendedBolus(amount: 1.23)
    static let recommendedBolusJSONDictionary: [String: Any] = [
        "amount": 1.23
    ]
    
    func testInitializer() {
        let recommendedBolus = TDosingDecisionDatumRecommendedBolusTests.recommendedBolus
        XCTAssertEqual(recommendedBolus.amount, 1.23)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TDosingDecisionDatumRecommendedBolusTests.recommendedBolus, TDosingDecisionDatumRecommendedBolusTests.recommendedBolusJSONDictionary)
    }
}

class TDosingDecisionDatumRequestedBolusTests: XCTestCase {
    static let requestedBolus = TDosingDecisionDatum.RequestedBolus(amount: 1.23)
    static let requestedBolusJSONDictionary: [String: Any] = [
        "amount": 1.23
    ]
    
    func testInitializer() {
        let requestedBolus = TDosingDecisionDatumRequestedBolusTests.requestedBolus
        XCTAssertEqual(requestedBolus.amount, 1.23)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TDosingDecisionDatumRequestedBolusTests.requestedBolus, TDosingDecisionDatumRequestedBolusTests.requestedBolusJSONDictionary)
    }
}

class TDosingDecisionDatumIssueTests: XCTestCase {
    static let issue = TDosingDecisionDatum.Issue(id: "Test Issue",
                                                  metadata: TDictionary(["Alpha": "Bravo"]))
    static let issueJSONDictionary: [String: Any] = [
        "id": "Test Issue",
        "metadata": ["Alpha": "Bravo"]
    ]
    
    func testInitializer() {
        let issue = TDosingDecisionDatumIssueTests.issue
        XCTAssertEqual(issue.id, "Test Issue")
        XCTAssertEqual(issue.metadata, TDictionary(["Alpha": "Bravo"]))
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TDosingDecisionDatumIssueTests.issue, TDosingDecisionDatumIssueTests.issueJSONDictionary)
    }
}

class TDosingDecisionDatumUnitsTests: XCTestCase {
    static let units = TDosingDecisionDatum.Units(bloodGlucose: .milligramsPerDeciliter,
                                                  carbohydrate: .grams,
                                                  insulin: .units)
    static let unitsJSONDictionary: [String: Any] = [
        "bg": "mg/dL",
        "carb": "grams",
        "insulin": "Units"
    ]
    
    func testInitializer() {
        let units = TDosingDecisionDatumUnitsTests.units
        XCTAssertEqual(units.bloodGlucose, .milligramsPerDeciliter)
        XCTAssertEqual(units.carbohydrate, .grams)
        XCTAssertEqual(units.insulin, .units)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TDosingDecisionDatumUnitsTests.units, TDosingDecisionDatumUnitsTests.unitsJSONDictionary)
    }
}

extension TDosingDecisionDatum {
    func isEqual(to other: TDosingDecisionDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.reason == other.reason &&
            self.originalFood == other.originalFood &&
            self.food == other.food &&
            self.selfMonitoredBloodGlucose == other.selfMonitoredBloodGlucose &&
            self.carbohydratesOnBoard == other.carbohydratesOnBoard &&
            self.insulinOnBoard == other.insulinOnBoard &&
            self.bloodGlucoseTargetSchedule == other.bloodGlucoseTargetSchedule &&
            self.historicalBloodGlucose == other.historicalBloodGlucose &&
            self.forecastBloodGlucose == other.forecastBloodGlucose &&
            self.recommendedBasal == other.recommendedBasal &&
            self.recommendedBolus == other.recommendedBolus &&
            self.requestedBolus == other.requestedBolus &&
            self.warnings == other.warnings &&
            self.errors == other.errors &&
            self.scheduleTimeZoneOffset == other.scheduleTimeZoneOffset &&
            self.units == other.units
    }
}
