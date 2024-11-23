//
//  PwdContentView.swift
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

// MARK: - PwdContentView
public class PwdContentView: SFView {
    // MARK: block
    public var forgetPwdBlock: (()->())?
    
    // MARK: life cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    // MARK: ui
    public private(set) lazy var field: AccountPwdField = {
        return AccountPwdField()
    }()
    public private(set) lazy var tipLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 12, weight: .regular)
            view.textColor = SFColor.UI.subtitle
            view.text = SFText.User.sign_tip_pwd
        }
    }()
    public private(set) lazy var forgetPwdBtn: SFButton = {
        return SFButton().then { view in
            view.setTitle(SFText.User.sign_action_forgetPwd, for: .normal)
            view.setTitleColor(SFColor.UI.theme, for: .normal)
            view.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
            view.addTarget(self, action: #selector(forgetPwdBtnClicked), for: .touchUpInside)
        }
    }()
    
    private func customUI() {
        addSubview(field)
        addSubview(tipLabel)
        addSubview(forgetPwdBtn)
        
        field.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        tipLabel.snp.makeConstraints { make in
            make.top.equalTo(field.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(5)
            make.bottom.lessThanOrEqualToSuperview()
        }
        forgetPwdBtn.snp.makeConstraints { make in
            make.top.equalTo(field.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.lessThanOrEqualToSuperview()
            make.leading.greaterThanOrEqualTo(tipLabel.snp.trailing).offset(10)
        }
    }
}

// MARK: - action
extension PwdContentView {
    @objc private func forgetPwdBtnClicked() {
        forgetPwdBlock?()
    }
}

