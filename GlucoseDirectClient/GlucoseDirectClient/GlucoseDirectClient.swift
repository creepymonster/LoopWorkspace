//
//  GlucoseDirectClient.swift
//  GlucoseDirectClient
//

import Combine
import Foundation
import HealthKit
import LoopKit

// MARK: - GlucoseDirectClient

class GlucoseDirectClient {
    // MARK: Lifecycle

    init(_ sharedDefaults: UserDefaults?) {
        self.sharedDefaults = sharedDefaults
    }

    // MARK: Internal

    func fetchLast(_ n: Int) throws -> [ClientGlucose] {
        do {
            guard let sharedData = sharedDefaults?.data(forKey: "latestReadings") else {
                throw ClientError.fetchError
            }

            let decoded = try? JSONSerialization.jsonObject(with: sharedData, options: [])
            guard let sgvs = decoded as? [AnyObject] else {
                throw ClientError.dataError(reason: "Failed to decode SGVs as array from recieved data.")
            }

            var transformed: [ClientGlucose] = []
            for sgv in sgvs.suffix(n) {
                if let from = sgv["from"] as? String {
                    guard from == "GlucoseDirect" else {
                        continue
                    }
                }

                if let glucose = sgv["Value"] as? Int, let trend = sgv["Trend"] as? Int, let dt = sgv["DT"] as? String {
                    // only add glucose readings in a valid range - skip unrealistically low or high readings, isStateValid: <#Bool#>
                    // this does also prevent negative glucose values from being cast to UInt16
                    transformed.append(ClientGlucose(sgv: glucose, trend: trend, date: try parseDate(dt), filtered: nil, noise: nil))
                } else {
                    throw ClientError.dataError(reason: "Failed to decode an SGV record.")
                }
            }

            return transformed
        } catch let error as ClientError {
            throw error
        } catch {
            throw ClientError.fetchError
        }
    }

    // MARK: Private

    private let sharedDefaults: UserDefaults?

    private func parseDate(_ wt: String) throws -> Date {
        // wt looks like "/Date(1462404576000)/"
        let re = try NSRegularExpression(pattern: "\\((.*)\\)")
        if let match = re.firstMatch(in: wt, range: NSMakeRange(0, wt.count)) {
            #if swift(>=4)
                let matchRange = match.range(at: 1)
            #else
                let matchRange = match.rangeAt(1)
            #endif

            let epoch = Double((wt as NSString).substring(with: matchRange))! / 1000

            return Date(timeIntervalSince1970: epoch)
        } else {
            throw ClientError.dateError
        }
    }
}

// MARK: - ClientError

public enum ClientError: Error {
    case fetchError
    case dataError(reason: String)
    case dateError
}

// MARK: - ClientGlucose

public struct ClientGlucose: Codable {
    public let sgv: Int?
    public let trend: Int
    public let date: Date
    public let filtered: Double?
    public let noise: Int?

    public var glucose: Int { sgv ?? 0 }
}

// MARK: GlucoseValue

extension ClientGlucose: GlucoseValue {
    public var isStateValid: Bool { true }
    public var startDate: Date { date }
    public var quantity: HKQuantity { .init(unit: .milligramsPerDeciliter, doubleValue: Double(glucose)) }
}

// MARK: GlucoseDisplayable

extension ClientGlucose: GlucoseDisplayable {
    public var trendType: GlucoseTrend? { GlucoseTrend(rawValue: trend) }
    public var isLocal: Bool { false }

    // TODO: Placeholder. This functionality will come with LOOP-1311
    public var glucoseRangeCategory: GlucoseRangeCategory? {
        return nil
    }

    public var trendRate: HKQuantity? {
        return nil
    }
}

extension HKUnit {
    static let milligramsPerDeciliter: HKUnit = HKUnit.gramUnit(with: .milli).unitDivided(by: .literUnit(with: .deci))
}
