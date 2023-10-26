//
//  AmplitudeService.swift
//  AmplitudeServiceKit
//
//  Created by Darin Krauss on 6/20/19.
//  Copyright © 2019 LoopKit Authors. All rights reserved.
//

import Amplitude
import LoopKit

public final class AmplitudeService: Service {

    public static let serviceIdentifier = "AmplitudeService"

    public static let localizedTitle = LocalizedString("Amplitude", comment: "The title of the Amplitude service")

    public weak var serviceDelegate: ServiceDelegate?

    public var apiKey: String?

    private var client: Amplitude?

    public init() {}

    public init?(rawState: RawStateValue) {
        self.apiKey = try? KeychainManager().getAmplitudeAPIKey()
        createClient()
    }

    public var rawState: RawStateValue {
        return [:]
    }

    public let isOnboarded = true   // No distinction between created and onboarded

    public var hasConfiguration: Bool { return apiKey?.isEmpty == false }

    public func completeCreate() {
        try! KeychainManager().setAmplitudeAPIKey(apiKey)
        createClient()
    }

    public func completeUpdate() {
        try! KeychainManager().setAmplitudeAPIKey(apiKey)
        createClient()
        serviceDelegate?.serviceDidUpdateState(self)
    }

    public func completeDelete() {
        try! KeychainManager().setAmplitudeAPIKey()
        serviceDelegate?.serviceWantsDeletion(self)
    }

    private func createClient() {
        if let apiKey = apiKey {
            let amplitude = Amplitude()
            amplitude.setTrackingOptions(AMPTrackingOptions().disableCity().disableCarrier().disableIDFA().disableLatLng())
            amplitude.initializeApiKey(apiKey)
            client = amplitude
        } else {
            client = nil
        }
    }

}

extension AmplitudeService: AnalyticsService {
    public func recordAnalyticsEvent(_ name: String, withProperties properties: [AnyHashable: Any]?, outOfSession: Bool) {
        client?.logEvent(name, withEventProperties: properties, outOfSession: outOfSession)
    }

    public func recordIdentify(_ property: String, value: String) {
        client?.identify(AMPIdentify().set(property, value: value as NSString))
    }
}

extension KeychainManager {

    func setAmplitudeAPIKey(_ amplitudeAPIKey: String? = nil) throws {
        try replaceGenericPassword(amplitudeAPIKey, forService: AmplitudeAPIKeyService)
    }

    func getAmplitudeAPIKey() throws -> String {
        return try getGenericPasswordForService(AmplitudeAPIKeyService)
    }

}

fileprivate let AmplitudeAPIKeyService = "AmplitudeAPIKey"
