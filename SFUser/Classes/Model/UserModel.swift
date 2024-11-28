//
//  UserModel.swift
//  IQKeyboardManagerSwift
//
//  Created by hsf on 2024/11/20.
//

import Foundation
// Business
import SFBusiness

// MARK: - UserDatanable
public protocol UserDatanable: SFLocalDatanable, SFRemoteDatanable {
    // MARK: var
    /// 当前登录的用户
    static var current: UserDatanable? {get set}
    
    // # 账号信息
    /// uid
    var uid: String? {get set}
    /// account
    var account: String? {get set}
    
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
    var genderEnum: Gender {
        get {
            Gender(rawValue: gender ?? 0) ?? .unknown
        }
        set {
            gender = newValue.rawValue
        }
    }
}
