//
//  SFDatabase.swift
//  SFUser
//
//  Created by hsf on 2024/11/30.
//

import Foundation
// Basic
import SFExtension
import SFBase
// Business
import SFBusiness
// Server
import SFLogger
// Third
import WCDBSwift

// MARK: - UserDatanable
extension UserDatanable {
    /// 客户端user数据库
    public var clientDb: Database? {
        return getDb(port: .client)
    }
    /// 客户端user数据库
    public var serverDb: Database? {
        return getDb(port: .server)
    }
    /// 获取user数据库
    public func getDb(port: SFPort) -> Database? {
        do {
            let documentsDirectory = try FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let environmentUrl = documentsDirectory.appendingPathComponent(SFEnvironment.cur.path)
            let portUrl = environmentUrl.appendingPathComponent(port.path)
            let userUrl = environmentUrl.appendingPathComponent(uid)
            let dataURL = portUrl.appendingPathComponent("data.db")
            let db = try Database(at: dataURL)
            return db
        } catch {
            SFDatabaseLogger.error(port: port, type: .none, msgs: "获取userDb", "失败", error.localizedDescription)
            return nil
        }
    }
}
