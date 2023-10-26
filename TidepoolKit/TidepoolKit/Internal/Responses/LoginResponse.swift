//
//  LoginResponse.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 2/20/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

struct LoginResponse: Codable, Equatable {
    let userId: String
    let email: String
    let emailVerified: Bool
    let termsAccepted: String?

    init(userId: String, email: String, emailVerified: Bool = false, termsAccepted: String? = nil) {
        self.userId = userId
        self.email = email
        self.emailVerified = emailVerified
        self.termsAccepted = termsAccepted
    }

    private enum CodingKeys: String, CodingKey {
        case userId = "userid"
        case email = "username"
        case emailVerified
        case termsAccepted
    }
}
