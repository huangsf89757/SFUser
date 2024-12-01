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
    var uid: String? {get set}
    /// account
    var account: String? {get set}
    /// pwd
    var pwd: String? {get set}
    /// 活跃的
    var isActive: Bool? {get set}
    
    // # 基础信息
    /// 昵称
    var nickname: String? {get set}
    /// 性别
    var gender: Int? {get set}
    
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
    public var genderEnum: Gender {
        get {
            Gender(rawValue: gender ?? 0) ?? .unknown
        }
        set {
            gender = newValue.rawValue
        }
    }
}
 
