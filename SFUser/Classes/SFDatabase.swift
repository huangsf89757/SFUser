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
    public static func getUserDb(with uid: String) -> Database? {
        do {
            let documentsDirectory = try FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let userDirectory = documentsDirectory.appendingPathComponent(uid)
            let databaseURL = userDirectory.appendingPathComponent("data.db")
            return try Database(at: databaseURL)
        } catch {
            SFDbLogger.dbError(type: .none, msgs: "获取userDb", "失败", error.localizedDescription)
            return nil
        }
    }
}
