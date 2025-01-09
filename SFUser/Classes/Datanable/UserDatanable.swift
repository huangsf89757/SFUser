//
//  UserDatanable.swift
//  IQKeyboardManagerSwift
//
//  Created by hsf on 2024/11/20.
//

import Foundation
// Basic
import SFExtension
import SFBase
// Business
import SFBusiness
// Third
import WCDBSwift

// MARK: - UserDatanable
public protocol UserDatanable: SFLocalDatanable, SFRemoteDatanable {
    // MARK: var
    // # 账号信息
    /// uid
    var uid: String {get set}
    /// account
    var account: String? {get set}
    /// state
    var state: Int {get set}
    /// pwd
    var pwd: String? {get set}
    
    
    // # 基础信息
    /// 昵称
    var nickname: String? {get set}
    /// 性别
    var gender: Int {get set}
    
    /// 头像
    var avatar: String? {get set}
    /// 座右铭
    var motto: String? {get set}
    
    // # 绑定信息
    /// 手机号
    var phone: String? {get set}
    /// 邮箱号
    var email: String? {get set}
    
    // # 附加信息
    /// 出生日期
    /// yyyy/MM/dd
    var birthday: String? {get set}
    /// 所在地
    var address: String? {get set}
    
}
 
extension UserDatanable {
    public var stateEnum: AccountState {
        get {
            AccountState(rawValue: state) ?? .inactive
        }
        set {
            state = newValue.rawValue
        }
    }
    public var genderEnum: Gender {
        get {
            Gender(rawValue: gender) ?? .unknown
        }
        set {
            gender = newValue.rawValue
        }
    }
    public var birthdayDate: Date? {
        get {
            guard let birthday = birthday else { return nil }
            return SFDateFormatter.yyyyMMdd.date(from: birthday)
        }
        set {
            guard let newValue = newValue else {
                birthday = nil
                return
            }
            birthday = SFDateFormatter.yyyyMMdd.string(from: newValue)
        }
    }
}
 
extension UserDatanable {
    /// 生成随机账号
    public static func generateRandomAccount(num: Int = 6) -> String {
        let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
        return String((0..<num).compactMap { _ in characters.randomElement() })
    }
    
    /// 生成唯一的随机账号
    public static func generateUniqueAccount(existingAccounts: Set<String>, num: Int = 6) -> String {
        var newAccount: String
        repeat {
            newAccount = generateRandomAccount(num: num)
        } while existingAccounts.contains(newAccount)
        return newAccount
    }
}
