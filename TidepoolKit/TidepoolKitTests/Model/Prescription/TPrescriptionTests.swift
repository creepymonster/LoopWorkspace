//
//  TPrescriptionTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 4/30/21.
//  Copyright © 2021 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TPrescriptionTests: XCTestCase {
    static let prescription = TPrescription(
        id: "1234567890",
        patientUserId: "a1b2c3d4e5",
        accessCode: "ABCDEF",
        state: .claimed,
        latestRevision: TPrescriptionRevisionTests.revision,
        expirationTime: Date.test,
        prescriberUserId: "b2c3d4e5f6",
        clinicId: "e5f6g7c3d4",
        createdTime: Date.test,
        createdUserId: "c3d4e5f6g7",
        modifiedTime: Date.test,
        modifiedUserId: "d4e5f6g7h8",
        submittedTime: Date.test)
    static let prescriptionJSONDictionary: [String: Any] = [
        "id": "1234567890",
        "patientUserId": "a1b2c3d4e5",
        "accessCode": "ABCDEF",
        "state": TPrescription.State.claimed.rawValue,
        "latestRevision": TPrescriptionRevisionTests.revisionJSONDictionary,
        "expirationTime": Date.testJSONString,
        "prescriberUserId": "b2c3d4e5f6",
        "clinicId": "e5f6g7c3d4",
        "createdTime": Date.testJSONString,
        "createdUserId": "c3d4e5f6g7",
        "modifiedTime": Date.testJSONString,
        "modifiedUserId": "d4e5f6g7h8",
        "submittedTime": Date.testJSONString
    ]
    
    func testInitializer() {
        let prescription = TPrescriptionTests.prescription
        XCTAssertEqual(prescription.id, "1234567890")
        XCTAssertEqual(prescription.patientUserId, "a1b2c3d4e5")
        XCTAssertEqual(prescription.accessCode, "ABCDEF")
        XCTAssertEqual(prescription.state, .claimed)
        XCTAssertEqual(prescription.latestRevision, TPrescriptionRevisionTests.revision)
        XCTAssertEqual(prescription.expirationTime, Date.test)
        XCTAssertEqual(prescription.prescriberUserId, "b2c3d4e5f6")
        XCTAssertEqual(prescription.clinicId, "e5f6g7c3d4")
        XCTAssertEqual(prescription.createdTime, Date.test)
        XCTAssertEqual(prescription.createdUserId, "c3d4e5f6g7")
        XCTAssertEqual(prescription.modifiedTime, Date.test)
        XCTAssertEqual(prescription.modifiedUserId, "d4e5f6g7h8")
        XCTAssertEqual(prescription.submittedTime, Date.test)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPrescriptionTests.prescription, TPrescriptionTests.prescriptionJSONDictionary)
    }
}

class TPrescriptionStateTests: XCTestCase {
    func testState() {
        XCTAssertEqual(TPrescription.State.draft.rawValue, "draft")
        XCTAssertEqual(TPrescription.State.pending.rawValue, "pending")
        XCTAssertEqual(TPrescription.State.submitted.rawValue, "submitted")
        XCTAssertEqual(TPrescription.State.claimed.rawValue, "claimed")
        XCTAssertEqual(TPrescription.State.expired.rawValue, "expired")
        XCTAssertEqual(TPrescription.State.active.rawValue, "active")
        XCTAssertEqual(TPrescription.State.inactive.rawValue, "inactive")
    }
}

class TPrescriptionRevisionTests: XCTestCase {
    static let revision = TPrescription.Revision(revisionId: 123,
                                                 integrityHash: TPrescriptionIntegrityHashTests.integrityHash,
                                                 attributes: TPrescriptionAttributesTests.attributes,
                                                 createdTime: Date.test,
                                                 createdUserId: "abcdefghijklmnopqrstuvwxyz")
    static let revisionJSONDictionary: [String: Any] = [
        "revisionId": 123,
        "integrityHash": TPrescriptionIntegrityHashTests.integrityHashJSONDictionary,
        "attributes": TPrescriptionAttributesTests.attributesJSONDictionary,
        "createdTime": Date.testJSONString,
        "createdUserId": "abcdefghijklmnopqrstuvwxyz"
    ]
    
