//
//  UIAlertController.swift
//  TidepoolKit Example
//
//  Created by Darin Krauss on 2/21/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import UIKit
import TidepoolKit

extension UIAlertController {
    convenience init(error: Error, handler: (() -> Void)? = nil) {
        self.init(errorString: error.localizedDescription, handler: handler)
    }

    convenience init(error: String, handler: (() -> Void)? = nil) {
        self.init(errorString: error, handler: handler)
    }

    private convenience init(errorString: String, handler: (() -> Void)? = nil) {
        self.init(title: NSLocalizedString("Error", comment: "The title of the error alert"), message: errorString, preferredStyle: .alert)
        addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "The title of the OK button in the error alert"), style: .default) { _ in handler?() })
    }
}
