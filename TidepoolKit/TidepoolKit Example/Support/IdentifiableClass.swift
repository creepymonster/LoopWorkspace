//
//  IdentifiableClass.swift
//  TidepoolKit Example
//
//  Created by Darin Krauss on 2/21/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

protocol IdentifiableClass: AnyObject {
    static var className: String { get }
}

extension IdentifiableClass {
    static var className: String { String(describing: self) }
}
