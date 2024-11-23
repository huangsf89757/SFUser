//
//  ForgetPwdVC.swift
//  SFUser
//
//  Created by hsf on 2024/11/23.
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

// MARK: - ForgetPwdVC
public class ForgetPwdVC: SFScrollViewController {
    // MARK: life cycle
    public convenience init() {
        self.init(dir: .vertical)
    }
    
    private override init(dir: SFScrollView.Direction) {
        super.init(dir: dir)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = SFText.User.forget
        customUI()
    }
    
    // MARK: ui
    public private(set) lazy var field: AccountCodePwd2Field = {
        return AccountCodePwd2Field()
    }()
    public private(set) lazy var resetBtn: SFButton = {
        return SFButton().then { view in
            view.backgroundColor = SFColor.UI.theme
            view.setTitleColor(SFColor.UI.whiteAlways, for: .normal)
            view.setTitle(SFText.User.forget_reset, for: .normal) 
            view.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
        }
    }()
    private func customUI() {
        scrollView.contentView.addSubview(field)
        scrollView.contentView.addSubview(resetBtn)
        
        field.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        resetBtn.snp.makeConstraints { make in
            make.top.equalTo(field.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.bottom.lessThanOrEqualToSuperview().offset(-100)
        }
    }
}
