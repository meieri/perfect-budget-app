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
    private var currentHeight: CGFloat = 0

    private weak var labelLeadingConstraint: NSLayoutConstraint?

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

    func showProgress(progress: Float) {
        self.progressBar.setProgress(progress, animated: true)
        configureView()
    }

    func showSpendingValues(currSpend: Double, maxSpend: Double) {
        currSpendLabel.text = "$" + String(currSpend)
        maxSpendLabel.text = "$" + String(maxSpend)
    }
}

private extension ProgressBarView {
    func configureView() {

        // View Heirarchy
        self.addSubview(progressBar)
        self.addSubview(currSpendLabel)
        self.addSubview(maxSpendLabel)

        // Style -- rounded corners for the progess bar (among other things) handled by the configureTrack function
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

        // guard let moneyOverlay = UIImage(named: "rsz_1.jpg") else { return }
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

        DispatchQueue.main.async {
            self.presenter.setSpendingValues()
            self.labelLeadingConstraint?.isActive = false
            var multiplier: Float
            if self.progressBar.progress == 1.0 {
                multiplier = 0.44
                self.currSpendLabel.text = "Budget Reached!"
                self.maxSpendLabel.isHidden = true
            }
            else if self.progressBar.progress == 0.0 {
                multiplier = 0.12
            }
            else if self.progressBar.progress > 0.8 {
                multiplier = 0.85
            }
            else {
                multiplier = self.progressBar.progress
            }

            self.labelLeadingConstraint = self.currSpendLabel.trailingAnchor == self.trailingAnchor * multiplier - 5

            UIView.animate(withDuration: 0.4, animations: {
                self.presenter.setProgress()
                self.layoutIfNeeded()
            })

        }
    }
}

extension UIImage {
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
