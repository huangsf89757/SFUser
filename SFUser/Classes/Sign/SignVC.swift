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
// Server
import SFLogger

// MARK: - SignVC
public class SignVC: SFScrollViewController {
    // MARK: block
    public var signBlock: (() -> ())?
    
    // MARK: var
    public private(set) var mode: SignMode = .code
    
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
                self?.mode = SignMode(rawValue: index) ?? .code
            }
        }
    }()
    private(set) lazy var pageView: SignPageView = {
        return SignPageView().then { view in
            view.pageDidChangedBlock = {
                [weak self] pageView, index in
                self?.modeView.select(index: index, animated: true)
                self?.mode = SignMode(rawValue: index) ?? .code
            }
            view.forgetPwdBlock = {
                [weak self] in
                let vc = ForgetPwdVC()
                self?.navigationController?.pushViewController(vc, animated: true)
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
            view.setTitle(SFText.User.sign_action_in, for: .normal)
            view.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
            view.addTarget(self, action: #selector(signBtnAction), for: .touchUpInside)
        }
    }()
    private func customUI() {
        scrollView.contentView.addSubview(logoView)
        scrollView.contentView.addSubview(modeView)
        scrollView.contentView.addSubview(pageView)
        scrollView.contentView.addSubview(agreementView)
        scrollView.contentView.addSubview(signBtn)
        
        logoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
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

// MARK: - Action
extension SignVC {
    @objc private func signBtnAction() {
        switch mode {
        case .code:
            let account = pageView.codeView.field.accountField.textField.text ?? ""
            let code = pageView.codeView.field.codeField.textField.text ?? ""
            if account.isEmpty {
                SFToast.show(SFText.User.sign_hint_account)
                return
            }
            if code.isEmpty {
                SFToast.show(SFText.User.sign_hint_code)
                return
            }
            if account.sf.isRegex(type: .phone) {
                SFDataService.shared.request(hud: (SFText.User.sign_action_in_loading,
                                                   SFText.User.sign_action_in_success,
                                                   SFText.User.sign_action_in_failure),
                                             apiTask: { provider in
                    return await (provider as? SFUserApi)?.signIn(phone: account, code: code)
                }, success: { data, msg in
                    guard let user = data as? UserDatanable else { return }
                }, failure: { msg in
                    
                })
            }
            else if account.sf.isRegex(type: .email) {
                SFDataService.shared.request(hud: (SFText.User.sign_action_in_loading,
                                                   SFText.User.sign_action_in_success,
                                                   SFText.User.sign_action_in_failure),
                                             apiTask: { provider in
                    return await (provider as? SFUserApi)?.signIn(email: account, code: code)
                }, success: { data, msg in
                    guard let user = data as? UserDatanable else { return }
                }, failure: { msg in
                    
                })
            }
            else {
                SFToast.show(SFText.User.sign_hint_account)
            }
        case .pwd:
            let account = pageView.pwdView.field.accountField.textField.text ?? ""
            let pwd = pageView.pwdView.field.pwdField.textField.text ?? ""
            if account.isEmpty {
                SFToast.show(SFText.User.sign_hint_account)
                return
            }
            if pwd.isEmpty {
                SFToast.show(SFText.User.sign_hint_pwd)
                return
            }
            guard pwd.sf.isRegex(type: .password) else {
                SFToast.show(SFText.User.sign_hint_pwd_format)
                return
            }
            if account.sf.isRegex(type: .phone) {
                SFDataService.shared.request(hud: (SFText.User.sign_action_in_loading,
                                                   SFText.User.sign_action_in_success,
                                                   SFText.User.sign_action_in_failure),
                                             apiTask: { provider in
                    return await (provider as? SFUserApi)?.signIn(phone: account, pwd: pwd)
                }, success: { data, msg in
                    guard let user = data as? UserDatanable else { return }
                }, failure: { msg in
                    
                })
            }
            else if account.sf.isRegex(type: .email) {
                SFDataService.shared.request(hud: (SFText.User.sign_action_in_loading,
                                                   SFText.User.sign_action_in_success,
                                                   SFText.User.sign_action_in_failure),
                                             apiTask: { provider in
                    return await (provider as? SFUserApi)?.signIn(email: account, pwd: pwd)
                }, success: { data, msg in
                    guard let user = data as? UserDatanable else { return }
                }, failure: { msg in
                    
                })
            }
            else {
                SFDataService.shared.request(hud: (SFText.User.sign_action_in_loading,
                                                   SFText.User.sign_action_in_success,
                                                   SFText.User.sign_action_in_failure),
                                             apiTask: { provider in
                    return await (provider as? SFUserApi)?.signIn(account: account, pwd: pwd)
                }, success: { data, msg in
                    guard let user = data as? UserDatanable else { return }
                }, failure: { msg in
                    
                })
            }
        }
    }
}
