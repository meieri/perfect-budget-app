//
//  ExpensesView.swift
//  
//
//  Created by Isaak Meier on 7/12/19.
//

import Foundation
import UIKit
import Anchorage

class ExpensesView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var expenseTable = UITableView()
    private var model = DayModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        model.addExpense(amount: 10, reason: "I was hungry")
        model.addExpense(amount: 4, reason: "I was thirsty")
        model.addExpense(amount: 8, reason: "I was tired")
        configureView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.getExpenses().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(model.getExpenses()[indexPath.row].reason)"
        return cell
    }
}

extension ExpensesView {
    func configureView() {
        // View Heirarchy
        self.view.addSubview(expenseTable)
        expenseTable.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        expenseTable.dataSource = self
        expenseTable.delegate = self

        // Style
        expenseTable.separatorStyle = .none

        // Layout
        expenseTable.edgeAnchors == self.view.edgeAnchors
    }
}
