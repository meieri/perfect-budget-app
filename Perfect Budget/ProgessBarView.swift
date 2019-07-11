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

    // Override the draw function in this view in order to draw the progress bar with rounded corners
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let clipPath = UIBezierPath(roundedRect: rect, cornerRadius: 6.0).cgPath

        let ctx = UIGraphicsGetCurrentContext()!
        ctx.addPath(clipPath)
        ctx.setFillColor(UIColor.red.cgColor)

        ctx.closePath()
        ctx.fillPath()
    }
}

private extension ProgessBarView {
    func configureView() {

        // View Heirarchy
        self.addSubview(progessBar)

        // Style -- handled (partially) by the override of draw function
        progessBar.setProgress(Float(currentSpending / maxSpending), animated: true)

        // Layout
        // Sets them to be the same size, the size of this is handled in NameAndProgessView
        progessBar.sizeAnchors == self.sizeAnchors
    }
}
