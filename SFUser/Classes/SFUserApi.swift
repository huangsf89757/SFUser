//
//  SFUserApi.swift
//  SFUser
//
//  Created by hsf on 2024/11/29.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// Business
import SFBusiness

// MARK: - SmsCodeType
public enum SmsCodeType {
    case sign(SubType)
    case resetPwd(SubType)
    
    public enum SubType {
        case phone
        case email
    }
}

// MARK: - SFUserApi
public protocol SFUserApi {
    // MARK: Com
    /// 发送验证码
    func sendSmsCode(type: SmsCodeType) async -> SFDataResponse
    
    // MARK: Sign
    /// 登录（手机号+验证码）
    func signIn(phone: String, code: String) async -> SFDataResponse
    /// 登录（邮箱+验证码）
    func signIn(email: String, code: String) async -> SFDataResponse
    /// 登录（账号+密码）
    func signIn(account: String, pwd: String) async -> SFDataResponse
    /// 登录（手机号+密码）
    func signIn(phone: String, pwd: String) async -> SFDataResponse
    /// 登录（邮箱号+密码）
    func signIn(email: String, pwd: String) async -> SFDataResponse
    /// 登出
    func signOut() async -> SFDataResponse
    
    // MARK: Pwd
    /// 设置初始密码
    func initialPwd(_ pwd: String) async -> SFDataResponse
    /// 重置密码（手机号+验证码）
    func resetPwd(_ pwd: String, phone: String, code: String) async -> SFDataResponse
    /// 重置密码（邮箱+验证码）
    func resetPwd(_ pwd: String, email: String, code: String) async -> SFDataResponse
    
    // MARK: Info
    /// 获取用户信息
    func getInfo() async -> SFDataResponse
    /// 更新用户信息
    func updateInfo(_ info: [String: Any]) async -> SFDataResponse
    
    // MARK: Other
    /// 注销账号
    func deleteAccount(pwd: String) async -> SFDataResponse
}



