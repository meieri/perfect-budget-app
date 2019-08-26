//
//  customTabBarController.swift
//  Perfect Budget
//
//  Created by Isaak Meier on 7/25/19.
//  Copyright © 2019 Isaak Meier. All rights reserved.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let model = DayModel(budget: 40.0, spent: 0.0, date: Date(), expenses: [Expense]())
        let view = DayViewController()
        let presenter = DayPresenter(view: view, day: model)
        view.presenter = presenter

        let dayNavController = UINavigationController(rootViewController: view)
        dayNavController.tabBarItem.title = "Day"

        viewControllers = [dayNavController]
    }
}
