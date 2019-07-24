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

    var presenter: DayViewPresenter!

    private var expenseTable = UITableView()
    private var addExpense = UIButton()
    private let customView = UIView()
    let cellSpacingHeight: CGFloat = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.addExpense(amount: 10, reason: "ok")
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
        showInputDialog()
    }

    // Method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.section).")
    }

    @objc func addItUp(sender: UIButton!) {
        showInputDialog()
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.customView
    }

    func showInputDialog() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Enter details of transaction?", message: "Enter your reason and amount", preferredStyle: .alert)
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            //getting the input values from user
            let reason = alertController.textFields?[0].text
            let amount = alertController.textFields?[1].text
            let numAmount = Double(amount!)
            // self.model.addExpense(amount: numAmount!, reason: reason!)
            self.presenter.addExpense(amount: numAmount!, reason: reason!)
            self.presenter.setProgress()
            self.expenseTable.reloadData()
            // self.configureView()
        }
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Reason"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Amount"
        }
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ExpensesView {

    func configureView() {

        // View Heirarchy
        self.view.addSubview(expenseTable)
        customView.addSubview(addExpense)
        self.view.addSubview(customView)
        expenseTable.register(CustomCell.self, forCellReuseIdentifier: "MyCell")
        expenseTable.dataSource = self
        expenseTable.delegate = self

        // self.expenseTable.addSubview(customView)

        // Style
        expenseTable.separatorStyle = .none
        expenseTable.backgroundColor = .clear
        // expenseTable.bounces = false
        addExpense.backgroundColor = Constants.moneyGreen
        addExpense.setTitle("Add It Up", for: .normal)
        // addExpense.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        addExpense.addTarget(self, action: #selector(addItUp), for: .touchUpInside)
        addExpense.backgroundColor = Constants.moneyGreen
        addExpense.layer.cornerRadius = 16
        addExpense.layer.borderWidth = 1
        addExpense.layer.borderColor = UIColor.black.cgColor

        // Layout
        expenseTable.edgeAnchors == self.view.edgeAnchors

        addExpense.heightAnchor == customView.heightAnchor
        addExpense.leadingAnchor == customView.leadingAnchor
        addExpense.trailingAnchor == customView.trailingAnchor - 50
    }
}

