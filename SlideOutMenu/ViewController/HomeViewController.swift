//
//  ViewController.swift
//  SlideOutMenu
//
//  Created by Tongtong Liu on 8/14/19.
//  Copyright © 2019 Tongtong Liu. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    fileprivate func setupNavigationItems() {
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(handleOpen))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .done, target: self, action: #selector(handleHide))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        tableView.backgroundColor = .red
    }
    
    let menuViewController = MenuViewController()
    let maxWidth: CGFloat = 300
    
    @objc func handleOpen() {
        menuViewController.view.frame = CGRect(x: -maxWidth, y: 0, width: 300, height: view.frame.height)
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(menuViewController.view)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.menuViewController.view.transform = CGAffineTransform(translationX: self.maxWidth, y: 0)
        })
        
        addChild(menuViewController)
    }
    
    @objc func handleHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.menuViewController.view.transform = .identity
        })
    }
    
    
}

extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellID")
        cell.textLabel?.text = "Row \(indexPath.row)"
        return cell
    }
    
}
