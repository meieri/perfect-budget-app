//
//  ButtonCell.swift
//  Perfect Budget
//
//  Created by Isaak Meier on 7/24/19.
//  Copyright © 2019 Isaak Meier. All rights reserved.
//

import Foundation
import UIKit
import Anchorage

class ButtonCell: UITableViewCell {

    var presenter: DayViewPresenter!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

private extension ButtonCell {

    func configureView() {
        // View Heirarchy
        // self.addSubview(addExpense)
        // View Layout
        contentView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }

}
