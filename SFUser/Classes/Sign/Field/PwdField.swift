//
//  PwdField.swift
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

// MARK: - PwdField
class PwdField: SFView {
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    // MARK: ui
    private lazy var iconImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.image = SFImage.User.Sign.pwd
        }
    }()
    private lazy var textField: SFTextField = {
        return SFTextField().then { view in
//            view.placeholder = R.string.localizable.user_signIn_input_pwd_ph()
            view.placeholderColor = SFColor.UI.placeholder
            view.clearButtonMode = .whileEditing
            view.font = .systemFont(ofSize: 15, weight: .regular)
        }
    }()
    private lazy var eyeBtn: SFButton = {
        return SFButton().then { view in
            view.setImage(SFImage.User.Sign.Eye.close, for: .normal)
            view.setImage(SFImage.User.Sign.Eye.open, for: .selected)
            view.addTarget(self, action: #selector(eyeBtnClicked), for: .touchUpInside)
        }
    }()
    private func customUI() {
        addSubview(iconImgView)
        addSubview(textField)
        addSubview(eyeBtn)
        
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
        eyeBtn.snp.makeConstraints { make in
            make.top.equalTo(textField)
            make.bottom.equalTo(textField)
            make.leading.equalTo(textField.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
            make.width.equalTo(60)
        }
    }
}

// MARK: - action
extension PwdField {
    @objc private func eyeBtnClicked() {
        eyeBtn.toggleSelected()
        textField.isSecureTextEntry = !eyeBtn.isSelected
    }
}
