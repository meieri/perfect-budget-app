//
//  DayPresenter.swift
//  Perfect Budget
//
//  Created by Isaak Meier on 7/20/19.
//  Copyright © 2019 Isaak Meier. All rights reserved.
//

import Foundation

protocol DayView: class {
    func setProgress(currSpending: Double)
}

protocol DayViewPresenter {
    init(view: DayView, day: DayModel)
    func showProgress()
    func addExpense(amount: Double, reason: String)
}

class DayPresenter: DayViewPresenter {
    unowned let view: DayView
    let day: DayModel

    required init(view: DayView, day: DayModel) {
        self.view = view
        self.day = day
    }

    func showProgress() {
        let currSpending = day.totalSpent
        self.view.setProgress(currSpending: currSpending!)
    }

    func addExpense(amount: Double, reason: String) {
        self.day.addExpense(amount: amount, reason: reason)
    }
}
