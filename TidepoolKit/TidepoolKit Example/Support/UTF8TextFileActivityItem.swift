//
//  UTF8TextFileActivityItem.swift
//  TidepoolKit Example
//
//  Created by Darin Krauss on 2/21/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import Foundation
import UIKit

class UTF8TextFileActivityItem: NSObject, UIActivityItemSource {
    private let name: String
    private let url: URL

    init(name: String, withTimestamp timestamp: Date? = Date()) {
        if let timestamp = timestamp {
            self.name = "\(name)-\(Self.timestampFormatter.string(from: timestamp)).txt"
        } else {
            self.name = "\(name).txt"
        }
        self.url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(self.name, isDirectory: false)

        super.init()
    }

    func write(text: String) -> Error? {
        do {
            try text.write(to: url, atomically: true, encoding: .utf8)
            return nil
        } catch let error {
            return error
        }
    }

    // MARK: - UIActivityItemSource

    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return url
    }

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return url
    }

    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return name
    }

    func activityViewController(_ activityViewController: UIActivityViewController, dataTypeIdentifierForActivityType activityType: UIActivity.ActivityType?) -> String {
        return "public.utf8-plain-text"
    }

    private static let timestampFormatter: DateFormatter = {
        let timestampFormatter = DateFormatter()
        timestampFormatter.dateFormat = "yyyy-MM-dd'T'HH-mm-ss"
        timestampFormatter.timeZone = .current
        return timestampFormatter
    }()
}
