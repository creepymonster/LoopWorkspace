//
//  TextViewController.swift
//  TidepoolKit Example
//
//  Created by Darin Krauss on 2/21/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import UIKit
import TidepoolKit

class TextViewController: UIViewController {
    private let text: String
    private var textView: UITextView?

    init(text: String, withTitle title: String? = nil) {
        self.text = text

        super.init(nibName: nil, bundle: nil)

        self.title = title ?? NSLocalizedString("Text", comment: "The title of the text view controller")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        textView = UITextView()
        view = textView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        textView?.contentInsetAdjustmentBehavior = .always
        textView?.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.monospacedSystemFont(ofSize: 12, weight: .regular))
        textView?.isEditable = false
        textView?.text = text

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
    }

    @objc func share() {
        let activityItem = UTF8TextFileActivityItem(name: title!.replacingOccurrences(of: " ", with: "-"))
        if let error = activityItem.write(text: text) {
            present(UIAlertController(error: error), animated: true)
        } else {
            present(UIActivityViewController(activityItems: [activityItem], applicationActivities: nil), animated: true)
        }
    }
}
