//
//  AccountState.swift
//  SFUser
//
//  Created by hsf on 2024/12/9.
//

import Foundation
import UIKit
// UI
import SFUI

public enum AccountState: Int {
    case inactive = 0   // 不活跃
    case active         // 活跃中
    case delete         // 已注销
    
    public var text: String {
        switch self {
        case .inactive:
            return SFText.User.info_accountState_inactive
        case .active:
            return SFText.User.info_accountState_active
        case .delete:
            return SFText.User.info_accountState_delete
        }
    }
}
