//
//  CodeField.swift
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

// MARK: - CodeField
public class CodeField: SFView {
    // MARK: life cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
        self.addToolbarPreviousNextAllowedClassIfNot()
    }
    
    // MARK: ui
    public private(set) lazy var iconImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.image = SFImage.User.Sign.code
        }
    }()
    public private(set) lazy var textField: SFTextField = {
        return SFTextField().then { view in
            view.placeholder = SFText.User.sign_hint_code
            view.placeholderColor = SFColor.UI.placeholder
            view.clearButtonMode = .whileEditing
            view.font = .systemFont(ofSize: 15, weight: .regular)
        }
    }()
    public private(set) lazy var sendCodeBtn: SFButton = {
        return SFButton().then { view in
            view.setTitleColor(SFColor.UI.theme, for: .normal)
            view.setTitleColor(SFColor.UI.placeholder, for: .selected)
            view.setTitle(SFText.User.sign_action_sendCode, for: .normal)
            view.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
            view.addTarget(self, action: #selector(sendCodeBtnClicked), for: .touchUpInside)
        }
    }()
    private func customUI() {
        addSubview(iconImgView)
        addSubview(textField)
        addSubview(sendCodeBtn)
        
        iconImgView.snp.makeConstraints { make in
            make.centerY.equalTo(textField)
            make.leading.equalToSuperview().offset(15)
            make.width.height.equalTo(20)
        }
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalTo(iconImgView.snp.trailing).offset(10)
            make.height.equalTo(44)
        }
        sendCodeBtn.snp.makeConstraints { make in
            make.top.equalTo(textField)
            make.bottom.equalTo(textField)
            make.leading.equalTo(textField.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.width.greaterThanOrEqualTo(60)
            make.width.lessThanOrEqualTo(120)
        }
    }
}

// MARK: - action
extension CodeField {
    @objc private func sendCodeBtnClicked() {
        
    }
}
