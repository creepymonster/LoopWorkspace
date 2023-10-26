//
//  UserDefaults.swift
//  TidepoolKit
//
//  Created by Rick Pasetto on 10/15/21.
//  Copyright © 2021 Tidepool Project. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    // This allows TidepoolKit host apps to configure the default Tidepool environment by storing a TEnvironment in a
    // App Group (denoted by the special key "AppGroupIdentifier" -- see below) under the key "org.tidepool.TidepoolKit.DefaultEnvironment".
    public static let appGroup = UserDefaults(suiteName: Bundle.main.appGroupSuiteName)

    private enum Key: String {
        case defaultEnvironment = "org.tidepool.TidepoolKit.DefaultEnvironment"
    }
    
    var defaultEnvironment: TEnvironment? {
        get {
            guard let data = data(forKey: Key.defaultEnvironment.rawValue) else {
                return nil
            }
            return try? JSONDecoder.tidepool.decode(TEnvironment.self, from: data)
        }
        set {
            set(try? JSONEncoder.tidepool.encode(newValue), forKey: Key.defaultEnvironment.rawValue)
        }
    }

}

extension Bundle {
    fileprivate var appGroupSuiteName: String? { string(forInfoDictionaryKey: "AppGroupIdentifier") }
}
