//
//  ProgessBarView.swift
//  Perfect Budget
//
//  Created by Isaak Meier on 7/11/19.
//  Copyright © 2019 Isaak Meier. All rights reserved.
//

import Foundation
import UIKit
import Anchorage
import QuartzCore

class ProgessBarView: UIView {

    private var progessBar = UIProgressView()
    var maxSpending = 40
    var currentSpending = 10

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //override func layoutSubviews() {
    //    super.layoutSubviews()
    //    subviews.forEach { subview in
    //        subview.layer.masksToBounds = true
    //        subview.layer.cornerRadius = 8.0
    //    }
    //}
}

private extension ProgessBarView {
    func configureView() {

        // View Heirarchy
        self.addSubview(progessBar)

        // Style -- handled (partially) by the override of draw function
        progessBar.setProgress( Float(currentSpending) / Float(maxSpending), animated: true)
        progessBar.layer.cornerRadius = 8.0
        progessBar.clipsToBounds = true

        // Layout
        // Sets them to be the same size, the size of this is handled in NameAndProgessView
        //self.
        progessBar.edgeAnchors == self.edgeAnchors

    }
}
