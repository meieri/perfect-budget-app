//
//  ViewController.swift
//  Perfect Budget
//
//  Created by Isaak Meier on 7/10/19.
//  Copyright © 2019 Isaak Meier. All rights reserved.
//
// One single change

import UIKit

class DayViewController: UIViewController {

    @IBOutlet weak var dayName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dayName.text = getDayOfWeek()
    }
    
    // Quick function to get name of day of week from date
    func getDayOfWeek() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)
        return dayInWeek
    }

}

