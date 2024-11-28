//
//  UserModel.swift
//  IQKeyboardManagerSwift
//
//  Created by hsf on 2024/11/20.
//

import Foundation
// Business
import SFBusiness
// Third
import WCDBSwift

// MARK: - UserModel
open class UserModel: SFRemoteDataModel {
    
    /// 当前登录的用户
    public static var current: UserModel?
    
    // MARK: var
    /// 静态表名
    open override class var tableName: String {
        return "user"
    }
    // # 账号信息
    /// uid
    public var uid: String?
    /// account
    public var account: String?
    
    // # 基础信息
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
    /// 头像
    public var avatar: String?
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
    
    /// CodingKeys
    public enum CodingKeys: String, CodingTableKey {
        public typealias Root = SFRemoteDataModel
        
        case orderL
        case idL
        case createTimeL
        case updateTimeL
        
        case orderR
        case idR
        case createTimeR
        case updateTimeR
        
        case uid
        case account
        case nickname
        case gender
        case avatar
        case motto
        case phone
        case email
        case birthday
        case address
        
        public static let objectRelationalMapping = TableBinding(CodingKeys.self) {
            BindColumnConstraint(orderL, isPrimary: true, isAutoIncrement: true)
            BindColumnConstraint(idL, isNotNull: true, isUnique: true)
        }
    }
    
    // MARK: life cycle
    public override init() {
        super.init()
    }
    public required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
