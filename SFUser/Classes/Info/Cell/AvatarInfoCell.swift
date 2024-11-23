//
//  AvatarInfoCell.swift
//  SFUser
//
//  Created by hsf on 2024/11/20.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI

// MARK: - AvatarInfoCell
public class AvatarInfoCell: InfoCell {
    // MARK: ui
    private lazy var avatarView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.backgroundColor = SFColor.UI.placeholder
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
        }
    }()
    public override func customUI() {
        super.customUI()
        addSubview(avatarView)
        avatarView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalTo(detailImgView.snp.leading).offset(-10)
            make.width.height.equalTo(60)
        }
    }
}
