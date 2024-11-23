//
//  SignModeView.swift
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

// MARK: - SignModeView
public class SignModeView: SFSegmentView {
    // MARK: life cycle
    public convenience init() {
        let titles = SignMode.allCases.map { mode in
            mode.text
        }
        self.init(titles: titles, images: nil, selectedImages: nil)
    }
    
    private override init(direction: SFSegmentView.Direction = .horizontal, titles: [String?]?, images: [UIImage?]?, selectedImages: [UIImage?]? = nil) {
        super.init(direction: .horizontal, titles: titles, images: images, selectedImages: selectedImages)
        titleFont = .systemFont(ofSize: 14, weight: .regular)
        selectedTitleFont = .systemFont(ofSize: 14, weight: .bold)
    }
    
}
