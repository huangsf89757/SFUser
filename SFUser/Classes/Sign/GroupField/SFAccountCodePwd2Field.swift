//
//  SFAccountCodePwd2Field.swift
//  SFUser
//
//  Created by hsf on 2024/11/19.
//

import Foundation
import UIKit
// Basic
import SFBase
import SFExtension
// UI
import SFUI

// MARK: - SFAccountCodePwd2Field
class SFAccountCodePwd2Field: SFGroupField {
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    // MARK: ui
    private lazy var accountField: SFAccountField = {
        return SFAccountField()
    }()
    private lazy var codeField: SFCodeField = {
        return SFCodeField()
    }()
    private lazy var pwdField: SFPwdField = {
        return SFPwdField()
    }()
    private lazy var repwdField: SFPwdField = {
        return SFPwdField()
    }()
    private lazy var dividerView1: SFView = {
        return SFView().then { view in
            view.backgroundColor = SFColor.UI.divider
        }
    }()
    private lazy var dividerView2: SFView = {
        return SFView().then { view in
            view.backgroundColor = SFColor.UI.divider
        }
    }()
    private lazy var dividerView3: SFView = {
        return SFView().then { view in
            view.backgroundColor = SFColor.UI.divider
        }
    }()
    
    private func customUI() {
        addSubview(accountField)
        addSubview(dividerView1)
        addSubview(codeField)
        addSubview(dividerView2)
        addSubview(pwdField)
        addSubview(dividerView3)
        addSubview(repwdField)
        
        accountField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview()
        }
        dividerView1.snp.makeConstraints { make in
            make.top.equalTo(accountField.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(1)
        }
        codeField.snp.makeConstraints { make in
            make.top.equalTo(dividerView1.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        dividerView2.snp.makeConstraints { make in
            make.top.equalTo(codeField.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(1)
        }
        pwdField.snp.makeConstraints { make in
            make.top.equalTo(dividerView2.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        dividerView3.snp.makeConstraints { make in
            make.top.equalTo(pwdField.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(1)
        }
        repwdField.snp.makeConstraints { make in
            make.top.equalTo(dividerView3.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}

