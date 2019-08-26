//
//  DayModel.swift
//  Perfect Budget
//
//  Created by Isaak Meier on 7/12/19.
//  Copyright © 2019 Isaak Meier. All rights reserved.
//

import Foundation
import os.log

class DayModel: NSObject, NSCoding {

    required convenience init?(coder aDecoder: NSCoder) {

        guard let expenses = aDecoder.decodeObject(forKey: PropertyKey.expenses) as? [Expense] else {
            os_log("Unable to decode the expenses array for your budget.", log: OSLog.default)
            return nil
        }

        let budget = aDecoder.decodeDouble(forKey: PropertyKey.budget)
        let totalSpent = aDecoder.decodeDouble(forKey: PropertyKey.totalSpent)
        let date = aDecoder.decodeObject(forKey: PropertyKey.date) as! Date

        self.init(budget: budget, spent: totalSpent, date: date, expenses: expenses)
    }

    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")

    var budget: Double
    var totalSpent: Double
    let date: Date
    var nameOfDay = DayModel.dayOfWeek()
    var expenses = [Expense]()

    init(budget: Double, spent: Double, date: Date, expenses: [Expense]) {
        self.budget = budget
        self.totalSpent = spent
        self.date = date
        super.init()
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(budget, forKey: PropertyKey.budget)
        aCoder.encode(totalSpent, forKey: PropertyKey.totalSpent)
        aCoder.encode(date, forKey: PropertyKey.date)
        aCoder.encode(expenses, forKey: PropertyKey.expenses)
        aCoder.encode(nameOfDay, forKey: PropertyKey.nameOfDay)
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

    public func getExpenses() -> [Expense] {
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

    static func dayOfWeek() -> String {
        let date = Date()
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

struct PropertyKey {
    static let budget = "budget"
    static let totalSpent = "totalSpent"
    static let date = "date"
    static let nameOfDay = "nameOfDay"
    static let expenses = "expenses"
}
