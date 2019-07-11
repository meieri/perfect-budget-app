//
//  ViewController.swift
//  Perfect Budget
//
//  Created by Isaak Meier on 7/10/19.
//  Copyright © 2019 Isaak Meier. All rights reserved.
//
// One single change

import UIKit
import Anchorage

class DayViewController: UIViewController {

    let dayName: UILabel

    init() {
        self.dayName = UILabel()
        super.init(nibName: nil, bundle: nil)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
}

private extension DayViewController {
    func configureViews() {

        // View Heirarchy
        // Need to add label as subview in order for it to be drawn
        self.view.addSubview(dayName)

        // Style
        self.view.backgroundColor = .white
        dayName.textColor = .black
        guard let customFont = UIFont(name: "Montserrat-Bold", size: 20) else {
            fatalError("""
            Failed to load the "Montserrat-Black" font.
            Make sure the font file is included in the project and the font name is correct
            """)
        }

        // Layout
        // Center the label in the middle of the screen
        dayName.centerXAnchor == self.view.centerXAnchor
        // dayName.centerAnchors == self.centerAnchors.first

        // dayName.topAnchor == self.verticalAnchors.first / 4
        // Move the label a nice distance from the top
        dayName.topAnchor == self.view.bottomAnchor / 10

        dayName.font = UIFontMetrics.default.scaledFont(for: customFont)
        dayName.adjustsFontForContentSizeCategory = true
        dayName.text = getDayOfWeek()
    }
}