    func testInitializer() {
        let revision = TPrescriptionRevisionTests.revision
        XCTAssertEqual(revision.revisionId, 123)
        XCTAssertEqual(revision.integrityHash, TPrescriptionIntegrityHashTests.integrityHash)
        XCTAssertEqual(revision.attributes, TPrescriptionAttributesTests.attributes)
        XCTAssertEqual(revision.createdTime, Date.test)
        XCTAssertEqual(revision.createdUserId, "abcdefghijklmnopqrstuvwxyz")
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPrescriptionRevisionTests.revision, TPrescriptionRevisionTests.revisionJSONDictionary)
    }
}

class TPrescriptionIntegrityHashTests: XCTestCase {
    static let integrityHash = TPrescription.IntegrityHash(algorithm: .jcssha512, hash: "1234567890")
    static let integrityHashJSONDictionary: [String: Any] = [
        "algorithm": "JCSSHA512",
        "hash": "1234567890"
    ]

    func testInitializer() {
        let integrityHash = TPrescriptionIntegrityHashTests.integrityHash
        XCTAssertEqual(integrityHash.algorithm, .jcssha512)
        XCTAssertEqual(integrityHash.hash, "1234567890")
    }

    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPrescriptionIntegrityHashTests.integrityHash, TPrescriptionIntegrityHashTests.integrityHashJSONDictionary)
    }
}

class TPrescriptionAttributesTests: XCTestCase {
    static let attributes = TPrescription.Attributes(
        accountType: .caregiver,
        caregiverFirstName: "Parent",
        caregiverLastName: "Doe",
        firstName: "Child",
        lastName: "Doe",
        birthday: "2004-01-04",
        mrn: "1234567890",
        email: "parent.doe@email.com",
        sex: .undisclosed,
        weight: TPrescriptionAttributesWeightTests.weight,
        yearOfDiagnosis: 2020,
        phoneNumber: TPrescriptionAttributesPhoneNumberTests.phoneNumber,
        initialSettings: TPrescriptionAttributesInitialSettingsTests.initialSettings,
        calculator: TPrescriptionAttributesCalculatorTests.calculator,
        training: .inModule,
        therapySettings: .initial,
        prescriberTermsAccepted: true,
        state: .submitted)
    static let attributesJSONDictionary: [String: Any] = [
        "accountType": TPrescription.Attributes.AccountType.caregiver.rawValue,
        "caregiverFirstName": "Parent",
        "caregiverLastName": "Doe",
        "firstName": "Child",
        "lastName": "Doe",
        "birthday": "2004-01-04",
        "mrn": "1234567890",
        "email": "parent.doe@email.com",
        "sex": TPrescription.Attributes.Sex.undisclosed.rawValue,
        "weight": TPrescriptionAttributesWeightTests.weightJSONDictionary,
        "yearOfDiagnosis": 2020,
        "phoneNumber": TPrescriptionAttributesPhoneNumberTests.phoneNumberJSONDictionary,
        "initialSettings": TPrescriptionAttributesInitialSettingsTests.initialSettingsJSONDictionary,
        "calculator": TPrescriptionAttributesCalculatorTests.calculatorJSONDictionary,
        "training": TPrescription.Attributes.Training.inModule.rawValue,
        "therapySettings": TPrescription.Attributes.TherapySettings.initial.rawValue,
        "prescriberTermsAccepted": true,
        "state": TPrescription.Attributes.State.submitted.rawValue
    ]
    
