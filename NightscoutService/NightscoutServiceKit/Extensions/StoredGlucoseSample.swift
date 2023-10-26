//
//  StoredGlucoseSample.swift
//  NightscoutServiceKit
//
//  Created by Darin Krauss on 10/13/19.
//  Copyright © 2019 LoopKit Authors. All rights reserved.
//

import LoopKit
import NightscoutKit

extension StoredGlucoseSample {

    var glucoseEntry: GlucoseEntry {
        let glucoseTrend: GlucoseEntry.GlucoseTrend?
        if let trend = trend {
            glucoseTrend = GlucoseEntry.GlucoseTrend(rawValue: trend.rawValue)
        } else {
            glucoseTrend = nil
        }

        let deviceString: String

        if let device = device, let manufacturer = device.manufacturer, let model = device.model, let software = device.softwareVersion {
            deviceString = "loop://\(manufacturer)/\(model)/\(software)"
        } else {
            deviceString = "loop://\(UIDevice.current.name)"
        }

        return GlucoseEntry(
            glucose: quantity.doubleValue(for: .milligramsPerDeciliter),
            date: startDate,
            device: deviceString,
            glucoseType: wasUserEntered ? .meter : .sensor,
            trend: glucoseTrend,
            changeRate: trendRate?.doubleValue(for: .milligramsPerDeciliterPerMinute),
            isCalibration: isDisplayOnly
        )
    }

}
