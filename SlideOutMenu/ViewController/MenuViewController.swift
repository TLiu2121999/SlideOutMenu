//
//  MenuViewController.swift
//  SlideOutMenu
//
//  Created by Tongtong Liu on 8/14/19.
//  Copyright © 2019 Tongtong Liu. All rights reserved.
//

import UIKit

struct MenuItem {
    let icon: UIImage
    let title: String
}

class MenuViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let menuItems = [
        MenuItem(icon: #imageLiteral(resourceName: "people"), title: "Profile"),
        MenuItem(icon: #imageLiteral(resourceName: "message"), title: "List"),
        MenuItem(icon: #imageLiteral(resourceName: "mark"), title: "Bookmarks"),
        MenuItem(icon: #imageLiteral(resourceName: "light"), title: "Moments")
    ]
}

extension MenuViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MenuItemCell(style: .default, reuseIdentifier: "MenuCellID")
        let menuItem = menuItems[indexPath.row]
        
        cell.iconImageView.image = menuItem.icon
        cell.label.text = menuItem.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = CustomMenuHeaderView()
        return view
    }
}
