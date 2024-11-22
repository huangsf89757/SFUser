//
//  SignVC.swift
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
// Business
import SFBusiness

// MARK: - SignVC
public class SignVC: SFScrollViewController {
    // MARK: block
    
    
    // MARK: life cycle
    public convenience init() {
        self.init(dir: .vertical)
    }
    
    private override init(dir: SFScrollView.Direction) {
        super.init(dir: dir)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        isHiddenNavBar = true
        customUI()
    }
    
    // MARK: ui
    public private(set) lazy var logoImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.backgroundColor = SFColor.UI.content
//            view.image = SFImage.UI.logo() // FIXME
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = true
        }
    }()
    public private(set) lazy var nameLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 17, weight: .bold)
            view.textColor = SFColor.UI.title
            view.textAlignment = .center
//            view.text = R.string.localizable.name() // FIXME
        }
    }()
    public private(set) lazy var slogenLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 12, weight: .regular)
            view.textColor = SFColor.UI.subtitle
            view.textAlignment = .center
//            view.text = R.string.localizable.slogen() // FIXME
        }
    }()
    private(set) lazy var modeView: SignModeView = {
        return SignModeView().then { view in
            view.didSelectedItemBlock = {
                [weak self] modeView, index in
                self?.pageView.changePage(to: index)
            }
        }
    }()
    private(set) lazy var pageView: SignPageView = {
        return SignPageView().then { view in
            view.pageDidChangedBlock = {
                [weak self] pageView, index in
                self?.modeView.select(index: index, animated: true)
            }
            view.forgetPwdBlock = {
                [weak self] in
                // FIXME
//                let vc = SFPwdFindbackVC()
//                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }()
    public private(set) lazy var agreementView: SFAgreementView = {
        return SFAgreementView()
    }()
    public private(set) lazy var signBtn: SFButton = {
        return SFButton().then { view in
            view.backgroundColor = SFColor.UI.theme
            view.setTitleColor(SFColor.UI.whiteAlways, for: .normal)
//            view.setTitle(R.string.localizable.user_sign_in(), for: .normal) // FIXME
            view.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
        }
    }()
    
    private func customUI() {
        scrollView.contentView.addSubview(logoImgView)
        scrollView.contentView.addSubview(nameLabel)
        scrollView.contentView.addSubview(slogenLabel)
        scrollView.contentView.addSubview(modeView)
        scrollView.contentView.addSubview(pageView)
        scrollView.contentView.addSubview(agreementView)
        scrollView.contentView.addSubview(signBtn)
        
        logoImgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImgView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        slogenLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        modeView.snp.makeConstraints { make in
            make.top.equalTo(slogenLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        pageView.snp.makeConstraints { make in
            make.top.equalTo(modeView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        agreementView.snp.makeConstraints { make in
            make.top.equalTo(pageView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(30)
            make.trailing.lessThanOrEqualToSuperview().offset(-30)
        }
        signBtn.snp.makeConstraints { make in
            make.top.equalTo(agreementView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(50)
            make.bottom.lessThanOrEqualToSuperview().offset(-100)
        }
    }
}
