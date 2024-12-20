//
//  AccountCodePwd2Field.swift
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

// MARK: - AccountCodePwd2Field
public class AccountCodePwd2Field: GroupField {
    // MARK: life cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    // MARK: ui
    public private(set) lazy var accountField: AccountField = {
        return AccountField()
    }()
    public private(set) lazy var codeField: CodeField = {
        return CodeField()
    }()
    public private(set) lazy var pwdField: PwdField = {
        return PwdField()
    }()
    public private(set) lazy var repwdField: PwdField = {
        return PwdField()
    }()
    public private(set) lazy var dividerView1: SFView = {
        return SFView().then { view in
            view.backgroundColor = SFColor.UI.divider
        }
    }()
    public private(set) lazy var dividerView2: SFView = {
        return SFView().then { view in
            view.backgroundColor = SFColor.UI.divider
        }
    }()
    public private(set) lazy var dividerView3: SFView = {
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

