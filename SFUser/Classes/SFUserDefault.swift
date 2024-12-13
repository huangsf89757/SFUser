//
//  SFUserDefault.swift
//  SFBleTool
//
//  Created by hsf on 2024/8/7.
//

import Foundation
// Basic
import SFBase

extension SFUserDefault {
    private static let key_smsCodeDate = perfixKey + "smsCodeDate"
    /// 上一次获取验证码的时间
    public static var smsCodeDate: Date {
        get {
            let ts = standard.double(forKey: key_smsCodeDate)
            return Date(timeIntervalSince1970: ts)
        }
        set {
            let ts = newValue.timeIntervalSince1970
            standard.setValue(ts, forKey: key_smsCodeDate)
        }
    }
}

extension SFUserDefault {
    private static let key_account = perfixKey + "account"
    /// 上一次登录的账户
    public static var account: String? {
        get {
            return standard.string(forKey: key_account)
        }
        set {
            standard.setValue(newValue, forKey: key_account)
        }
    }
}
