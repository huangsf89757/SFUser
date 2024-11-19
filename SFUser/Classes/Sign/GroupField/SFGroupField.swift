//
//  SFGroupField.swift
//  SFUser
//
//  Created by hsf on 2024/11/19.
//

import Foundation
import UIKit
// Basic
import SFBase
import SFExtension
// UI
import SFUI

// MARK: - SFGroupField
class SFGroupField: SFView {
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = SFColor.UI.background
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
}
