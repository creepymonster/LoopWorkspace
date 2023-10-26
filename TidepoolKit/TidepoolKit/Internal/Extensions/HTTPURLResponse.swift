//
//  HTTPURLResponse.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 2/19/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    func value(forHTTPHeaderField field: String) -> String? {
        let fieldLowercased = field.lowercased()
        for (key, value) in allHeaderFields {
            if let key = key as? String {
                if key.lowercased() == fieldLowercased {
                    return value as? String
                }
            }
        }
        return nil
    }
}
