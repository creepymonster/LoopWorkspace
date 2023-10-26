//
//  StatusTableViewCell.swift
//  TidepoolKit Example
//
//  Created by Darin Krauss on 2/17/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import UIKit

class StatusTableViewCell: UITableViewCell {
    @IBOutlet weak var environmentLabel: UILabel!
    @IBOutlet weak var authenticationTokenLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var dataSetIdLabel: UILabel!

    override public func prepareForReuse() {
        super.prepareForReuse()
        
        environmentLabel?.text = nil
        authenticationTokenLabel?.text = nil
        userIdLabel?.text = nil
        dataSetIdLabel?.text = nil
    }
}

extension StatusTableViewCell: IdentifiableClass {}
