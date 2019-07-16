//
//  CustomCell.swift
//  Anchorage
//
//  Created by Isaak Meier on 7/15/19.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {

    private let reason = UILabel()
    private let amount = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setReasonandAmount(reason: String, amount: Double) {
        self.reason.text = reason
        self.amount.text = String(amount)
    }
}

private extension CustomCell {
    func configureView() {

        // View Heirarchy
        let customView = UIView()
        self.contentView.addSubview(customView)
        customView.addSubview(reason)
        customView.addSubview(amount)

        // Style
        customView.backgroundColor = UIColor.red
        customView.layer.borderColor = UIColor.black.cgColor
        customView.layer.borderWidth = 1
        customView.layer.cornerRadius = 16
        customView.clipsToBounds = true
        // self.expenseTable.addSubview(cell)

        // Layout
        // customView.leadingAnchor == self.view.leadingAnchor
    }
}
