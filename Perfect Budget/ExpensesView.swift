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
    let cellSpacingHeight: CGFloat = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        // add sample data
        model.addExpense(amount: 10, reason: "I was hungry")
        model.addExpense(amount: 4, reason: "I was thirsty")
        model.addExpense(amount: 8, reason: "I was tired")
        configureView()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return model.getExpenses().count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }

    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! CustomCell

        // cell.textLabel!.text = "\(model.getExpenses()[indexPath.section].reason)"
        cell.setReasonandAmount(reason: model.getExpenses()[indexPath.section].reason,  amount: model.getExpenses()[indexPath.section].amount)

        return cell
    }

    // Method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.section).")
    }
}

extension ExpensesView {
    func configureView() {
        // View Heirarchy
        self.view.addSubview(expenseTable)
        expenseTable.register(CustomCell.self, forCellReuseIdentifier: "MyCell")
        expenseTable.dataSource = self
        expenseTable.delegate = self

        // Style
        expenseTable.separatorStyle = .none
        expenseTable.backgroundColor = .clear
        // expenseTable.bounces = false

        // Layout
        expenseTable.edgeAnchors == self.view.edgeAnchors
    }
}

