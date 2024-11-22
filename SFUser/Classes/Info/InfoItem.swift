//
//  InfoItem.swift
//  SFUser
//
//  Created by hsf on 2024/11/20.
//

import Foundation
import UIKit

public enum InfoItem {
    case account
    
    case avatar
    case nickname
    case gender
    case motto
    
    case phone
    case email
    
    case birthday
    case address
    
    var text: String? {
        return nil
    }
    
    var image: UIImage? {
       return nil
    }
    
    var hasDetail: Bool {
        switch self {
        case .account:
            return false
        case .avatar:
            return false
        case .nickname:
            return true
        case .gender:
            return true
        case .motto:
            return true
        case .phone:
            return true
        case .email:
            return true
        case .birthday:
            return true
        case .address:
            return true
        }
    }
}
