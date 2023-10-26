//
//  TProfile.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 2/21/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

public struct TProfile: Codable, Equatable {
    public var fullName: String?
    public var patient: Patient?

    public init(fullName: String, patient: Patient? = nil) {
        self.fullName = fullName
        self.patient = patient
    }

    public struct Patient: Codable, Equatable {
        public var isOtherPerson: Bool?
        public var fullName: String?
        public var birthday: String?
        public var diagnosisDate: String?
        public var diagnosisType: String?
        public var biologicalSex: String?
        public var targetTimezone: String?
        public var targetDevices: [String]?
        public var about: String?

        public init(isOtherPerson: Bool,
                    fullName: String,
                    birthday: String,
                    diagnosisDate: String,
                    diagnosisType: String? = nil,
                    biologicalSex: String? = nil,
                    targetTimezone: String? = nil,
                    targetDevices: [String]? = nil,
                    about: String? = nil) {
            self.isOtherPerson = isOtherPerson
            self.fullName = fullName
            self.birthday = birthday
            self.diagnosisDate = diagnosisDate
            self.diagnosisType = diagnosisType
            self.biologicalSex = biologicalSex
            self.targetTimezone = targetTimezone
            self.targetDevices = targetDevices
            self.about = about
        }
    }
}
