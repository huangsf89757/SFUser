//
//  Gender.swift
//  IQKeyboardManagerSwift
//
//  Created by hsf on 2024/11/20.
//

import Foundation
import UIKit
// Basic
import SFBase

public enum Gender: Int {
    case unknown = 0
    case male
    case female
    
    var icon: UIImage? {
        switch self {
        case .unknown:
            return nil
        case .male:
            return SFImage.User.Gender.male
        case .female:
            return SFImage.User.Gender.female
        }
    }
    
    var text: String {
        switch self {
        case .unknown:
            return SFText.User.gender_unknown
        case .male:
            return SFText.User.gender_male
        case .female:
            return SFText.User.gender_female
        }
    }
}

