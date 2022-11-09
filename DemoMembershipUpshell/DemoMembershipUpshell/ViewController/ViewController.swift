//
//  ViewController.swift
//  DemoMembershipUpshell
//
//  Created by Mahvish Syed on 11/9/22.
//

import UIKit

class ViewController: UIViewController {
    private var membershipUpshellDataModel = MembershipUpshellDataModel()
    
    private lazy var membershipUpshellView: MembershipUpshellView = {
        var membershipUpshellView = MembershipUpshellView(membershipUpshellDataModel: membershipUpshellDataModel)
        return membershipUpshellView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMembershipUpshellView()
    }
    
    /// This function setup membership upshell view
    /// It also confirms to delegate
    private func setupMembershipUpshellView() {
        view.addSubview(membershipUpshellView)
        membershipUpshellView.delegate = self
        
        membershipUpshellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: MembershipUpshellViewDelegate
extension ViewController: MembershipUpshellViewDelegate {
    func membershipUpshellNoThanksButtonTapped() {
        print("NoThanksButtonTapped")
        
    }
    func membershipUpshellSeeAllBenefitsButtonTapped() {
        print("SeeAllBenefitsButtonTapped")
    }
}

