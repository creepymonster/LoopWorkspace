//
//  TControllerSettingsDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/3/21.
//  Copyright © 2021 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TControllerSettingsDatumTests: XCTestCase {
    static let controllerSettings = TControllerSettingsDatum(time: Date.test,
                                                             device: TControllerSettingsDatumDeviceTests.device,
                                                             notifications: TControllerSettingsDatumNotificationsTests.notifications)
    static let controllerSettingsJSONDictionary: [String: Any] = [
        "type": "controllerSettings",
        "time": Date.testJSONString,
        "device": TControllerSettingsDatumDeviceTests.deviceJSONDictionary,
        "notifications": TControllerSettingsDatumNotificationsTests.notificationsJSONDictionary
    ]

    func testInitializer() {
        let controllerSettings = TControllerSettingsDatumTests.controllerSettings
        XCTAssertEqual(controllerSettings.device, TControllerSettingsDatumDeviceTests.device)
        XCTAssertEqual(controllerSettings.notifications, TControllerSettingsDatumNotificationsTests.notifications)
    }

    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TControllerSettingsDatumTests.controllerSettings, TControllerSettingsDatumTests.controllerSettingsJSONDictionary)
    }
}

class TControllerSettingsDatumDeviceTests: XCTestCase {
    static let device = TControllerSettingsDatum.Device(firmwareVersion: "1.2.3",
                                                        hardwareVersion: "2.3.4",
                                                        manufacturers: ["Acme", "Bravo"],
                                                        model: "XYZ Turbo",
                                                        name: "Super Controller",
                                                        serialNumber: "1234567890",
                                                        softwareVersion: "3.4.5")
    static let deviceJSONDictionary: [String: Any] = [
        "firmwareVersion": "1.2.3",
        "hardwareVersion": "2.3.4",
        "manufacturers": ["Acme", "Bravo"],
        "model": "XYZ Turbo",
        "name": "Super Controller",
        "serialNumber": "1234567890",
        "softwareVersion": "3.4.5"
    ]

    func testInitializer() {
        let device = TControllerSettingsDatumDeviceTests.device
        XCTAssertEqual(device.firmwareVersion, "1.2.3")
        XCTAssertEqual(device.hardwareVersion, "2.3.4")
        XCTAssertEqual(device.manufacturers, ["Acme", "Bravo"])
        XCTAssertEqual(device.model, "XYZ Turbo")
        XCTAssertEqual(device.name, "Super Controller")
        XCTAssertEqual(device.serialNumber, "1234567890")
        XCTAssertEqual(device.softwareVersion, "3.4.5")
    }

    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TControllerSettingsDatumDeviceTests.device, TControllerSettingsDatumDeviceTests.deviceJSONDictionary)
    }
}

class TControllerSettingsDatumNotificationsTests: XCTestCase {
    static let notifications = TControllerSettingsDatum.Notifications(authorization: .authorized,
                                                                      alert: true,
                                                                      criticalAlert: true,
                                                                      badge: true,
                                                                      sound: true,
                                                                      announcement: false,
                                                                      timeSensitive: true,
                                                                      scheduledDelivery: false,
                                                                      notificationCenter: false,
                                                                      lockScreen: false,
                                                                      alertStyle: .alert)
    static let notificationsJSONDictionary: [String: Any] = [
        "authorization": "authorized",
        "alert": true,
        "criticalAlert": true,
        "badge": true,
        "sound": true,
        "announcement": false,
        "timeSensitive": true,
        "scheduledDelivery": false,
        "notificationCenter": false,
        "lockScreen": false,
        "alertStyle": "alert"
    ]

    func testInitializer() {
        let notifications = TControllerSettingsDatumNotificationsTests.notifications
        XCTAssertEqual(notifications.authorization, .authorized)
        XCTAssertEqual(notifications.alert, true)
        XCTAssertEqual(notifications.criticalAlert, true)
        XCTAssertEqual(notifications.badge, true)
        XCTAssertEqual(notifications.sound, true)
        XCTAssertEqual(notifications.announcement, false)
        XCTAssertEqual(notifications.timeSensitive, true)
        XCTAssertEqual(notifications.scheduledDelivery, false)
        XCTAssertEqual(notifications.notificationCenter, false)
        XCTAssertEqual(notifications.lockScreen, false)
        XCTAssertEqual(notifications.alertStyle, .alert)
    }

    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TControllerSettingsDatumNotificationsTests.notifications, TControllerSettingsDatumNotificationsTests.notificationsJSONDictionary)
    }
}

class TControllerSettingsDatumNotificationsAuthorizationTests: XCTestCase {
    func testTraining() {
        XCTAssertEqual(TControllerSettingsDatum.Notifications.Authorization.notDetermined.rawValue, "notDetermined")
        XCTAssertEqual(TControllerSettingsDatum.Notifications.Authorization.denied.rawValue, "denied")
        XCTAssertEqual(TControllerSettingsDatum.Notifications.Authorization.authorized.rawValue, "authorized")
        XCTAssertEqual(TControllerSettingsDatum.Notifications.Authorization.provisional.rawValue, "provisional")
        XCTAssertEqual(TControllerSettingsDatum.Notifications.Authorization.ephemeral.rawValue, "ephemeral")
    }
}

class TControllerSettingsDatumNotificationsAlertStyleTests: XCTestCase {
    func testTraining() {
        XCTAssertEqual(TControllerSettingsDatum.Notifications.AlertStyle.none.rawValue, "none")
        XCTAssertEqual(TControllerSettingsDatum.Notifications.AlertStyle.alert.rawValue, "alert")
        XCTAssertEqual(TControllerSettingsDatum.Notifications.AlertStyle.banner.rawValue, "banner")
    }
}

extension TControllerSettingsDatum {
    func isEqual(to other: TControllerSettingsDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.device == other.device &&
            self.notifications == other.notifications
    }
}
