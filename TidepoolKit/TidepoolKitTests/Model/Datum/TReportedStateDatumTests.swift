//
//  TReportedStateDatumTests.swift
//  TidepoolKitTests
//
//  Created by Darin Krauss on 11/8/19.
//  Copyright © 2019 Tidepool Project. All rights reserved.
//

import XCTest
import TidepoolKit

class TReportedStateDatumTests: XCTestCase {
    static let reportedState = TReportedStateDatum(time: Date.test,
                                                   states: [TReportedStateDatumStateTests.state, TReportedStateDatumStateTests.state])
    static let reportedStateJSONDictionary: [String: Any] = [
        "type": "reportedState",
        "time": Date.testJSONString,
        "states": [TReportedStateDatumStateTests.stateJSONDictionary, TReportedStateDatumStateTests.stateJSONDictionary]
    ]
    
    func testInitializer() {
        let reportedState = TReportedStateDatumTests.reportedState
        XCTAssertEqual(reportedState.states, [TReportedStateDatumStateTests.state, TReportedStateDatumStateTests.state])
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TReportedStateDatumTests.reportedState, TReportedStateDatumTests.reportedStateJSONDictionary)
    }
}

class TReportedStateDatumStateTests: XCTestCase {
    static let state = TReportedStateDatum.State(.other, stateOther: "confused", severity: 10)
    static let stateJSONDictionary: [String: Any] = [
        "state": "other",
        "stateOther": "confused",
        "severity": 10
    ]
    
    func testInitializer() {
        let state = TReportedStateDatumStateTests.state
        XCTAssertEqual(state.state, .other)
        XCTAssertEqual(state.stateOther, "confused")
        XCTAssertEqual(state.severity, 10)
    }
    
    func testCodableAsJSON() {
        XCTAssertCodableAsJSON(TReportedStateDatumStateTests.state, TReportedStateDatumStateTests.stateJSONDictionary)
    }
}

class TReportedStateDatumStateStateTests: XCTestCase {
    func testState() {
        XCTAssertEqual(TReportedStateDatum.State.State.alcohol.rawValue, "alcohol")
        XCTAssertEqual(TReportedStateDatum.State.State.cycle.rawValue, "cycle")
        XCTAssertEqual(TReportedStateDatum.State.State.hyperglycemiaSymptoms.rawValue, "hyperglycemiaSymptoms")
        XCTAssertEqual(TReportedStateDatum.State.State.hypoglycemiaSymptoms.rawValue, "hypoglycemiaSymptoms")
        XCTAssertEqual(TReportedStateDatum.State.State.illness.rawValue, "illness")
        XCTAssertEqual(TReportedStateDatum.State.State.other.rawValue, "other")
        XCTAssertEqual(TReportedStateDatum.State.State.stress.rawValue, "stress")
    }
}

extension TReportedStateDatum {
    func isEqual(to other: TReportedStateDatum) -> Bool {
        return super.isEqual(to: other) &&
            self.states == other.states
    }
}
