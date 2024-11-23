//
//  SignPageView.swift
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
// Third
import IQKeyboardManagerSwift

// MARK: - SignPageView
public class SignPageView: SFScrollView {
    // MARK: block
    public var pageDidChangedBlock: ((SignPageView, Int) -> ())?
    public var forgetPwdBlock: (()->())? {
        didSet {
            pwdView.forgetPwdBlock = forgetPwdBlock
        }
    }
    
    // MARK: var
    public internal(set) var curPageIndex: Int = 0
    
    // MARK: life cycle
    public convenience init() {
        self.init(dir: .horizontal)
    }
    
    private override init(dir: SFScrollView.Direction) {
        super.init(dir: dir)
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        isPagingEnabled = true
        delegate = self
        shouldIgnoreScrollingAdjustment = true // 这个可以使得IQKeyboardManagerSwift忽略当前ScrollView
        customUI()
    }
    
    // MARK: ui
    public private(set) lazy var codeView: CodeContentView = {
        return CodeContentView()
    }()
    
    public private(set) lazy var pwdView: PwdContentView = {
        return PwdContentView()
    }()
    
    private func customUI() {
        contentView.addSubview(codeView)
        contentView.addSubview(pwdView)
        
        codeView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(self).offset(-20)
            make.bottom.lessThanOrEqualToSuperview()
        }
        pwdView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalTo(codeView.snp.trailing).offset(20)
            make.width.equalTo(self).offset(-20)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
}

// MARK: - UIScrollViewDelegate
extension SignPageView: UIScrollViewDelegate {
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = scrollView.frame.width
        let currentPage = scrollView.contentOffset.x / pageWidth
        let targetPage: Int
        
        if velocity.x > 0 {
            // 向右滑动
            targetPage = min(Int(ceil(currentPage)), 1)
        } else if velocity.x < 0 {
            // 向左滑动
            targetPage = max(Int(floor(currentPage)), 0)
        } else {
            // 速度为0,四舍五入到最近的页面
            targetPage = Int(round(currentPage))
        }
        
        let newTargetOffset = CGFloat(targetPage) * pageWidth
        targetContentOffset.pointee.x = newTargetOffset
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updatePageSelection(for: scrollView)
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        updatePageSelection(for: scrollView)
    }
    
    private func updatePageSelection(for scrollView: UIScrollView) {
        let pageWidth = frame.width
        let newPageIndex = Int(round(scrollView.contentOffset.x / pageWidth))
        if curPageIndex != newPageIndex {
            curPageIndex = newPageIndex
            pageDidChangedBlock?(self, curPageIndex)
        }
    }
    
    internal func changePage(to index: Int) {
        let pageWidth = frame.width
        let newOffset = CGFloat(index) * pageWidth
        setContentOffset(CGPoint(x: newOffset, y: 0), animated: false)
    }
}
