//
//  NameAndProgessView.swift
//  Perfect Budget
//
//  Created by Isaak Meier on 7/11/19.
//  Copyright © 2019 Isaak Meier. All rights reserved.
//

import Foundation
import UIKit
import Anchorage

class NameAndProgessView: UIView {

    private let dayName = UILabel()
    private let dailySpending = UILabel()
    private let addCash = UIButton()
    private let progessBar = ProgessBarView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Quick function to get name of day of week from date
    // Move this to the model, make it build on init? Just make the model store a date that updates daily haha
    func getDayOfWeek() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)
        return dayInWeek
    }
}

private extension NameAndProgessView {
    func configureView() {

        // View Heirarchy
        // self.addSubview(addCash)
        self.addSubview(dayName)
        self.addSubview(progessBar)
        self.addSubview(dailySpending)

        // Style
        dayName.textColor = .black
        guard let customFont2 = UIFont(name: "Montserrat-Bold", size: 16) else {
            fatalError("""
            Failed to load the "Montserrat-Black" font.
            Make sure the font file is included in the project and the font name is correct
            """)
        }
        dayName.font = UIFontMetrics.default.scaledFont(for: customFont1)
        dailySpending.font = UIFontMetrics.default.scaledFont(for: customFont2)
        dayName.adjustsFontForContentSizeCategory = true
        dailySpending.adjustsFontForContentSizeCategory = true
        dayName.text = getDayOfWeek()
        dailySpending.text = "Daily Spending"

        // Layout
        // Center in the middle of the screen
        dayName.centerXAnchor == self.centerXAnchor
        progessBar.centerXAnchor == self.centerXAnchor
        // Move a nice distance from the top
        dayName.topAnchor == self.topAnchor + 50
        progessBar.topAnchor == dayName.bottomAnchor + 50
        progessBar.widthAnchor == self.widthAnchor - 20
        progessBar.heightAnchor == self.heightAnchor / 6

        dailySpending.leadingAnchor == self.leadingAnchor + 10
        dailySpending.bottomAnchor == progessBar.topAnchor - 10

    }
}
