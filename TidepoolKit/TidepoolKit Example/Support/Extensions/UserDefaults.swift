//
//  UserDefaults.swift
//  TidepoolKit Example
//
//  Created by Darin Krauss on 2/21/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import Foundation
import TidepoolKit

extension UserDefaults {
    private enum Key: String {
        case environment = "org.tidepool.TidepoolKit-Example.environment"
        case session = "org.tidepool.TidepoolKit-Example.session"
        case dataSetId = "org.tidepool.TidepoolKit-Example.dataSetId"
    }

    var environment: TEnvironment? {
        get {
            guard let data = data(forKey: Key.environment.rawValue) else {
                return nil
            }
            return try? JSONDecoder.tidepool.decode(TEnvironment.self, from: data)
        }
        set {
            set(try! JSONEncoder.tidepool.encode(newValue), forKey: Key.environment.rawValue)
        }
    }

    // NOTE: The recommended mechanism to persist a Tidepool session is via the OS keychain. However,
    // for example purposes ONLY, use UserDefaults.
    var session: TSession? {
        get {
            guard let data = data(forKey: Key.session.rawValue) else {
                return nil
            }
            return try? JSONDecoder.tidepool.decode(TSession.self, from: data)
        }
        set {
            set(try! JSONEncoder.tidepool.encode(newValue), forKey: Key.session.rawValue)
        }
    }

    var dataSetId: String? {
        get {
            return string(forKey: Key.dataSetId.rawValue)
        }
        set {
            set(newValue, forKey: Key.dataSetId.rawValue)
        }
    }
}
