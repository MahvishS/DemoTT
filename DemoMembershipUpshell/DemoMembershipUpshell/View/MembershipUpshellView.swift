//
//  MembershipUpshellView.swift
//  DemoMembershipUpshell
//
//  Created by Mahvish Syed on 11/9/22.
//

import UIKit
import Thumbprint

protocol MembershipUpshellViewDelegate: AnyObject {
    func membershipUpshellNoThanksButtonTapped()
    func membershipUpshellSeeAllBenefitsButtonTapped()
}

final public class MembershipUpshellView: UIView {
    private let scrollView = UIScrollView()
    private let scrollContentsView = UIView()
    
    private lazy var rootStackView: UIStackView = {
        let rootStackView = UIStackView()
        rootStackView.axis = .vertical
        rootStackView.spacing = Space.four
        rootStackView.distribution = .fill
        rootStackView.alignment = .leading
        return rootStackView
    }()
    
    private lazy var navigateStackView: UIStackView = {
        let navigateStackView = UIStackView()
        navigateStackView.axis = .horizontal
        navigateStackView.spacing = Space.two
        navigateStackView.distribution = .fill
        navigateStackView.alignment = .leading
        return navigateStackView
    }()
    
    private lazy var benefitsStackView: UIStackView = {
        let rootStackView = UIStackView()
        rootStackView.axis = .vertical
        rootStackView.spacing = Space.four
        rootStackView.distribution = .fill
        rootStackView.alignment = .leading
        return rootStackView
    }()
    
    private lazy var bannerLabel: Label = {
        let bannerLabel = Label(textStyle: .title7, adjustsFontForContentSizeCategory: true)
        bannerLabel.textColor = Color.blue
        return bannerLabel
    }()
    
    private lazy var headerLabel: Label = {
        let headerLabel = Label(textStyle: .title3, adjustsFontForContentSizeCategory: true)
        headerLabel.numberOfLines = 0
        return headerLabel
    }()
    
    private lazy var headerPill: Pill = {
        let pill = Pill()
        pill.theme = .blue
        return pill
    }()
    
    private lazy var footerLabel: Label = {
        let footerLabel = Label(textStyle: .text2, adjustsFontForContentSizeCategory: true)
        footerLabel.numberOfLines = 0
        footerLabel.textColor = Color.green600
        footerLabel.backgroundColor = Color.green100
        footerLabel.textAlignment = .center
        return footerLabel
    }()
    
    private lazy var footerBannerView: UIView = {
        let footerBannerView = UIView()
        footerBannerView.backgroundColor = Color.green100
        return footerBannerView
    }()
    
    private lazy var footerButtons: ButtonRow = {
        let noThanksButton = Button(theme: .tertiary, size: .default, adjustsFontForContentSizeCategory: true)
        noThanksButton.addTarget(self, action: #selector(noThanksButtonTapped), for: .touchUpInside)
        noThanksButton.title = "No, thanks"
        
        let seeAllBenefitsButton = Button(theme: .primary, size: .default, adjustsFontForContentSizeCategory: true)
        seeAllBenefitsButton.addTarget(self, action: #selector(seeAllBenefitsButtonTapped), for: .touchUpInside)
        seeAllBenefitsButton.title = "See all benefits"
        
        let footerButtons = ButtonRow(leftButton: noThanksButton, rightButton: seeAllBenefitsButton)
        footerButtons.distribution = .equal
        return footerButtons
    }()
   
    private var membershipUpshellDataModel: MembershipUpshellDataModel?
    weak var delegate: MembershipUpshellViewDelegate?
    
    // MARK: View Initialization
    init(membershipUpshellDataModel: MembershipUpshellDataModel) {
        super.init(frame: .zero)
        self.membershipUpshellDataModel = membershipUpshellDataModel
        setupView()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View setup
    private func setupView() {
        setupFooter()
        setupRootViews()
        setupBanner()
        setupHeader()
        setupBenefits()
    }
    
    private func setupRootViews() {
        self.addSubview(scrollView)
        scrollView.addSubview(scrollContentsView)
        scrollContentsView.addSubview(rootStackView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.width.equalToSuperview()
            make.bottom.equalTo(footerBannerView.snp.top)
        }

        scrollContentsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        rootStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(Space.four)
            make.right.equalToSuperview().inset(Space.four)
            make.top.equalToSuperview().inset(Space.six)
        }
    }

    private func setupBanner() {
        let successImage = UIImageView(image: UIImage(named: "success_icon"))
        let navigationImage = UIImageView(image: UIImage(named: "navigate_icon"))

        navigateStackView.addArrangedSubview(navigationImage)
        navigateStackView.addArrangedSubview(bannerLabel)
        
        rootStackView.addArrangedSubview(successImage)
        rootStackView.setCustomSpacing(Space.two, after: navigationImage)
        rootStackView.addArrangedSubview(navigateStackView)
    }
    
    private func setupHeader() {
        rootStackView.setCustomSpacing(Space.two, after: navigateStackView)
        rootStackView.addArrangedSubview(headerLabel)
        rootStackView.addArrangedSubview(headerPill)
    }
    
    /// Initailize stack view for each benefits and added them in benefits vertical stack view.
    /// This will provide flexibility to add any number of benefits
    /// It also checks if benefitsStackView is empty or not inorder to avoid duplicate data
    private func setupBenefits() {
        guard let membershipUpshellDataModel = membershipUpshellDataModel,
              benefitsStackView.subviews.isEmpty
        else {
            return
        }
        
        for benefit in membershipUpshellDataModel.benefits {
            setBenefitView(with: benefit)
        }
        rootStackView.addArrangedSubview(benefitsStackView)
    }
    
    private func setupFooter() {
        footerBannerView.addSubview(footerLabel)
        self.addSubview(footerBannerView)
        self.addSubview(footerButtons)
        
        footerLabel.snp.makeConstraints { make in
            make.height.equalTo(Space.five)
            make.left.right.equalToSuperview()
        }
        
        footerBannerView.snp.makeConstraints { make in
            make.height.equalTo(Space.five)
            make.left.right.equalToSuperview()
        }
        
        footerButtons.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Space.three)
            make.top.equalTo(footerBannerView.snp.bottom).inset(-Space.three)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(Space.six)
        }
    }

    private func setBenefitView(with benefit: Benefit) {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Space.three
        stackView.distribution = .fill
        stackView.alignment = .leading
        
        let benefitImage = UIImageView(image: UIImage(named: benefit.image))
        let benefitTextLabel = Label(textStyle: .text1, adjustsFontForContentSizeCategory: true)
        benefitTextLabel.numberOfLines = 0
        benefitTextLabel.text = benefit.title
        
        stackView.addArrangedSubview(benefitImage)
        stackView.addArrangedSubview(benefitTextLabel)
        
        benefitsStackView.addArrangedSubview(stackView)
    }
    
    // MARK: View Configuration
    /// Configure all components of view with appropriate data
    private func configureView() {
        guard let membershipUpshellDataModel = membershipUpshellDataModel else {
            return
        }
        bannerLabel.text = membershipUpshellDataModel.bannerTitle
        headerLabel.text = membershipUpshellDataModel.header
        headerPill.text = membershipUpshellDataModel.headerSubtitle
        footerLabel.text = membershipUpshellDataModel.footerTitle
    }

    // MARK: Button Actions
    @objc
    func noThanksButtonTapped() {
        delegate?.membershipUpshellNoThanksButtonTapped()
    }
    
    @objc
    func seeAllBenefitsButtonTapped() {
        delegate?.membershipUpshellSeeAllBenefitsButtonTapped()
    }
}
