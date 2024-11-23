//
//  GroupField.swift
//  SFUser
//
//  Created by hsf on 2024/11/19.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// UI
import SFUI

// MARK: - GroupField
public class GroupField: SFView {
    // MARK: life cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = SFColor.UI.background
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
}
