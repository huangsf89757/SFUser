//
//  UserModel.swift
//  IQKeyboardManagerSwift
//
//  Created by hsf on 2024/11/20.
//

import Foundation
// Business
import SFBusiness

// MARK: - UserModel
public class UserModel: SFLocalDatanable, SFRemoteDatanable {
    // MARK: SFLocalDatanable
    public var orderL: Int = 0
    public var idL: String = ""
    public var createTimeL: String = ""
    public var updateTimeL: String?
    
    // MARK: SFRemoteDatanable
    public var orderR: Int = 0
    public var idR: String = ""
    public var createTimeR: String = ""
    public var updateTimeR: String?
        
    // MARK: UserModel
    // # 账号信息
    /// uid
    public var uid: String = ""
    /// account
    public var account: String = ""
    
    // # 基础信息
    /// 头像
    public var avatarUrl: String?
    /// 昵称
    public var nickname: String?
    /// 性别
    public var gender: Int = 0
    public var genderEnum: Gender {
        get {
            Gender(rawValue: gender) ?? .unknown
        }
        set {
            gender = newValue.rawValue
        }
    }
    /// 座右铭
    public var motto: String?
    
    // # 绑定信息
    /// 手机号
    public var phone: String?
    /// 邮箱号
    public var email: String?
    
    // # 附加信息
    /// 出生日期
    /// yyyy/MM/dd
    public var birthday: String?
    /// 所在地
    public var address: String?
}
