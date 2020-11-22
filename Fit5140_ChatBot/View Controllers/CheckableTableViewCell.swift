//
//  CheckableTableViewCell.swift
//  Fit5140_ChatBot
//
//  Created by Naureen Mukri on 22/11/20.
//  Copyright © 2020 Monash University. All rights reserved.
//
//  References : 1. https://stackoverflow.com/questions/37118812/how-to-make-checklist-in-uitableview-swift
// 2. https://stackoverflow.com/questions/36513969/check-uncheck-the-check-box-by-tapping-the-cell-in-table-view-and-how-to-know

import UIKit

class CheckableTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .default
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }

}
