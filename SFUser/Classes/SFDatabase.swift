//
//  SFDatabase.swift
//  SFUser
//
//  Created by hsf on 2024/11/28.
//

import Foundation
// Business
import SFBusiness
// Server
import SFLogger
// Third
import WCDBSwift

extension SFDatabase {
    /// user数据库
    public static var userDb: Database? {
        guard let currentUser = UserModel.current else { return nil }
        guard let uid = currentUser.uid else { return nil }
        return getUserDb(with: uid)
    }
    public static func getUserDb(with uid: String) -> Database? {
        do {
            let documentsDirectory = try FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let userDirectory = documentsDirectory.appendingPathComponent(uid)
            let databaseURL = userDirectory.appendingPathComponent("data.db")
            return try Database(at: databaseURL)
        } catch {
            SFLogger.debug("Failed to initialize user database: \(error)")
            return nil
        }
    }
}
