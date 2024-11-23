//
//  CodeSignView.swift
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

// MARK: - CodeSignView
class CodeSignView: SFView {
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    // MARK: ui
    private lazy var field: AccountCodeField = {
        return AccountCodeField()
    }()
    private lazy var tipLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 12, weight: .regular)
            view.textColor = SFColor.UI.subtitle
//            view.text = R.string.localizable.user_signIn_tip_code()
        }
    }()
    
    private func customUI() {
        addSubview(field)
        addSubview(tipLabel)
        
        field.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        tipLabel.snp.makeConstraints { make in
            make.top.equalTo(field.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(5)
            make.trailing.lessThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
}
