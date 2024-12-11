//
//  AccountPwdField.swift
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

// MARK: - AccountPwdField
public class AccountPwdField: GroupField {
    // MARK: life cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
        self.addToolbarPreviousNextAllowedClassIfNot()
    }
    
    // MARK: ui
    public private(set) lazy var accountField: AccountField = {
        return AccountField().then { view in
            view.textField.tag = 1
        }
    }()
    public private(set) lazy var pwdField: PwdField = {
        return PwdField().then { view in
            view.textField.tag = 2
        }
    }()
    public private(set) lazy var dividerView: SFView = {
        return SFView().then { view in
            view.backgroundColor = SFColor.UI.divider
        }
    }()
    
    private func customUI() {
        addSubview(accountField)
        addSubview(dividerView)
        addSubview(pwdField)
        
        accountField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview()
        }
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(accountField.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(1)
        }
        pwdField.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}

