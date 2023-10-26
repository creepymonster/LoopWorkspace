//
//  TDataSetTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 3/3/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TDataSetTests: XCTestCase {
    static let dataSet = TDataSet(byUser: "1234567890",
                                  client: TDataSetClientTests.client,
                                  computerTime: "2020-01-01T12:34:56",
                                  conversionOffset: 123.456,
                                  createdTime: Date.test,
                                  dataSetType: .normal,
                                  deduplicator: TDataSetDeduplicatorTests.deduplicator,
                                  deviceId: "ExampleDeviceId",
                                  deviceManufacturers: ["Medtronic", "Dexcom"],
                                  deviceModel: "ExampleDeviceModel",
                                  deviceSerialNumber: "abcdefghijkl",
                                  deviceTags: [.bgm, .cgm],
                                  id: "2345678901",
                                  modifiedTime: Date.test,
                                  time: Date.test,
                                  timeProcessing: .acrossTheBoardTimezone,
                                  timezone: "Americas/Los_Angeles",
                                  timezoneOffset: -28800,
                                  uploadId: "3456789012",
                                  version: "1.2.3")
    static let dataSetJSONDictionary: [String: Any] = [
        "byUser": "1234567890",
        "client": TDataSetClientTests.clientJSONDictionary,
        "computerTime": "2020-01-01T12:34:56",
        "conversionOffset": 123456,
        "createdTime": Date.testJSONString,
        "dataSetType": "normal",
        "deduplicator": TDataSetDeduplicatorTests.deduplicatorJSONDictionary,
        "deviceId": "ExampleDeviceId",
        "deviceManufacturers": ["Medtronic", "Dexcom"],
        "deviceModel": "ExampleDeviceModel",
        "deviceSerialNumber": "abcdefghijkl",
        "deviceTags": ["bgm", "cgm"],
        "id": "2345678901",
        "modifiedTime": Date.testJSONString,
        "time": Date.testJSONString,
        "timeProcessing": "across-the-board-timezone",
        "timezone": "Americas/Los_Angeles",
        "timezoneOffset": -480,
        "type": "upload",
        "uploadId": "3456789012",
        "version": "1.2.3"
    ]
    
    func testInitializer() {
        let dataSet = TDataSetTests.dataSet
        XCTAssertEqual(dataSet.byUser, "1234567890")
        XCTAssertEqual(dataSet.client, TDataSetClientTests.client)
        XCTAssertEqual(dataSet.computerTime, "2020-01-01T12:34:56")
        XCTAssertEqual(dataSet.conversionOffset, 123.456)
        XCTAssertEqual(dataSet.createdTime, Date.test)
        XCTAssertEqual(dataSet.dataSetType, .normal)
        XCTAssertEqual(dataSet.deduplicator, TDataSetDeduplicatorTests.deduplicator)
        XCTAssertEqual(dataSet.deviceId, "ExampleDeviceId")
        XCTAssertEqual(dataSet.deviceManufacturers, ["Medtronic", "Dexcom"])
        XCTAssertEqual(dataSet.deviceModel, "ExampleDeviceModel")
        XCTAssertEqual(dataSet.deviceSerialNumber, "abcdefghijkl")
        XCTAssertEqual(dataSet.deviceTags, [.bgm, .cgm])
        XCTAssertEqual(dataSet.id, "2345678901")
        XCTAssertEqual(dataSet.modifiedTime, Date.test)
        XCTAssertEqual(dataSet.time, Date.test)
        XCTAssertEqual(dataSet.timeProcessing, .acrossTheBoardTimezone)
        XCTAssertEqual(dataSet.timezone, "Americas/Los_Angeles")
        XCTAssertEqual(dataSet.timezoneOffset, -28800)
        XCTAssertEqual(dataSet.uploadId, "3456789012")
        XCTAssertEqual(dataSet.version, "1.2.3")
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TDataSetTests.dataSet, TDataSetTests.dataSetJSONDictionary)
    }
}

class TDataSetDataSetTypeTests: XCTestCase {
    func testDataSetType() {
        XCTAssertEqual(TDataSet.DataSetType.continuous.rawValue, "continuous")
        XCTAssertEqual(TDataSet.DataSetType.normal.rawValue, "normal")
    }
}

