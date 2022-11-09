//
//  MembershipUpshellDataModel.swift
//  DemoMembershipUpshell
//
//  Created by Mahvish Syed on 11/9/22.
//

import Foundation
import UIKit


/// Defines Data Model for MembershipUpshell.
/// Data is hardcoded for easy access.
struct MembershipUpshellDataModel {
    var bannerTitle: String = "King and Queen Courthouse"
    var header: String = "Unlock your Thumbtack Plus membership."
    var headerSubtitle: String = "Member-only benefits"
    var benefits: [Benefit] = [Benefit(title: "Only members get a $10,000 money-back guarantee. View terms", image: "certified_icon"),
                               Benefit(title: "Get 20% off every fixed-price project paid for on Thumbtack.", image: "money_icon"),
                               Benefit(title: "Work 1:1 with a home specialist to plan large projects like a renovation.", image: "user_icon")]
    var footerTitle: String = "Find out how your membership pays for itself."
}

struct Benefit {
    var title: String
    var image: String
}
