//
//  ProgressBarView.swift
//  Perfect Budget
//
//  Created by Isaak Meier on 7/11/19.
//  Copyright © 2019 Isaak Meier. All rights reserved.
//
import Foundation
import UIKit
import Anchorage

class ProgressBarView: UIView {

    var presenter: DayViewPresenter!
    private var progressBar = UIProgressView()
    private var currSpendLabel = UILabel()
    private var maxSpendLabel = UILabel()
    var maxSpending = 40.00
    var currentSpending = 0.0
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

    func setProgress(currSpending: Double) {
        self.currentSpending = currSpending
        configureView()
    }
}

private extension ProgressBarView {
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

        maxSpendLabel.topAnchor == progressBar.bottomAnchor + 5
        maxSpendLabel.centerXAnchor == progressBar.trailingAnchor - 20
    }

    func configureTrack(height: CGFloat) {
        guard height != 0 else { return }

        progressBar.layer.cornerRadius = 16.0
        progressBar.clipsToBounds = true

        let newSize = CGSize(width: 140, height: height);

        let renderer = UIGraphicsImageRenderer(size: newSize)
        let baseImg: UIImage = renderer.image { (context) in
            // this is the image border
            UIColor(displayP3Red: 133/255, green: 187/255, blue: 101/255, alpha: 1).setStroke()
            // I don't actually know what this does
            context.stroke(renderer.format.bounds)
            // The color of the image itself
            UIColor(displayP3Red: 133/255, green: 187/255, blue: 101/255, alpha: 1).setFill()
            // fill her up
            context.fill(CGRect(x: 1, y: 1, width: newSize.width, height: newSize.height))
            UIColor.black.setStroke()
            UIColor.black.setFill()
            context.cgContext.fillEllipse(in: CGRect(x: 107, y: 7, width: 23, height: 23))
        }
        guard let moneyOverlay = UIImage(named: "rsz_1.jpg") else { return }

        // UIGraphicsBeginImageContext(newSize)
        // let origin = CGPoint(x: 0, y: 0)
        // baseImg.draw(at: origin, blendMode: CGBlendMode.normal, alpha: 1)
        // moneyOverlay.draw(at: origin, blendMode: CGBlendMode.normal, alpha: 0.2)
        // let newImage = UIGraphicsGetImageFromCurrentImageContext()
        // UIGraphicsEndImageContext()

        let threeSlice = baseImg.roundedImage.resizableImage(withCapInsets: UIEdgeInsets.init(top: 0, left: 25, bottom: 0, right: 35))
        progressBar.progressImage = threeSlice
        configureCurrentProgress()
    }

    func configureCurrentProgress() {
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        if progressBar.progress == 1.0 {
            NSLayoutConstraint(item: currSpendLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 0.44, constant: -5).isActive = true
            maxSpendLabel.isHidden = !maxSpendLabel.isHidden
            DispatchQueue.main.async {
                self.currSpendLabel.text = "Budget Reached!"
            }
        }
        else if progressBar.progress == 0.0 {
            NSLayoutConstraint(item: currSpendLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 0.12, constant: -5).isActive = true
        }
        else {
            NSLayoutConstraint(item: currSpendLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: CGFloat(progressBar.progress), constant: -5).isActive = true
        }
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
