//
//  CustomCell.swift
//  Anchorage
//
//  Created by Isaak Meier on 7/15/19.
//

import Foundation
import UIKit
import Anchorage

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
        self.amount.text = "$" + String(amount)
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
        customView.backgroundColor = Constants.moneyGreen
        customView.layer.borderColor = UIColor.black.cgColor
        customView.layer.borderWidth = 1
        customView.layer.cornerRadius = 16
        customView.clipsToBounds = true
        reason.font = Constants.montBoldSmall
        amount.font = Constants.montBoldSmall

        // Layout
        // let insets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        // contentView.layoutMargins = insets

        contentView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        customView.heightAnchor == self.contentView.heightAnchor
        customView.leadingAnchor == self.contentView.leadingAnchor + 10
        customView.trailingAnchor == self.contentView.trailingAnchor - 10

        reason.leadingAnchor == customView.leadingAnchor + 20
        reason.centerYAnchor == customView.centerYAnchor

        reason.trailingAnchor == amount.leadingAnchor

        amount.trailingAnchor == customView.trailingAnchor - 20
        amount.centerYAnchor == customView.centerYAnchor

        // customView.leadingAnchor == self.contentView.leadingAnchor + 10

    }
}
