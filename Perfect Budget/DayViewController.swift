//
//  ViewController.swift
//  Perfect Budget
//
//  Created by Isaak Meier on 7/10/19.
//  Copyright © 2019 Isaak Meier. All rights reserved.
//

import UIKit
import Anchorage

class DayViewController: UIViewController, DayView {


    var presenter: DayViewPresenter! {
        didSet {
            setPresenters()
        }
    }
    private let nameProgessView: NameAndProgessView
    private let expensesView: ExpensesView

    init() {
        self.nameProgessView = NameAndProgessView()
        self.expensesView = ExpensesView()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    override var prefersStatusBarHidden: Bool { return true }

    func setProgress(currSpending: Double) {
        nameProgessView.setProgress(currSpending: currSpending)
    }
}

private extension DayViewController {

    func setPresenters() {
        nameProgessView.presenter = self.presenter
        expensesView.presenter = self.presenter
    }

    func configureView() {

        // View Hierarchy
        self.view.addSubview(nameProgessView)
        self.view.addSubview(expensesView.view)

        // Style
        self.view.backgroundColor = .white

        // Layout
        // Make the nameProgressView the top third of the screen
        nameProgessView.topAnchor == self.view.topAnchor
        nameProgessView.horizontalAnchors == self.view.horizontalAnchors
        nameProgessView.heightAnchor == self.view.heightAnchor / 3.0
        // Make the expensesView the rest of the screen
        expensesView.view.topAnchor == nameProgessView.bottomAnchor
        expensesView.view.bottomAnchor == self.view.bottomAnchor
        expensesView.view.leadingAnchor == self.view.leadingAnchor
        expensesView.view.trailingAnchor == self.view.trailingAnchor
    }
}
