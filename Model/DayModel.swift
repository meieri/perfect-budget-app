//
//  DayModel.swift
//  Perfect Budget
//
//  Created by Isaak Meier on 7/12/19.
//  Copyright © 2019 Isaak Meier. All rights reserved.
//

import Foundation

class DayModel {
    var budget: Double!
    var totalSpent: Double!
    let date: Date!
    var nameOfDay: String!
    var expenses: Array<Expense>

    init() {
        budget = 40.0
        totalSpent = 0.0
        date = Date()
        expenses = []
        nameOfDay = self.dayOfWeek()
    }

    public func setBudget(budget: Double) {
        self.budget = budget
    }

    public func addExpense(amount: Double, reason: String) {
        let calendar = Calendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .hour,
            .minute
        ]
        let dateTimeComponents = calendar.dateComponents(requestedComponents, from: date)
        let time = String(dateTimeComponents.hour!) + String(dateTimeComponents.minute!)
        let exp = Expense(amount: amount, time: time, reason: reason)
        expenses.append(exp)
        totalSpent += amount
    }

    public func getExpenses() -> Array<Expense> {
        let copy = expenses
        return copy
    }

    public func getProgress() -> Float {
        return Float(self.totalSpent) / Float(self.budget)
    }

    public func getTotalSpent() -> Double {
        return self.totalSpent
    }

    public func getBudget() -> Double {
        return self.budget
    }

    public func getDayOfWeek() -> String {
        return self.nameOfDay
    }
}

private extension DayModel {

    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)
        return dayInWeek
    }
}

struct Expense {
    var amount: Double
    // String for time of day, represented as hours:minute
    var time: String
    var reason: String

    init(amount: Double, time: String, reason: String) {
        self.amount = amount
        self.time = time
        self.reason = reason
    }
}
