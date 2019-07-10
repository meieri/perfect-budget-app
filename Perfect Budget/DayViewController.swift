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

    func setupConstraints() {
        dayName.centerXAnchor == self.centerAnchors.first
        dayName.topAnchor == self.verticalAnchors.first / 4
    }

    // Quick function to get name of day of week from date
    func getDayOfWeek() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)
        return dayInWeek
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
        self.setupConstraints()
    }

    func initViews() {
        dayName.textColor = .black
        // Need to add label as subview in order for it to be drawn
        self.view.addSubview(dayName)
        self.view.backgroundColor = .white

        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Front names: \(names)")
        }

        guard let customFont = UIFont(name: "Montserrat-Black", size: UIFont.labelFontSize) else {
            fatalError("""
            Failed to load the "Montserrat-Black" font.
            Make sure the font file is included in the project and the font name is correct
            """)
        }
        dayName.font = UIFontMetrics.default.scaledFont(for: customFont)
        dayName.adjustsFontForContentSizeCategory = true
        dayName.text = getDayOfWeek()
    }
}
