//
//  TLocationTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/5/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TLocationTests: XCTestCase {
    static let location = TLocation(name: "Home", gps: TLocationGPSTests.gps)
    static let locationJSONDictionary: [String: Any] = [
        "name": "Home",
        "gps": TLocationGPSTests.gpsJSONDictionary
    ]
    
    func testInitializer() {
        let location = TLocationTests.location
        XCTAssertEqual(location.name, "Home")
        XCTAssertEqual(location.gps, TLocationGPSTests.gps)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TLocationTests.location, TLocationTests.locationJSONDictionary)
    }
}

class TLocationGPSTests: XCTestCase {
    static let gps = TLocation.GPS(
        latitude: TLocationGPSLatitudeTests.latitude,
        longitude: TLocationGPSLongitudeTests.longitude,
        elevation: TLocationGPSElevationTests.elevation,
        floor: 7,
        horizontalAccuracy: TLocationGPSAccuracyTests.accuracy,
        verticalAccuracy: TLocationGPSAccuracyTests.accuracy,
        origin: TOriginTests.origin)
    static let gpsJSONDictionary: [String: Any] = [
        "latitude": TLocationGPSLatitudeTests.latitudeJSONDictionary,
        "longitude": TLocationGPSLongitudeTests.longitudeJSONDictionary,
        "elevation": TLocationGPSElevationTests.elevationJSONDictionary,
        "floor": 7,
        "horizontalAccuracy": TLocationGPSAccuracyTests.accuracyJSONDictionary,
        "verticalAccuracy": TLocationGPSAccuracyTests.accuracyJSONDictionary,
        "origin": TOriginTests.originJSONDictionary
    ]
    
    func testInitializer() {
        let gps = TLocationGPSTests.gps
        XCTAssertEqual(gps.latitude, TLocationGPSLatitudeTests.latitude)
        XCTAssertEqual(gps.longitude, TLocationGPSLongitudeTests.longitude)
        XCTAssertEqual(gps.elevation, TLocationGPSElevationTests.elevation)
        XCTAssertEqual(gps.floor, 7)
        XCTAssertEqual(gps.horizontalAccuracy, TLocationGPSAccuracyTests.accuracy)
        XCTAssertEqual(gps.verticalAccuracy, TLocationGPSAccuracyTests.accuracy)
        XCTAssertEqual(gps.origin, TOriginTests.origin)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TLocationGPSTests.gps, TLocationGPSTests.gpsJSONDictionary)
    }
}

class TLocationGPSLatitudeTests: XCTestCase {
    static let latitude = TLocation.GPS.Latitude(1.23)
    static let latitudeJSONDictionary: [String: Any] = [
        "value": 1.23,
        "units": "degrees"
    ]
    
    func testInitializer() {
        let latitude = TLocationGPSLatitudeTests.latitude
        XCTAssertEqual(latitude.value, 1.23)
        XCTAssertEqual(latitude.units, .degrees)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TLocationGPSLatitudeTests.latitude, TLocationGPSLatitudeTests.latitudeJSONDictionary)
    }
}

class TLocationGPSLatitudeUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TLocation.GPS.Latitude.Units.degrees.rawValue, "degrees")
    }
}

class TLocationGPSLongitudeTests: XCTestCase {
    static let longitude = TLocation.GPS.Longitude(1.23)
    static let longitudeJSONDictionary: [String: Any] = [
        "value": 1.23,
        "units": "degrees"
    ]
    
    func testInitializer() {
        let longitude = TLocationGPSLongitudeTests.longitude
        XCTAssertEqual(longitude.value, 1.23)
        XCTAssertEqual(longitude.units, .degrees)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TLocationGPSLongitudeTests.longitude, TLocationGPSLongitudeTests.longitudeJSONDictionary)
    }
}

class TLocationGPSLongitudeUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TLocation.GPS.Longitude.Units.degrees.rawValue, "degrees")
    }
}

class TLocationGPSElevationTests: XCTestCase {
    static let elevation = TLocation.GPS.Elevation(1.23, .feet)
    static let elevationJSONDictionary: [String: Any] = [
        "value": 1.23,
        "units": "feet"
    ]
    
    func testInitializer() {
        let elevation = TLocationGPSElevationTests.elevation
        XCTAssertEqual(elevation.value, 1.23)
        XCTAssertEqual(elevation.units, .feet)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TLocationGPSElevationTests.elevation, TLocationGPSElevationTests.elevationJSONDictionary)
    }
}

class TLocationGPSElevationUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TLocation.GPS.Elevation.Units.feet.rawValue, "feet")
        XCTAssertEqual(TLocation.GPS.Elevation.Units.meters.rawValue, "meters")
    }
}

class TLocationGPSAccuracyTests: XCTestCase {
    static let accuracy = TLocation.GPS.Accuracy(1.23, .feet)
    static let accuracyJSONDictionary: [String: Any] = [
        "value": 1.23,
        "units": "feet"
    ]
    
    func testInitializer() {
        let accuracy = TLocationGPSAccuracyTests.accuracy
        XCTAssertEqual(accuracy.value, 1.23)
        XCTAssertEqual(accuracy.units, .feet)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TLocationGPSAccuracyTests.accuracy, TLocationGPSAccuracyTests.accuracyJSONDictionary)
    }
}

class TLocationGPSAccuracyUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TLocation.GPS.Accuracy.Units.feet.rawValue, "feet")
        XCTAssertEqual(TLocation.GPS.Accuracy.Units.meters.rawValue, "meters")
    }
}
