//
//  TError.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 2/17/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import Foundation

/// All errors reported by TidepoolKit.
public enum TError: Error {

    /// A general network error not covered by another more specific error. May include a more detailed OS-level error.
    case network(Error?)

    /// The session is missing.
    case sessionMissing

    /// The request was invalid and not sent.
    case requestInvalid

    /// The server responded that the request was bad or malformed. Equivalent to HTTP status code 400.
    case requestMalformed(HTTPURLResponse, Data?)

    /// The server responded that the request was bad or malformed with details. Equivalent to HTTP status code 400.
    case requestMalformedJSON(HTTPURLResponse, Data, [Detail])

    /// The server responded that the request was not authenticated. Equivalent to HTTP status code 401.
    case requestNotAuthenticated(HTTPURLResponse, Data?)

    /// The server responded that the request was authenticated, but not authorized. Equivalent to HTTP status code 403.
    case requestNotAuthorized(HTTPURLResponse, Data?)

    /// The server responded that the email for the authenticated user is not verified.
    case requestEmailNotVerified(HTTPURLResponse, Data?)

    /// The server responded that the Terms of Service for the authenticated user are not accepted.
    case requestTermsOfServiceNotAccepted(HTTPURLResponse, Data?)

    /// The server responded that the requested resource was not found. Equivalent to HTTP status code 404.
    case requestResourceNotFound(HTTPURLResponse, Data?)

    /// The server response was unexpected (not HTTP).
    case responseUnexpected(URLResponse?, Data?)

    /// The server response included an unexpected HTTP status code, namely anything other than those specified above and 200-299 (success).
    case responseUnexpectedStatusCode(HTTPURLResponse, Data?)

    /// The server response did not include required authentication. Specifically, the X-Tidepool-Session-Token header was missing.
    case responseNotAuthenticated(HTTPURLResponse, Data?)

    /// The server response did not include JSON in the body.
    case responseMissingJSON(HTTPURLResponse)

    /// The server response did not include valid JSON in the body.
    case responseMalformedJSON(HTTPURLResponse, Data, Error)

    /// The server response included valid, but unexpected, JSON in the body.
    case responseUnexpectedJSON(HTTPURLResponse, Data)

    /// The server response included malformed data.
    case responseMalformedData(HTTPURLResponse, Data)

    public struct Detail: Codable, Equatable {
        public var code: String
        public var title: String
        public var detail: String
        public var status: Int?
        public var source: Source?
        public var meta: TDictionary?

        public struct Source: Codable, Equatable {
            public var parameter: String?
            public var pointer: String?
        }
    }
}

extension TError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .network:
            return NSLocalizedString("A network error occurred.", comment: "The default localized description of the network error")
        case .sessionMissing:
            return NSLocalizedString("The session is missing.", comment: "The default localized description of the session missing error")
        case .requestInvalid:
            return NSLocalizedString("The request was invalid.", comment: "The default localized description of the request invalid error")
        case .requestMalformed:
            return NSLocalizedString("The request was invalid.", comment: "The default localized description of the request malformed error")
        case .requestMalformedJSON:
            return NSLocalizedString("The request was invalid.", comment: "The default localized description of the request malformed JSON error")
        case .requestNotAuthenticated:
            return NSLocalizedString("The request was not authenticated.", comment: "The default localized description of the request not authenticated error")
        case .requestNotAuthorized:
            return NSLocalizedString("The request was not authorized.", comment: "The default localized description of the request not authorized error")
        case .requestEmailNotVerified:
            return NSLocalizedString("The email is not verified.", comment: "The default localized description of the request email not verified error")
        case .requestTermsOfServiceNotAccepted:
            return NSLocalizedString("The Terms of Service are not accepted.", comment: "The default localized description of the request terms of service not accepted error")
        case .requestResourceNotFound:
            return NSLocalizedString("The requested resource was not found.", comment: "The default localized description of the request resource not found error")
        case .responseUnexpected:
            return NSLocalizedString("The request returned an unexpected response.", comment: "The default localized description of the response unexpected error")
        case .responseUnexpectedStatusCode:
            return NSLocalizedString("The request returned an unexpected response status code.", comment: "The default localized description of the response unexpected status code error")
        case .responseNotAuthenticated:
            return NSLocalizedString("The request returned an unauthenticated response.", comment: "The default localized description of the response not authenticated error")
        case .responseMissingJSON:
            return NSLocalizedString("The request returned an empty JSON response.", comment: "The default localized description of the response missing JSON error")
        case .responseMalformedJSON:
            return NSLocalizedString("The request returned an invalid JSON response.", comment: "The default localized description of the response malformed JSON error")
        case .responseUnexpectedJSON:
            return NSLocalizedString("The request returned an unexpected JSON response.", comment: "The default localized description of the response unexpected JSON error")
        case .responseMalformedData:
            return NSLocalizedString("The request returned an invalid response.", comment: "The default localized description of the response malformed data error")
        }
    }
}
