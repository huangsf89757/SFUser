//
//  SignModeView.swift
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

// MARK: - SignMode
/// 登录方式
enum SignMode: CaseIterable {
    case code   // 验证码
    case pwd    // 密码
    
    /// 描述
    var text: String {
        switch self {
        case .code:
            return SFText.User.sign_mode_code
        case .pwd:
            return SFText.User.sign_mode_pwd
        }
    }
}

// MARK: - SignModeView
class SignModeView: SFSegmentView {
    // MARK: life cycle
    convenience init() {
        let titles = SignMode.allCases.map { mode in
            mode.text
        }
        self.init(titles: titles, images: nil, selectedImages: nil)
    }
    
    private override init(direction: SFSegmentView.Direction = .horizontal, titles: [String?]?, images: [UIImage?]?, selectedImages: [UIImage?]? = nil) {
        super.init(direction: .horizontal, titles: titles, images: images, selectedImages: selectedImages)
        titleFont = .systemFont(ofSize: 14, weight: .regular)
        selectedTitleFont = .systemFont(ofSize: 14, weight: .bold)
    }
    
}
