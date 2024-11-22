//
//  ValueInfoCell.swift
//  SFUser
//
//  Created by hsf on 2024/11/20.
//

import Foundation
import UIKit
// Basic
import SFBase
import SFExtension
// UI
import SFUI

// MARK: - ValueInfoCell
public class ValueInfoCell: InfoCell {
    // MARK: ui
    public private(set) lazy var valueLabel: SFLabel = {
         return SFLabel().then { view in
             view.font = .systemFont(ofSize: 17, weight: .medium)
             view.textColor = SFColor.UI.title
         }
     }()
    public override func customUI() {
         super.customUI()
         addSubview(valueLabel)
         
         valueLabel.snp.makeConstraints { make in
             make.leading.equalTo(self.snp.centerX).offset(5)
             make.top.equalToSuperview().offset(10)
             make.trailing.equalTo(detailImgView.snp.leading).offset(-10)
             make.bottom.equalToSuperview().offset(-10)
         }
     }
}