    func testInitializer() {
        let attributes = TPrescriptionAttributesTests.attributes
        XCTAssertEqual(attributes.accountType, .caregiver)
        XCTAssertEqual(attributes.caregiverFirstName, "Parent")
        XCTAssertEqual(attributes.caregiverLastName, "Doe")
        XCTAssertEqual(attributes.firstName, "Child")
        XCTAssertEqual(attributes.lastName, "Doe")
        XCTAssertEqual(attributes.birthday, "2004-01-04")
        XCTAssertEqual(attributes.mrn, "1234567890")
        XCTAssertEqual(attributes.email, "parent.doe@email.com")
        XCTAssertEqual(attributes.sex, .undisclosed)
        XCTAssertEqual(attributes.weight, TPrescriptionAttributesWeightTests.weight)
        XCTAssertEqual(attributes.yearOfDiagnosis, 2020)
        XCTAssertEqual(attributes.phoneNumber, TPrescriptionAttributesPhoneNumberTests.phoneNumber)
        XCTAssertEqual(attributes.initialSettings, TPrescriptionAttributesInitialSettingsTests.initialSettings)
        XCTAssertEqual(attributes.calculator, TPrescriptionAttributesCalculatorTests.calculator)
        XCTAssertEqual(attributes.training, .inModule)
        XCTAssertEqual(attributes.therapySettings, .initial)
        XCTAssertEqual(attributes.prescriberTermsAccepted, true)
        XCTAssertEqual(attributes.state, .submitted)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPrescriptionAttributesTests.attributes, TPrescriptionAttributesTests.attributesJSONDictionary)
    }
}

class TPrescriptionAttributesStateTests: XCTestCase {
    func testState() {
        XCTAssertEqual(TPrescription.Attributes.State.draft.rawValue, "draft")
        XCTAssertEqual(TPrescription.Attributes.State.pending.rawValue, "pending")
        XCTAssertEqual(TPrescription.Attributes.State.submitted.rawValue, "submitted")
    }
}

class TPrescriptionAttributesAccountTypeTests: XCTestCase {
    func testAccountType() {
        XCTAssertEqual(TPrescription.Attributes.AccountType.patient.rawValue, "patient")
        XCTAssertEqual(TPrescription.Attributes.AccountType.caregiver.rawValue, "caregiver")
    }
}

class TPrescriptionAttributesSexTests: XCTestCase {
    func testSex() {
        XCTAssertEqual(TPrescription.Attributes.Sex.male.rawValue, "male")
        XCTAssertEqual(TPrescription.Attributes.Sex.female.rawValue, "female")
        XCTAssertEqual(TPrescription.Attributes.Sex.undisclosed.rawValue, "undisclosed")
    }
}

class TPrescriptionAttributesTrainingTests: XCTestCase {
    func testTraining() {
        XCTAssertEqual(TPrescription.Attributes.Training.inPerson.rawValue, "inPerson")
        XCTAssertEqual(TPrescription.Attributes.Training.inModule.rawValue, "inModule")
    }
}

class TPrescriptionAttributesTherapySettingsTests: XCTestCase {
    func testTherapySettings() {
        XCTAssertEqual(TPrescription.Attributes.TherapySettings.initial.rawValue, "initial")
        XCTAssertEqual(TPrescription.Attributes.TherapySettings.transferPumpSettings.rawValue, "transferPumpSettings")
    }
}

class TPrescriptionAttributesWeightTests: XCTestCase {
    static let weight = TPrescription.Attributes.Weight(value: 123, units: .kg)
    static let weightJSONDictionary: [String: Any] = [
        "value": 123,
        "units": "kg"
    ]
    
    func testInitializer() {
        let weight = TPrescriptionAttributesWeightTests.weight
        XCTAssertEqual(weight.value, 123)
        XCTAssertEqual(weight.units, .kg)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPrescriptionAttributesWeightTests.weight, TPrescriptionAttributesWeightTests.weightJSONDictionary)
    }
}

