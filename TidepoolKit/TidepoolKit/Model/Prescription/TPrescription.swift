//
//  TPrescription.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 4/22/21.
//  Copyright © 2021 Tidepool Project. All rights reserved.
//

public struct TPrescription: Codable, Equatable {
    public enum State: String, Codable, Equatable {
        case draft
        case pending
        case submitted
        case claimed
        case expired
        case active
        case inactive
    }

    public var id: String?
    public var patientUserId: String?
    public var accessCode: String?
    public var state: State?
    public var latestRevision: Revision?
    public var expirationTime: Date?
    public var prescriberUserId: String?
    public var clinicId: String?
    public var createdTime: Date?
    public var createdUserId: String?
    public var modifiedTime: Date?
    public var modifiedUserId: String?
    public var submittedTime: Date?
    
    public init(id: String? = nil,
                patientUserId: String? = nil,
                accessCode: String? = nil,
                state: State? = nil,
                latestRevision: Revision? = nil,
                expirationTime: Date? = nil,
                prescriberUserId: String? = nil,
                clinicId: String? = nil,
                createdTime: Date? = nil,
                createdUserId: String? = nil,
                modifiedTime: Date? = nil,
                modifiedUserId: String? = nil,
                submittedTime: Date? = nil) {
        self.id = id
        self.patientUserId = patientUserId
        self.accessCode = accessCode
        self.state = state
        self.latestRevision = latestRevision
        self.expirationTime = expirationTime
        self.prescriberUserId = prescriberUserId
        self.clinicId = clinicId
        self.createdTime = createdTime
        self.createdUserId = createdUserId
        self.modifiedTime = modifiedTime
        self.modifiedUserId = modifiedUserId
        self.submittedTime = submittedTime
    }
    
    public struct Revision: Codable, Equatable {
        public var revisionId: Int?
        public var integrityHash: IntegrityHash?
        public var attributes: Attributes?
        public var createdTime: Date?
        public var createdUserId: String?

        public init(revisionId: Int? = nil,
                    integrityHash: IntegrityHash? = nil,
                    attributes: Attributes? = nil,
                    createdTime: Date? = nil,
                    createdUserId: String? = nil) {
            self.revisionId = revisionId
            self.integrityHash = integrityHash
            self.attributes = attributes
            self.createdTime = createdTime
            self.createdUserId = createdUserId
        }
    }

    public struct IntegrityHash: Codable, Equatable {
        public enum Algorithm: String, Codable, Equatable {
            case jcssha512 = "JCSSHA512"
        }

        public var algorithm: Algorithm?
        public var hash: String?

        public init(algorithm: Algorithm? = nil, hash: String? = nil) {
            self.algorithm = algorithm
            self.hash = hash
        }
    }
    
    public struct Attributes: Codable, Equatable {
        public enum State: String, Codable, Equatable {
            case draft
            case pending
            case submitted
        }

        public enum AccountType: String, Codable, Equatable {
            case patient
            case caregiver
        }

        public enum Sex: String, Codable, Equatable {
            case male
            case female
            case undisclosed
        }

        public enum Training: String, Codable, Equatable {
            case inPerson
            case inModule
        }

        public enum TherapySettings: String, Codable, Equatable {
            case initial
            case transferPumpSettings
        }

        public var accountType: AccountType?
        public var caregiverFirstName: String?
        public var caregiverLastName: String?
        public var firstName: String?
        public var lastName: String?
        public var birthday: String?
        public var mrn: String?
        public var email: String?
        public var sex: Sex?
        public var weight: Weight?
        public var yearOfDiagnosis: Int?
        public var phoneNumber: PhoneNumber?
        public var initialSettings: InitialSettings?
        public var calculator: Calculator?
        public var training: Training?
        public var therapySettings: TherapySettings?
        public var prescriberTermsAccepted: Bool?
        public var state: State?
        
        public init(accountType: AccountType? = nil,
                    caregiverFirstName: String? = nil,
                    caregiverLastName: String? = nil,
                    firstName: String? = nil,
                    lastName: String? = nil,
                    birthday: String? = nil,
                    mrn: String? = nil,
                    email: String? = nil,
                    sex: Sex? = nil,
                    weight: Weight? = nil,
                    yearOfDiagnosis: Int? = nil,
                    phoneNumber: PhoneNumber? = nil,
                    initialSettings: InitialSettings? = nil,
                    calculator: Calculator? = nil,
                    training: Training? = nil,
                    therapySettings: TherapySettings? = nil,
                    prescriberTermsAccepted: Bool? = nil,
                    state: State? = nil) {
            self.accountType = accountType
            self.caregiverFirstName = caregiverFirstName
            self.caregiverLastName = caregiverLastName
            self.firstName = firstName
            self.lastName = lastName
            self.birthday = birthday
            self.mrn = mrn
            self.email = email
            self.sex = sex
            self.weight = weight
            self.yearOfDiagnosis = yearOfDiagnosis
            self.phoneNumber = phoneNumber
            self.initialSettings = initialSettings
            self.calculator = calculator
            self.training = training
            self.therapySettings = therapySettings
            self.prescriberTermsAccepted = prescriberTermsAccepted
            self.state = state
        }

        public struct Weight: Codable, Equatable {
            public var value: Double?
            public var units: Units?

            public init(value: Double? = nil, units: Units? = nil) {
                self.value = value
                self.units = units
            }

