//
//  ViewController.swift
//  SlideOutMenu
//
//  Created by Tongtong Liu on 8/14/19.
//  Copyright © 2019 Tongtong Liu. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    let window = UIApplication.shared.keyWindow
    let menuViewController = MenuViewController()
    let maxWidth: CGFloat = 300
    var isMenuOpen: Bool = false
    let velocityThreshhold: CGFloat = 500
    
    lazy var darkOverlay: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.alpha = 0
        view.isUserInteractionEnabled = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        tableView.backgroundColor = .red
        setupMenuView()
        setupPanGesture()
        window?.addSubview(darkOverlay)
        darkOverlay.frame = window?.bounds ?? .zero
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let trans = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        switch gesture.state {
        case .changed:
            var x = trans.x
            
            if isMenuOpen {
                x += maxWidth
            }
            
            x = max(0, x)
            x = min(maxWidth, x)
            
            let transform = CGAffineTransform(translationX: x, y: 0)
            navigationController?.view.transform = transform
            menuViewController.view.transform = transform
            darkOverlay.transform = transform
            darkOverlay.alpha = x/maxWidth
        case .ended:
            handleEnded(velocity, trans)
        default:
            return
        }
        
    }
    
    @objc func handleOpen() {
        isMenuOpen = true
        performAnimation(transform: CGAffineTransform(translationX: self.maxWidth, y: 0))
    }
    
    @objc func handleHide() {
        isMenuOpen = false
        performAnimation(transform: .identity)
    }
    
    // MARK: fileprivate functions
    fileprivate func setupPanGesture() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(gesture)
    }
    
    fileprivate func setupNavigationItems() {
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(handleOpen))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .done, target: self, action: #selector(handleHide))
    }
    
    fileprivate func setupMenuView() {
        menuViewController.view.frame = CGRect(x: -maxWidth, y: 0, width: 300, height: view.frame.height)
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(menuViewController.view)
        addChild(menuViewController)
    }
    
    fileprivate func performAnimation(transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.navigationController?.view.transform = transform
            self.menuViewController.view.transform = transform
            self.darkOverlay.transform = transform
            self.darkOverlay.alpha = transform.isIdentity ? 0 : 1
        })
    }
    
    fileprivate func handleEnded(_ velocity: CGPoint, _ trans: CGPoint) {
        if isMenuOpen {
            if abs(velocity.x) > velocityThreshhold {
                handleHide()
                return
            }
            
            if abs(trans.x) > 150 {
                handleHide()
            } else {
                handleOpen()
            }
        } else {
            if velocity.x > velocityThreshhold {
                handleOpen()
                return
            }
            
            if trans.x > 150 {
                handleOpen()
            } else {
                handleHide()
            }
        }
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
