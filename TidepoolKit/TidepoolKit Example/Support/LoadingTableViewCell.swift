//
//  LoadingTableViewCell.swift
//  TidepoolKit Example
//
//  Created by Darin Krauss on 2/21/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    var isLoading = false {
        didSet {
            if isLoading {
                let activityIndicatorView = UIActivityIndicatorView(style: .medium)
                accessoryView = activityIndicatorView
                activityIndicatorView.startAnimating()
            } else {
                accessoryView = nil
            }
        }
    }

    func stopLoading() {
        self.isLoading = false
    }
}
