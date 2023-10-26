//
//  LoopOnboardingUI.swift
//  LoopOnboardingKitUI
//
//  Created by Darin Krauss on 1/23/21.
//  Copyright © 2021 LoopKit Authors. All rights reserved.
//

import SwiftUI
import HealthKit
import LoopKit
import LoopKitUI
import LoopOnboardingKit

public final class LoopOnboardingUI: OnboardingUI {
    public static func createOnboarding() -> OnboardingUI {
        return Self()
    }

    public weak var onboardingDelegate: OnboardingDelegate?

    public let onboardingIdentifier = "LoopOnboarding"

    public var isOnboarded: Bool {
        didSet {
            guard isOnboarded != oldValue else { return }
            notifyDidUpdateState()
        }
    }

    var therapySettings: TherapySettings? {
        didSet {
            guard therapySettings != oldValue, let therapySettings = therapySettings else { return }
            notifyHasNewTherapySettings(therapySettings)
        }
    }

    init() {
        self.isOnboarded = false
    }

    public init?(rawState: RawState) {
        guard let isOnboarded = rawState["isOnboarded"] as? Bool else {
            return nil
        }

        self.isOnboarded = isOnboarded
    }

    public var rawState: RawState {
        return [
            "isOnboarded": isOnboarded
        ]
    }

    public func onboardingViewController(onboardingProvider: OnboardingProvider, displayGlucoseUnitObservable: DisplayGlucoseUnitObservable, colorPalette: LoopUIColorPalette) -> (UIViewController & OnboardingViewController) {
        return OnboardingUICoordinator(onboarding: self, onboardingProvider: onboardingProvider, initialTherapySettings: onboardingProvider.onboardingTherapySettings, displayGlucoseUnitObservable: displayGlucoseUnitObservable, colorPalette: colorPalette)
    }

    private func notifyDidUpdateState() {
        onboardingDelegate?.onboardingDidUpdateState(self)
    }

    private func notifyHasNewTherapySettings(_ therapySettings: TherapySettings) {
        onboardingDelegate?.onboarding(self, hasNewTherapySettings: therapySettings)
    }
}
