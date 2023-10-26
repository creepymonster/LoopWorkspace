//
//  TPhysicalActivityDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/8/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TPhysicalActivityDatumTests: XCTestCase {
    static let physicalActivity = TPhysicalActivityDatum(time: Date.test,
                                                         name: "Walk to the Moon",
                                                         aggregate: true,
                                                         activityType: .other,
                                                         activityTypeOther: "Moonwalk",
                                                         duration: TPhysicalActivityDatumDurationTests.duration,
                                                         distance: TPhysicalActivityDatumDistanceTests.distance,
                                                         elevationChange: TPhysicalActivityDatumElevationChangeTests.elevationChange,
                                                         flight: TPhysicalActivityDatumFlightTests.flight,
                                                         lap: TPhysicalActivityDatumLapTests.lap,
                                                         step: TPhysicalActivityDatumStepTests.step,
                                                         reportedIntensity: .high,
                                                         energy: TPhysicalActivityDatumEnergyTests.energy)
    static let physicalActivityJSONDictionary: [String: Any] = [
        "type": "physicalActivity",
        "time": Date.testJSONString,
        "name": "Walk to the Moon",
        "aggregate": true,
        "activityType": "other",
        "activityTypeOther": "Moonwalk",
        "duration": TPhysicalActivityDatumDurationTests.durationJSONDictionary,
        "distance": TPhysicalActivityDatumDistanceTests.distanceJSONDictionary,
        "elevationChange": TPhysicalActivityDatumElevationChangeTests.elevationChangeJSONDictionary,
        "flight": TPhysicalActivityDatumFlightTests.flightJSONDictionary,
        "lap": TPhysicalActivityDatumLapTests.lapJSONDictionary,
        "step": TPhysicalActivityDatumStepTests.stepJSONDictionary,
        "reportedIntensity": "high",
        "energy": TPhysicalActivityDatumEnergyTests.energyJSONDictionary,
    ]
    
    func testInitializer() {
        let physicalActivity = TPhysicalActivityDatumTests.physicalActivity
        XCTAssertEqual(physicalActivity.name, "Walk to the Moon")
        XCTAssertEqual(physicalActivity.aggregate, true)
        XCTAssertEqual(physicalActivity.activityType, .other)
        XCTAssertEqual(physicalActivity.activityTypeOther, "Moonwalk")
        XCTAssertEqual(physicalActivity.duration, TPhysicalActivityDatumDurationTests.duration)
        XCTAssertEqual(physicalActivity.distance, TPhysicalActivityDatumDistanceTests.distance)
        XCTAssertEqual(physicalActivity.elevationChange, TPhysicalActivityDatumElevationChangeTests.elevationChange)
        XCTAssertEqual(physicalActivity.flight, TPhysicalActivityDatumFlightTests.flight)
        XCTAssertEqual(physicalActivity.lap, TPhysicalActivityDatumLapTests.lap)
        XCTAssertEqual(physicalActivity.step, TPhysicalActivityDatumStepTests.step)
        XCTAssertEqual(physicalActivity.reportedIntensity, .high)
        XCTAssertEqual(physicalActivity.energy, TPhysicalActivityDatumEnergyTests.energy)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPhysicalActivityDatumTests.physicalActivity, TPhysicalActivityDatumTests.physicalActivityJSONDictionary)
    }
}

class TPhysicalActivityDatumDurationTests: XCTestCase {
    static let duration = TPhysicalActivityDatum.Duration(1.23, .hours)
    static let durationJSONDictionary: [String: Any] = [
        "value": 1.23,
        "units": "hours"
    ]
    
    func testInitializer() {
        let duration = TPhysicalActivityDatumDurationTests.duration
        XCTAssertEqual(duration.value, 1.23)
        XCTAssertEqual(duration.units, .hours)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPhysicalActivityDatumDurationTests.duration, TPhysicalActivityDatumDurationTests.durationJSONDictionary)
    }
}

class TPhysicalActivityDatumDurationUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TPhysicalActivityDatum.Duration.Units.hours.rawValue, "hours")
        XCTAssertEqual(TPhysicalActivityDatum.Duration.Units.minutes.rawValue, "minutes")
        XCTAssertEqual(TPhysicalActivityDatum.Duration.Units.seconds.rawValue, "seconds")
    }
}

class TPhysicalActivityDatumDistanceTests: XCTestCase {
    static let distance = TPhysicalActivityDatum.Distance(1.23, .kilometers)
    static let distanceJSONDictionary: [String: Any] = [
        "value": 1.23,
        "units": "kilometers"
    ]
    
    func testInitializer() {
        let distance = TPhysicalActivityDatumDistanceTests.distance
        XCTAssertEqual(distance.value, 1.23)
        XCTAssertEqual(distance.units, .kilometers)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPhysicalActivityDatumDistanceTests.distance, TPhysicalActivityDatumDistanceTests.distanceJSONDictionary)
    }
}

class TPhysicalActivityDatumDistanceUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TPhysicalActivityDatum.Distance.Units.feet.rawValue, "feet")
        XCTAssertEqual(TPhysicalActivityDatum.Distance.Units.kilometers.rawValue, "kilometers")
        XCTAssertEqual(TPhysicalActivityDatum.Distance.Units.meters.rawValue, "meters")
        XCTAssertEqual(TPhysicalActivityDatum.Distance.Units.miles.rawValue, "miles")
        XCTAssertEqual(TPhysicalActivityDatum.Distance.Units.yards.rawValue, "yards")
    }
}

class TPhysicalActivityDatumElevationChangeTests: XCTestCase {
    static let elevationChange = TPhysicalActivityDatum.ElevationChange(123, .meters)
    static let elevationChangeJSONDictionary: [String: Any] = [
        "value": 123,
        "units": "meters"
    ]
    
    func testInitializer() {
        let elevationChange = TPhysicalActivityDatumElevationChangeTests.elevationChange
        XCTAssertEqual(elevationChange.value, 123)
        XCTAssertEqual(elevationChange.units, .meters)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPhysicalActivityDatumElevationChangeTests.elevationChange, TPhysicalActivityDatumElevationChangeTests.elevationChangeJSONDictionary)
    }
}

class TPhysicalActivityDatumElevationChangeUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TPhysicalActivityDatum.ElevationChange.Units.feet.rawValue, "feet")
        XCTAssertEqual(TPhysicalActivityDatum.ElevationChange.Units.meters.rawValue, "meters")
    }
}

class TPhysicalActivityDatumFlightTests: XCTestCase {
    static let flight = TPhysicalActivityDatum.Flight(count: 123)
    static let flightJSONDictionary: [String: Any] = [
        "count": 123
    ]
    
    func testInitializer() {
        let flight = TPhysicalActivityDatumFlightTests.flight
        XCTAssertEqual(flight.count, 123)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPhysicalActivityDatumFlightTests.flight, TPhysicalActivityDatumFlightTests.flightJSONDictionary)
    }
}

class TPhysicalActivityDatumLapTests: XCTestCase {
    static let lap = TPhysicalActivityDatum.Lap(123, TPhysicalActivityDatumDistanceTests.distance)
    static let lapJSONDictionary: [String: Any] = [
        "count": 123,
        "distance": TPhysicalActivityDatumDistanceTests.distanceJSONDictionary
    ]
    
    func testInitializer() {
        let lap = TPhysicalActivityDatumLapTests.lap
        XCTAssertEqual(lap.count, 123)
        XCTAssertEqual(lap.distance, TPhysicalActivityDatumDistanceTests.distance)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPhysicalActivityDatumLapTests.lap, TPhysicalActivityDatumLapTests.lapJSONDictionary)
    }
}

class TPhysicalActivityDatumStepTests: XCTestCase {
    static let step = TPhysicalActivityDatum.Step(count: 123)
    static let stepJSONDictionary: [String: Any] = [
        "count": 123
    ]
    
    func testInitializer() {
        let step = TPhysicalActivityDatumStepTests.step
        XCTAssertEqual(step.count, 123)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPhysicalActivityDatumStepTests.step, TPhysicalActivityDatumStepTests.stepJSONDictionary)
    }
}

class TPhysicalActivityDatumEnergyTests: XCTestCase {
    static let energy = TPhysicalActivityDatum.Energy(1.23, .kilocalories)
    static let energyJSONDictionary: [String: Any] = [
        "value": 1.23,
        "units": "kilocalories"
    ]
    
    func testInitializer() {
        let energy = TPhysicalActivityDatumEnergyTests.energy
        XCTAssertEqual(energy.value, 1.23)
        XCTAssertEqual(energy.units, .kilocalories)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPhysicalActivityDatumEnergyTests.energy, TPhysicalActivityDatumEnergyTests.energyJSONDictionary)
    }
}

class TPhysicalActivityDatumEnergyUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TPhysicalActivityDatum.Energy.Units.calories.rawValue, "calories")
        XCTAssertEqual(TPhysicalActivityDatum.Energy.Units.joules.rawValue, "joules")
        XCTAssertEqual(TPhysicalActivityDatum.Energy.Units.kilocalories.rawValue, "kilocalories")
        XCTAssertEqual(TPhysicalActivityDatum.Energy.Units.kilojoules.rawValue, "kilojoules")
    }
}

extension TPhysicalActivityDatum {
    func isEqual(to other: TPhysicalActivityDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.name == other.name &&
            self.aggregate == other.aggregate &&
            self.activityType == other.activityType &&
            self.activityTypeOther == other.activityTypeOther &&
            self.duration == other.duration &&
            self.distance == other.distance &&
            self.elevationChange == other.elevationChange &&
            self.flight == other.flight &&
            self.lap == other.lap &&
            self.step == other.step &&
            self.reportedIntensity == other.reportedIntensity &&
            self.energy == other.energy
    }
}