class TDataSetDeviceTagTests: XCTestCase {
    func testDeviceTag() {
        XCTAssertEqual(TDataSet.DeviceTag.bgm.rawValue, "bgm")
        XCTAssertEqual(TDataSet.DeviceTag.cgm.rawValue, "cgm")
        XCTAssertEqual(TDataSet.DeviceTag.insulinPump.rawValue, "insulin-pump")
    }
}

class TDataSetTimeProcessingTests: XCTestCase {
    func testTimeProcessing() {
        XCTAssertEqual(TDataSet.TimeProcessing.acrossTheBoardTimezone.rawValue, "across-the-board-timezone")
        XCTAssertEqual(TDataSet.TimeProcessing.none.rawValue, "none")
        XCTAssertEqual(TDataSet.TimeProcessing.utcBootstrapping.rawValue, "utc-bootstrapping")
    }
}

class TDataSetClientTests: XCTestCase {
    static let client = TDataSet.Client(name: "org.tidepool.Example", version: "1.2.3", payload: TDictionary(["a": "b", "c": 0]))
    static let clientJSONDictionary: [String: Any] = [
        "name": "org.tidepool.Example",
        "version": "1.2.3",
        "private": ["a": "b", "c": 0]
    ]
    
    func testInitializer() {
        let client = TDataSetClientTests.client
        XCTAssertEqual(client.name, "org.tidepool.Example")
        XCTAssertEqual(client.version, "1.2.3")
        XCTAssertEqual(client.payload, TDictionary(["a": "b", "c": 0]))
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TDataSetClientTests.client, TDataSetClientTests.clientJSONDictionary)
    }
}

class TDataSetDeduplicatorTests: XCTestCase {
    static let deduplicator = TDataSet.Deduplicator(name: .dataSetDeleteOrigin, version: "1.2.3")
    static let deduplicatorJSONDictionary: [String: Any] = [
        "name": "org.tidepool.deduplicator.dataset.delete.origin",
        "version": "1.2.3"
    ]
    
    func testInitializer() {
        let deduplicator = TDataSetDeduplicatorTests.deduplicator
        XCTAssertEqual(deduplicator.name, .dataSetDeleteOrigin)
        XCTAssertEqual(deduplicator.version, "1.2.3")
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TDataSetDeduplicatorTests.deduplicator, TDataSetDeduplicatorTests.deduplicatorJSONDictionary)
    }
}

class TDataSetDeduplicatorNameTests: XCTestCase {
    func testName() {
        XCTAssertEqual(TDataSet.Deduplicator.Name.dataSetDeleteOrigin.rawValue, "org.tidepool.deduplicator.dataset.delete.origin")
        XCTAssertEqual(TDataSet.Deduplicator.Name.deviceDeactivateHash.rawValue, "org.tidepool.deduplicator.device.deactivate.hash")
        XCTAssertEqual(TDataSet.Deduplicator.Name.deviceTruncateDataSet.rawValue, "org.tidepool.deduplicator.device.truncate.dataset")
        XCTAssertEqual(TDataSet.Deduplicator.Name.none.rawValue, "org.tidepool.deduplicator.none")
    }
    
    func testLegacyNamesDecoding() {
        func decodeLegacyNames() throws {
            let legacyNames = ["org.tidepool.continuous.origin", "org.tidepool.hash-deactivate-old", "org.tidepool.truncate", "org.tidepool.continuous"]
            let decodedNames = try JSONDecoder.tidepool.decode([TDataSet.Deduplicator.Name].self, from: try JSONEncoder.tidepool.encode(legacyNames))
            XCTAssertEqual(decodedNames, [.dataSetDeleteOrigin, .deviceDeactivateHash, .deviceTruncateDataSet, .none])
        }
        XCTAssertNoThrow(decodeLegacyNames)
    }
}

class TDataSetFilterTests: XCTestCase {
    static let filter = TDataSet.Filter(clientName: "org.tidepool.Example", deleted: true, deviceId: "ExampleDeviceId")
    
    func testInitializer() {
        let filter = TDataSetFilterTests.filter
        XCTAssertEqual(filter.clientName, "org.tidepool.Example")
        XCTAssertEqual(filter.deleted, true)
        XCTAssertEqual(filter.deviceId, "ExampleDeviceId")
    }
    
    func testQueryItems() {
        XCTAssertEqual(TDataSetFilterTests.filter.queryItems, [URLQueryItem(name: "client.name", value: "org.tidepool.Example"),
                                                               URLQueryItem(name: "deleted", value: "true"),
                                                               URLQueryItem(name: "deviceId", value: "ExampleDeviceId")])
    }
}
