//
//  SignVC.swift
//  SFUser
//
//  Created by hsf on 2024/11/19.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI
// Business
import SFBusiness

// MARK: - SignVC
public class SignVC: SFScrollViewController {
    // MARK: block
    
    
    // MARK: life cycle
    public convenience init() {
        self.init(dir: .vertical)
    }
    
    private override init(dir: SFScrollView.Direction) {
        super.init(dir: dir)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        isHiddenNavBar = true
        customUI()
    }
    
    // MARK: ui
    public private(set) lazy var logoView: SFLogoView = {
        return SFLogoView()
    }()
    private(set) lazy var modeView: SignModeView = {
        return SignModeView().then { view in
            view.didSelectedItemBlock = {
                [weak self] modeView, index in
                self?.pageView.changePage(to: index)
            }
        }
    }()
    private(set) lazy var pageView: SignPageView = {
        return SignPageView().then { view in
            view.pageDidChangedBlock = {
                [weak self] pageView, index in
                self?.modeView.select(index: index, animated: true)
            }
            view.forgetPwdBlock = {
                [weak self] in
                // FIXME
//                let vc = SFPwdFindbackVC()
//                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }()
    public private(set) lazy var agreementView: SFAgreementView = {
        return SFAgreementView()
    }()
    public private(set) lazy var signBtn: SFButton = {
        return SFButton().then { view in
            view.backgroundColor = SFColor.UI.theme
            view.setTitleColor(SFColor.UI.whiteAlways, for: .normal)
            view.setTitle(SFText.User.sign_action_in, for: .normal) // FIXME
            view.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
        }
    }()
    
    private func customUI() {
        scrollView.contentView.addSubview(logoView)
        scrollView.contentView.addSubview(modeView)
        scrollView.contentView.addSubview(pageView)
        scrollView.contentView.addSubview(agreementView)
        scrollView.contentView.addSubview(signBtn)
        
        logoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
        modeView.snp.makeConstraints { make in
            make.top.equalTo(logoView.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        pageView.snp.makeConstraints { make in
            make.top.equalTo(modeView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        agreementView.snp.makeConstraints { make in
            make.top.equalTo(pageView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(30)
            make.trailing.lessThanOrEqualToSuperview().offset(-30)
        }
        signBtn.snp.makeConstraints { make in
            make.top.equalTo(agreementView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(50)
            make.bottom.lessThanOrEqualToSuperview().offset(-100)
        }
    }
}
