//
//  TextButtonTableViewCell.swift
//  TidepoolKit Example
//
//  Created by Darin Krauss on 1/22/20.
//  Copyright © 2020 Tidepool Project. All rights reserved.
//

import UIKit

class TextButtonTableViewCell: LoadingTableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        textLabel?.tintAdjustmentMode = .automatic
        textLabel?.textColor = tintColor
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    var isEnabled = true {
        didSet {
            tintAdjustmentMode = isEnabled ? .normal : .dimmed
            selectionStyle = isEnabled ? .default : .none
        }
    }

    override func tintColorDidChange() {
        super.tintColorDidChange()

        textLabel?.textColor = tintColor
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        textLabel?.textColor = tintColor
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        textLabel?.textAlignment = .natural
        tintColor = nil
        isEnabled = true
    }
}

extension TextButtonTableViewCell: IdentifiableClass {}
