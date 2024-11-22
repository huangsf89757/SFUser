//
//  InfoVC.swift
//  IQKeyboardManagerSwift
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

// MARK: - InfoVC
public class InfoVC: SFTableViewController {
    // MARK: data
    var items: [[InfoItem]] = [
        [.account],
        [.avatar, .nickname, .gender, .motto],
        [.phone, .email],
        [.birthday, .address],
    ]
    
    // MARK: init
    public convenience init() {
        self.init(style: .grouped)
    }
    private override init(style: UITableView.Style) {
        super.init(style: style)
        setUp()
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = SFText.User.info
    }
    
    // MARK: setup
    private func setUp() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: AvatarInfoCell.self)
        tableView.register(cellType: ValueInfoCell.self)
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension InfoVC: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section][indexPath.row]
        if item == .avatar {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: AvatarInfoCell.self)
            cell.item = item
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ValueInfoCell.self)
            cell.item = item
            return cell
        }
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