            public enum Units: String, Codable, Equatable {
                case kg
            }
        }

        public struct PhoneNumber: Codable, Equatable {
            public var countryCode: Int?
            public var number: String?

            public init(countryCode: Int? = nil, number: String? = nil) {
                self.countryCode = countryCode
                self.number = number
            }
        }

        public struct InitialSettings: Codable, Equatable {
            public typealias BloodGlucoseUnits = TBloodGlucose.Units
            public typealias BasalRateStart = TPumpSettingsDatum.BasalRateStart
            public typealias BloodGlucoseTarget = TBloodGlucose.Target
            public typealias BloodGlucoseStartTarget = TBloodGlucose.StartTarget
            public typealias CarbohydrateRatioStart = TPumpSettingsDatum.CarbohydrateRatioStart
            public typealias InsulinModelType = TPumpSettingsDatum.InsulinModel.ModelType
            public typealias InsulinSensitivityStart = TPumpSettingsDatum.InsulinSensitivityStart
            public typealias BasalRateMaximum = TPumpSettingsDatum.Basal.RateMaximum
            public typealias BolusAmountMaximum = TPumpSettingsDatum.Bolus.AmountMaximum

            public var bloodGlucoseUnits: BloodGlucoseUnits?
            public var basalRateSchedule: [BasalRateStart]?
            public var bloodGlucoseTargetPhysicalActivity: BloodGlucoseTarget?
            public var bloodGlucoseTargetPreprandial: BloodGlucoseTarget?
            public var bloodGlucoseTargetSchedule: [BloodGlucoseStartTarget]?
            public var carbohydrateRatioSchedule: [CarbohydrateRatioStart]?
            public var glucoseSafetyLimit: Double?
            public var insulinModel: InsulinModelType?
            public var insulinSensitivitySchedule: [InsulinSensitivityStart]?
            public var basalRateMaximum: BasalRateMaximum?
            public var bolusAmountMaximum: BolusAmountMaximum?
            public var pumpId: String?
            public var cgmId: String?

            public init(bloodGlucoseUnits: BloodGlucoseUnits? = nil,
                        basalRateSchedule: [BasalRateStart]? = nil,
                        bloodGlucoseTargetPhysicalActivity: BloodGlucoseTarget? = nil,
                        bloodGlucoseTargetPreprandial: BloodGlucoseTarget? = nil,
                        bloodGlucoseTargetSchedule: [BloodGlucoseStartTarget]? = nil,
                        carbohydrateRatioSchedule: [CarbohydrateRatioStart]? = nil,
                        glucoseSafetyLimit: Double? = nil,
                        insulinModel: InsulinModelType? = nil,
                        insulinSensitivitySchedule: [InsulinSensitivityStart]? = nil,
                        basalRateMaximum: BasalRateMaximum? = nil,
                        bolusAmountMaximum: BolusAmountMaximum? = nil,
                        pumpId: String? = nil,
                        cgmId: String? = nil) {
                self.bloodGlucoseUnits = bloodGlucoseUnits
                self.basalRateSchedule = basalRateSchedule
                self.bloodGlucoseTargetPhysicalActivity = bloodGlucoseTargetPhysicalActivity
                self.bloodGlucoseTargetPreprandial = bloodGlucoseTargetPreprandial
                self.bloodGlucoseTargetSchedule = bloodGlucoseTargetSchedule
                self.carbohydrateRatioSchedule = carbohydrateRatioSchedule
                self.glucoseSafetyLimit = glucoseSafetyLimit
                self.insulinModel = insulinModel
                self.insulinSensitivitySchedule = insulinSensitivitySchedule
                self.basalRateMaximum = basalRateMaximum
                self.bolusAmountMaximum = bolusAmountMaximum
                self.pumpId = pumpId
                self.cgmId = cgmId
            }
        }

        public struct Calculator: Codable, Equatable {
            public enum Method: String, Codable, Equatable {
                case weight
                case totalDailyDose
                case totalDailyDoseAndWeight
            }

            public enum WeightUnits: String, Codable, Equatable {
                case kilograms = "kg"
                case pounds = "lbs"
            }

            public var method: Method?
            public var recommendedBasalRate: Double?
            public var recommendedCarbohydrateRatio: Double?
            public var recommendedInsulinSensitivity: Double?
            public var totalDailyDose: Double?
            public var totalDailyDoseScaleFactor: Double?
            public var weight: Double?
            public var weightUnits: WeightUnits?

            public init(method: Method? = nil,
                        recommendedBasalRate: Double? = nil,
                        recommendedCarbohydrateRatio: Double? = nil,
                        recommendedInsulinSensitivity: Double? = nil,
                        totalDailyDose: Double? = nil,
                        totalDailyDoseScaleFactor: Double? = nil,
                        weight: Double? = nil,
                        weightUnits: WeightUnits? = nil) {
                self.method = method
                self.recommendedBasalRate = recommendedBasalRate
                self.recommendedCarbohydrateRatio = recommendedCarbohydrateRatio
                self.recommendedInsulinSensitivity = recommendedInsulinSensitivity
                self.totalDailyDose = totalDailyDose
                self.totalDailyDoseScaleFactor = totalDailyDoseScaleFactor
                self.weight = weight
                self.weightUnits = weightUnits
            }
        }
    }
}
