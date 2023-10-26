//
//  DNS+TEnvironment.swift
//  TidepoolKit
//
//  Created by Darin Krauss on 2/17/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

extension DNSSRVRecord {
    var environment: TEnvironment {
        return TEnvironment(host: host, port: port)
    }
}

extension Array where Element == DNSSRVRecord {
    var environments: [TEnvironment] { map { $0.environment } }
}
