//
//  TProfileTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 3/3/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TProfileTests: XCTestCase {
    static let profile = TProfile(fullName: "John Doe", patient: TProfilePatientTests.patient)
    static let profileJSONDictionary: [String: Any] = [
        "fullName": "John Doe",
        "patient": TProfilePatientTests.patientJSONDictionary
    ]
    
    func testInitializer() {
        let profile = TProfileTests.profile
        XCTAssertEqual(profile.fullName, "John Doe")
        XCTAssertEqual(profile.patient, TProfilePatientTests.patient)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TProfileTests.profile, TProfileTests.profileJSONDictionary)
    }
}

class TProfilePatientTests: XCTestCase {
    static let patient = TProfile.Patient(isOtherPerson: true,
                                          fullName: "Jane Doe",
                                          birthday: "12/31/1999",
                                          diagnosisDate: "1/1/2009",
                                          diagnosisType: "type1",
                                          biologicalSex: "female",
                                          targetTimezone: "Americas/Los_Angeles",
                                          targetDevices: ["Medtronic", "Dexcom"],
                                          about: "This is an about box.")
    static let patientJSONDictionary: [String: Any] = [
        "isOtherPerson": true,
        "fullName": "Jane Doe",
        "birthday": "12/31/1999",
        "diagnosisDate": "1/1/2009",
        "diagnosisType": "type1",
        "biologicalSex": "female",
        "targetTimezone": "Americas/Los_Angeles",
        "targetDevices": ["Medtronic", "Dexcom"],
        "about": "This is an about box."
    ]
    
    func testInitializer() {
        let patient = TProfilePatientTests.patient
        XCTAssertEqual(patient.isOtherPerson, true)
        XCTAssertEqual(patient.fullName, "Jane Doe")
        XCTAssertEqual(patient.birthday, "12/31/1999")
        XCTAssertEqual(patient.diagnosisDate, "1/1/2009")
        XCTAssertEqual(patient.diagnosisType, "type1")
        XCTAssertEqual(patient.biologicalSex, "female")
        XCTAssertEqual(patient.targetTimezone, "Americas/Los_Angeles")
        XCTAssertEqual(patient.targetDevices, ["Medtronic", "Dexcom"])
        XCTAssertEqual(patient.about, "This is an about box.")
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TProfilePatientTests.patient, TProfilePatientTests.patientJSONDictionary)
    }
}
