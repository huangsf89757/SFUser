//
//  SFAccountPwdField.swift
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

// MARK: - SFAccountPwdField
class SFAccountPwdField: SFGroupField {
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    // MARK: ui
    private lazy var accountField: SFAccountField = {
        return SFAccountField()
    }()
    private lazy var pwdField: SFPwdField = {
        return SFPwdField()
    }()
    private lazy var dividerView: SFView = {
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

