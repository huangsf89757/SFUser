//
//  SFColor.UI.swift
//  Pods
//
//  Created by hsf on 2024/7/19.
//

import Foundation
import UIKit
// Basic
import SFBase
import SFExtension

// MARK: - SFColor
extension SFColor {
    public struct User {
        public static var bundle = SFLibUser.bundle
        private static func color(name: String) -> UIColor? {
            UIColor.sf.color(name: name, bundle: Self.bundle)
        }
        
        
    }
}


