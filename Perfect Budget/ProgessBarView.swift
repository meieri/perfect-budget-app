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

    private var progressBar = UIProgressView()
    private var currSpendLabel = UILabel()
    private var maxSpendLabel = UILabel()
    var maxSpending = 40
    var currentSpending = 20
    var currentHeight: CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let newHeight = self.bounds.height
        if newHeight != currentHeight {
            self.currentHeight = newHeight
            configureTrack(height: newHeight)
        }
    }
}

private extension ProgessBarView {
    func configureView() {

        // View Heirarchy
        self.addSubview(progressBar)
        self.addSubview(currSpendLabel)
        self.addSubview(maxSpendLabel)

        // Style -- rounded corners for the progess bar (among other things) handled by the configureTrack function
        progressBar.setProgress( Float(currentSpending) / Float(maxSpending), animated: true)
        configureTrack(height: currentHeight)
        guard let customFont = UIFont(name: "Montserrat-Bold", size: 16) else {
            fatalError("""
            Failed to load the "Montserrat-Black" font.
            Make sure the font file is included in the project and the font name is correct
            """)
        }

        currSpendLabel.font = UIFontMetrics.default.scaledFont(for: customFont)
        maxSpendLabel.font = UIFontMetrics.default.scaledFont(for: customFont)
        currSpendLabel.adjustsFontForContentSizeCategory = true
        maxSpendLabel.adjustsFontForContentSizeCategory = true
        currSpendLabel.text = "$" + String(currentSpending)
        maxSpendLabel.text = "$" + String(maxSpending)

        // Layout
        // Sets them to be the same size, the size of this is handled in NameAndProgessView
        //self.
        progressBar.edgeAnchors == self.edgeAnchors
        currSpendLabel.topAnchor == progressBar.bottomAnchor + 5
        // currSpendLabel.leadingAnchor == progressBar.leadingAnchor + (Float(currentSpending) / Float(maxSpending) * 200)

        let anchor = (1 * progressBar.trailingAnchor / (progressBar.progress * 4)) - 20
        currSpendLabel.centerXAnchor == anchor

        maxSpendLabel.topAnchor == progressBar.bottomAnchor + 5
        maxSpendLabel.centerXAnchor == progressBar.trailingAnchor - 20
    }

    func configureTrack(height: CGFloat) {
        guard height != 0 else { return }

        progressBar.layer.cornerRadius = 16.0
        progressBar.clipsToBounds = true

        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 140, height: height))
        let img: UIImage = renderer.image { (context) in
            // this is the image border
            UIColor(displayP3Red: 133/255, green: 187/255, blue: 101/255, alpha: 1).setStroke()
            // I don't actually know what this does
            context.stroke(renderer.format.bounds)
            // The color of the image itself
            UIColor(displayP3Red: 133/255, green: 187/255, blue: 101/255, alpha: 1).setFill()
            // fill her up
            context.fill(CGRect(x: 1, y: 1, width: 140, height: height))

            UIColor.black.setStroke()
            UIColor.black.setFill()
            context.cgContext.fillEllipse(in: CGRect(x: 107, y: 6, width: 25, height: 25))
        }
        let threeSlice = img.roundedImage.resizableImage(withCapInsets: UIEdgeInsets.init(top: 0, left: 25, bottom: 0, right: 35))
        progressBar.progressImage = threeSlice
    }
}

extension UIImage{
    var roundedImage: UIImage {
        let rect = CGRect(origin:CGPoint(x: 0, y: 0), size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
        UIBezierPath(
            roundedRect: rect,
            cornerRadius: 16.0
            ).addClip()
        self.draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
}
