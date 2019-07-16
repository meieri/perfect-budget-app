//
//  Constants.swift
//  Perfect BudgetUITests
//
//  Created by Isaak Meier on 7/16/19.
//  Copyright © 2019 Isaak Meier. All rights reserved.
//

import Foundation
import UIKit

struct Constants {

    static guard let montBold = UIFont(name: "Montserrat-Bold", size: 20) else {
    fatalError("""
    Failed to load the "Montserrat-Black" font.
    Make sure the font file is included in the project and the font name is correct
    """)
    }

    static guard let montBlack = UIFont(name: "Montserrat-Bold", size: 20) else {
    fatalError("""
    Failed to load the "Montserrat-Black" font.
    Make sure the font file is included in the project and the font name is correct
    """)
    }
    static let moneyGreen = UIColor(displayP3Red: 133/255, green: 187/255, blue: 101/255, alpha: 1)
    // static let
}