class TPrescriptionAttributesWeightUnitsTests: XCTestCase {
    func testUnits() {
        XCTAssertEqual(TPrescription.Attributes.Weight.Units.kg.rawValue, "kg")
    }
}

class TPrescriptionAttributesPhoneNumberTests: XCTestCase {
    static let phoneNumber = TPrescription.Attributes.PhoneNumber(countryCode: 123, number: "(234) 345-4566")
    static let phoneNumberJSONDictionary: [String: Any] = [
        "countryCode": 123,
        "number": "(234) 345-4566"
    ]
    
    func testInitializer() {
        let phoneNumber = TPrescriptionAttributesPhoneNumberTests.phoneNumber
        XCTAssertEqual(phoneNumber.countryCode, 123)
        XCTAssertEqual(phoneNumber.number, "(234) 345-4566")
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPrescriptionAttributesPhoneNumberTests.phoneNumber, TPrescriptionAttributesPhoneNumberTests.phoneNumberJSONDictionary)
    }
}

class TPrescriptionAttributesInitialSettingsTests: XCTestCase {
    static let initialSettings = TPrescription.Attributes.InitialSettings(
        bloodGlucoseUnits: .milligramsPerDeciliter,
        basalRateSchedule: [TPumpSettingsDatumBasalRateStartTests.basalRateStart,
                            TPumpSettingsDatumBasalRateStartTests.basalRateStart],
        bloodGlucoseTargetPhysicalActivity: TBloodGlucoseTargetTests.target,
        bloodGlucoseTargetPreprandial: TBloodGlucoseTargetTests.target,
        bloodGlucoseTargetSchedule: [TBloodGlucoseStartTargetTests.startTarget,
                                     TBloodGlucoseStartTargetTests.startTarget],
        carbohydrateRatioSchedule: [TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStart,
                                    TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStart],
        glucoseSafetyLimit: 78.9,
        insulinModel: .rapidChild,
        insulinSensitivitySchedule: [TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStart,
                                     TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStart],
        basalRateMaximum: TPumpSettingsDatumBasalRateMaximumTests.rateMaximum,
        bolusAmountMaximum: TPumpSettingsDatumBolusAmountMaximumTests.amountMaximum,
        pumpId: "ABCDEFGHIJ",
        cgmId: "1234567890")
    static let initialSettingsJSONDictionary: [String: Any] = [
        "bloodGlucoseUnits": TBloodGlucose.Units.milligramsPerDeciliter.rawValue,
        "basalRateSchedule": [TPumpSettingsDatumBasalRateStartTests.basalRateStartJSONDictionary,
                              TPumpSettingsDatumBasalRateStartTests.basalRateStartJSONDictionary],
        "bloodGlucoseTargetPhysicalActivity": TBloodGlucoseTargetTests.targetJSONDictionary,
        "bloodGlucoseTargetPreprandial": TBloodGlucoseTargetTests.targetJSONDictionary,
        "bloodGlucoseTargetSchedule": [TBloodGlucoseStartTargetTests.startTargetJSONDictionary,
                                       TBloodGlucoseStartTargetTests.startTargetJSONDictionary],
        "carbohydrateRatioSchedule": [TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStartJSONDictionary,
                                      TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStartJSONDictionary],
        "glucoseSafetyLimit": 78.9,
        "insulinModel": TPumpSettingsDatum.InsulinModel.ModelType.rapidChild.rawValue,
        "insulinSensitivitySchedule": [TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStartJSONDictionary,
                                       TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStartJSONDictionary],
        "basalRateMaximum": TPumpSettingsDatumBasalRateMaximumTests.rateMaximumJSONDictionary,
        "bolusAmountMaximum": TPumpSettingsDatumBolusAmountMaximumTests.amountMaximumJSONDictionary,
        "pumpId": "ABCDEFGHIJ",
        "cgmId": "1234567890"
    ]
    
