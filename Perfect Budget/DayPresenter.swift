//
//  DayPresenter.swift
//  Perfect Budget
//
//  Created by Isaak Meier on 7/20/19.
//  Copyright © 2019 Isaak Meier. All rights reserved.
//

import Foundation

protocol DayView: class {
    func showProgress(progress: Float)
    func showDayOfWeek(day: String)
    func showSpendingValues(currSpend: Double, maxSpend: Double)
}

protocol DayViewPresenter {
    init(view: DayView, day: DayModel)
    func setProgress()
    func setDayOfWeek()
    func setSpendingValues()
    func addExpense(amount: Double, reason: String)
    func getExpenses() -> [Expense]
}

class DayPresenter: DayViewPresenter {

    unowned let view: DayView
    let day: DayModel

    required init(view: DayView, day: DayModel) {
        self.view = view
        self.day = day
    }

    func setProgress() {
        self.view.showProgress(progress: day.getProgress())
    }

    func setDayOfWeek() {
        self.view.showDayOfWeek(day: day.getDayOfWeek())
    }

    func setSpendingValues() {
        self.view.showSpendingValues(currSpend: day.getTotalSpent(), maxSpend: day.getBudget())
    }

    func addExpense(amount: Double, reason: String) {
        self.day.addExpense(amount: amount, reason: reason)
    }

    func getExpenses() -> [Expense] {
        return self.day.getExpenses()
    }
}
