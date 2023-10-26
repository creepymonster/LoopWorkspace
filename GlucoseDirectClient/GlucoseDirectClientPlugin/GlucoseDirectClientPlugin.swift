//
//  GlucoseDirectClientPlugin.swift
//  GlucoseDirectClientPlugin
//
//  Created by Bill Gestrich on 8/18/21.
//  Copyright © 2021 Ivan Valkou. All rights reserved.
//

import GlucoseDirectClient
import GlucoseDirectClientUI
import LoopKitUI
import os.log

class GlucoseDirectClientPlugin: NSObject, CGMManagerUIPlugin {
    // MARK: Lifecycle

    override init() {
        super.init()
        log.default("Instantiated")
    }

    // MARK: Public

    public var cgmManagerType: CGMManagerUI.Type? {
        GlucoseDirectManager.self
    }

    // MARK: Private

    private let log = OSLog(category: "GlucoseDirectClientPlugin")
}
