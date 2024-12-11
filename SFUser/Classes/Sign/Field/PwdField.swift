//
//  PwdField.swift
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

// MARK: - PwdField
public class PwdField: SFView {
    // MARK: life cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    // MARK: ui
    public private(set) lazy var iconImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.image = SFImage.User.Sign.pwd
        }
    }()
    public private(set) lazy var textField: SFTextField = {
        return SFTextField().then { view in
            view.isSecureTextEntry = true
            view.placeholder = SFText.User.sign_hint_pwd
            view.placeholderColor = SFColor.UI.placeholder
            view.clearButtonMode = .whileEditing
            view.font = .systemFont(ofSize: 15, weight: .regular)
        }
    }()
    public private(set) lazy var eyeBtn: SFButton = {
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

