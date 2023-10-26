//
//  TPrescriptionClaim.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 4/27/21.
//  Copyright © 2021 Tidepool Project. All rights reserved.
//

public struct TPrescriptionClaim: Codable, Equatable {
    public var accessCode: String
    public var birthday: String
    
    public init(accessCode: String, birthday: String) {
        self.accessCode = accessCode
        self.birthday = birthday
    }
}
