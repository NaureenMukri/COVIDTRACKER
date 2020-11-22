//
//  CheckableTableViewCell.swift
//  Fit5140_ChatBot
//
//  Created by Naureen Mukri on 22/11/20.
//  Copyright © 2020 Monash University. All rights reserved.
//

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