    func testInitializer() {
        let initialSettings = TPrescriptionAttributesInitialSettingsTests.initialSettings
        XCTAssertEqual(initialSettings.bloodGlucoseUnits, .milligramsPerDeciliter)
        XCTAssertEqual(initialSettings.basalRateSchedule, [TPumpSettingsDatumBasalRateStartTests.basalRateStart,
                                                           TPumpSettingsDatumBasalRateStartTests.basalRateStart])
        XCTAssertEqual(initialSettings.bloodGlucoseTargetPhysicalActivity, TBloodGlucoseTargetTests.target)
        XCTAssertEqual(initialSettings.bloodGlucoseTargetPreprandial, TBloodGlucoseTargetTests.target)
        XCTAssertEqual(initialSettings.bloodGlucoseTargetSchedule, [TBloodGlucoseStartTargetTests.startTarget,
                                                                    TBloodGlucoseStartTargetTests.startTarget])
        XCTAssertEqual(initialSettings.carbohydrateRatioSchedule, [TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStart,
                                                                   TPumpSettingsDatumCarbohydrateRatioStartTests.carbohydrateRatioStart])
        XCTAssertEqual(initialSettings.glucoseSafetyLimit, 78.9)
        XCTAssertEqual(initialSettings.insulinModel, .rapidChild)
        XCTAssertEqual(initialSettings.insulinSensitivitySchedule, [TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStart,
                                                                    TPumpSettingsDatumInsulinSensitivityStartTests.insulinSensitivityStart])
        XCTAssertEqual(initialSettings.basalRateMaximum, TPumpSettingsDatumBasalRateMaximumTests.rateMaximum)
        XCTAssertEqual(initialSettings.bolusAmountMaximum, TPumpSettingsDatumBolusAmountMaximumTests.amountMaximum)
        XCTAssertEqual(initialSettings.pumpId, "ABCDEFGHIJ")
        XCTAssertEqual(initialSettings.cgmId, "1234567890")
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPrescriptionAttributesInitialSettingsTests.initialSettings, TPrescriptionAttributesInitialSettingsTests.initialSettingsJSONDictionary)
    }
}

class TPrescriptionAttributesCalculatorTests: XCTestCase {
    static let calculator = TPrescription.Attributes.Calculator(method: .totalDailyDoseAndWeight,
                                                                recommendedBasalRate: 1.25,
                                                                recommendedCarbohydrateRatio: 15.0,
                                                                recommendedInsulinSensitivity: 45.0,
                                                                totalDailyDose: 60,
                                                                totalDailyDoseScaleFactor: 0.9,
                                                                weight: 75,
                                                                weightUnits: .kilograms)
    static let calculatorJSONDictionary: [String: Any] = [
        "method": "totalDailyDoseAndWeight",
        "recommendedBasalRate": 1.25,
        "recommendedCarbohydrateRatio": 15.0,
        "recommendedInsulinSensitivity": 45.0,
        "totalDailyDose": 60,
        "totalDailyDoseScaleFactor": 0.9,
        "weight": 75,
        "weightUnits": "kg"
    ]

    func testInitializer() {
        let calculator = TPrescriptionAttributesCalculatorTests.calculator
        XCTAssertEqual(calculator.method, .totalDailyDoseAndWeight)
        XCTAssertEqual(calculator.recommendedBasalRate, 1.25)
        XCTAssertEqual(calculator.recommendedCarbohydrateRatio, 15.0)
        XCTAssertEqual(calculator.recommendedInsulinSensitivity, 45.0)
        XCTAssertEqual(calculator.totalDailyDose, 60)
        XCTAssertEqual(calculator.totalDailyDoseScaleFactor, 0.9)
        XCTAssertEqual(calculator.weight, 75)
        XCTAssertEqual(calculator.weightUnits, .kilograms)
    }

    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TPrescriptionAttributesCalculatorTests.calculator, TPrescriptionAttributesCalculatorTests.calculatorJSONDictionary)
    }
}
