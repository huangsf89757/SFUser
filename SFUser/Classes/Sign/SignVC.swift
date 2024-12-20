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
    public var signInSuccessBlock: ((UserDatanable?) -> ())?
    
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
            view.codeView.field.accountField.textField.text = SFUserDefault.account
            view.pwdView.field.accountField.textField.text = SFUserDefault.account
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
            view.codeView.field.codeField.sendCodeBlock = {
                [weak self] in
                let success = await self?.dp_sendSmsCode() ?? false
                if success {
                    SFUserDefault.account = self?.pageView.codeView.field.accountField.textField.text ?? ""
                }
                return success
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
        Task {
            let (success, data) = await dp_signIn()
            if success, let user = data as? UserDatanable {
                signInSuccessBlock?(user)
            } else {
                signInSuccessBlock?(nil)
            }
        }
    }
}

// MARK: - DataProvider
extension SignVC {
    private func dp_sendSmsCode() async -> Bool {
        let account = pageView.codeView.field.accountField.textField.text ?? ""
        if account.isEmpty {
            SFToast.show(SFText.User.sign_hint_account)
            return false
        }
        var type: SmsCodeType.SubType?
        if account.sf.isRegex(type: .phone) {
            type = .phone
        }
        else if account.sf.isRegex(type: .email) {
            type = .email
        }
        else {
            type = nil
        }
        guard let type = type else {
            SFToast.show(SFText.User.sign_hint_account)
            return false
        }
        let res = await SFDataService.shared.request(hud: (loading: SFText.User.sign_action_sendCode_loading,
                                                           success: SFText.User.sign_action_sendCode_success,
                                                           failure: SFText.User.sign_action_sendCode_failure)) { provider in
            return await (provider as? SFUserApi)?.sendSmsCode(type: .sign(type))
        }
        return res.success
    }
    
    private func dp_signIn() async -> (success: Bool ,data: Any?) {
        guard agreementView.checkBoxBtn.isSelected else {
            SFToast.show(String(format: SFText.Business.agreement_hint, SFText.Business.agreement_policy, SFText.Business.agreement_term))
            return (success: false ,data: nil)
        }
        switch mode {
        case .code:
            let account = pageView.codeView.field.accountField.textField.text ?? ""
            let code = pageView.codeView.field.codeField.textField.text ?? ""
            if account.isEmpty {
                SFToast.show(SFText.User.sign_hint_account)
                return (success: false ,data: nil)
            }
            if code.isEmpty {
                SFToast.show(SFText.User.sign_hint_code)
                return (success: false ,data: nil)
            }
            if account.sf.isRegex(type: .phone) {
                let res = await SFDataService.shared.request(hud: (loading: SFText.User.sign_action_in_loading,
                                                                   success: SFText.User.sign_action_in_success,
                                                                   failure: SFText.User.sign_action_in_failure)) { provider in
                    return await (provider as? SFUserApi)?.signIn(phone: account, code: code)
                }
                return (success: res.success ,data: res.data)
            }
            else if account.sf.isRegex(type: .email) {
                let res = await SFDataService.shared.request(hud: (loading: SFText.User.sign_action_in_loading,
                                                                   success: SFText.User.sign_action_in_success,
                                                                   failure: SFText.User.sign_action_in_failure)){ provider in
                    return await (provider as? SFUserApi)?.signIn(email: account, code: code)
                }
                return (success: res.success ,data: res.data)
            }
            else {
                SFToast.show(SFText.User.sign_hint_account)
                return (success: false ,data: nil)
            }
        case .pwd:
            let account = pageView.pwdView.field.accountField.textField.text ?? ""
            let pwd = pageView.pwdView.field.pwdField.textField.text ?? ""
            if account.isEmpty {
                SFToast.show(SFText.User.sign_hint_account)
                return (success: false ,data: nil)
            }
            if pwd.isEmpty {
                SFToast.show(SFText.User.sign_hint_pwd)
                return (success: false ,data: nil)
            }
            guard pwd.sf.isRegex(type: .password) else {
                SFToast.show(SFText.User.sign_hint_pwd_format)
                return (success: false ,data: nil)
            }
            guard let encryptPwd = pwd.sf.sha256() else {
                SFLogger.error(msgs: "pwd.sf.sha256()失败")
                SFToast.show(SFText.User.sign_hint_pwd_format)
                return (success: false ,data: nil)
            }
            if account.sf.isRegex(type: .phone) {
                let res = await SFDataService.shared.request(hud: (loading: SFText.User.sign_action_in_loading,
                                                                   success: SFText.User.sign_action_in_success,
                                                                   failure: SFText.User.sign_action_in_failure)){ provider in
                    return await (provider as? SFUserApi)?.signIn(phone: account, pwd: encryptPwd)
                }
                return (success: res.success ,data: res.data)
            }
            else if account.sf.isRegex(type: .email) {
                let res = await SFDataService.shared.request(hud: (loading: SFText.User.sign_action_in_loading,
                                                                   success: SFText.User.sign_action_in_success,
                                                                   failure: SFText.User.sign_action_in_failure)){ provider in
                    return await (provider as? SFUserApi)?.signIn(email: account, pwd: encryptPwd)
                }
                return (success: res.success ,data: res.data)
            }
            else {
                let res = await SFDataService.shared.request(hud: (loading: SFText.User.sign_action_in_loading,
                                                                   success: SFText.User.sign_action_in_success,
                                                                   failure: SFText.User.sign_action_in_failure)){ provider in
                    return await (provider as? SFUserApi)?.signIn(account: account, pwd: encryptPwd)
                }
                return (success: res.success ,data: res.data)
            }
        }
    }
}
