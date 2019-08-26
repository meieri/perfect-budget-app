//
//  ExpensesViewController.swift
//  
//
//  Created by Isaak Meier on 7/12/19.
//

import Foundation
import UIKit
import Anchorage

class ExpensesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var presenter: DayViewPresenter!

    private var expenseTable = UITableView()
    private var addExpense = UIButton()
    let cellSpacingHeight: CGFloat = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.getExpenses().count
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
            cell.setReasonandAmount(reason: presenter.getExpenses()[indexPath.section].reason, amount: presenter.getExpenses()[indexPath.section].amount)
            return cell
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    }

    @objc func addItUp(sender: UIButton!) {
        showInputDialog()
    }
}

extension ExpensesViewController {

    func configureView() {

        // View Heirarchy
        self.view.addSubview(expenseTable)
        self.view.addSubview(addExpense)

        expenseTable.register(CustomCell.self, forCellReuseIdentifier: "MyCell")
        expenseTable.register(ButtonCell.self, forCellReuseIdentifier: "ButtCell")
        expenseTable.dataSource = self
        expenseTable.delegate = self

        // Table Style
        expenseTable.separatorStyle = .none
        expenseTable.backgroundColor = .clear
        expenseTable.allowsSelection = false

        // Button Style
        addExpense.backgroundColor = Constants.moneyGreen
        addExpense.setTitle("+", for: .normal)
        addExpense.setTitleColor(UIColor.black, for: .normal)
        addExpense.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 25)
        addExpense.addTarget(self, action: #selector(addItUp), for: .touchUpInside)
        addExpense.backgroundColor = Constants.moneyGreen
        addExpense.layer.cornerRadius = 16
        addExpense.layer.borderWidth = 1
        addExpense.layer.borderColor = UIColor.black.cgColor

        // Layout
        expenseTable.edgeAnchors == self.view.edgeAnchors

        addExpense.leadingAnchor == self.view.leadingAnchor + 300
        addExpense.trailingAnchor == self.view.trailingAnchor - 10
        addExpense.bottomAnchor == self.view.bottomAnchor - 75
        addExpense.heightAnchor == 60
    }

    func showInputDialog() {

        let alertController = UIAlertController(title: "Enter details of transaction?", message: "Enter your reason and amount", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            let reason = alertController.textFields?[0].text
            let amount = alertController.textFields?[1].text
            let numAmount = Double(amount!)
            self.presenter.addExpense(amount: numAmount!, reason: reason!)
            self.presenter.setProgress()
            self.expenseTable.reloadData()
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Reason"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Amount"
        }
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

