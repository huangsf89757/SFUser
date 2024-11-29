//
//  SignMode.swift
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

// MARK: - SignMode
/// 登录方式
public enum SignMode: Int, CaseIterable {
    case code = 0   // 验证码
    case pwd        // 密码
    
    /// 描述
    public var text: String {
        switch self {
        case .code:
            return SFText.User.sign_mode_code
        case .pwd:
            return SFText.User.sign_mode_pwd
        }
    }
}
