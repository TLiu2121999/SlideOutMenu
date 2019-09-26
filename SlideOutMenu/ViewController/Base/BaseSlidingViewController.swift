//
//  BaseSlidingViewController.swift
//  SlideOutMenu
//
//  Created by Tongtong Liu on 8/15/19.
//  Copyright © 2019 Tongtong Liu. All rights reserved.
//

import UIKit

class BaseSlidingViewController: UIViewController {
    
    let menuWidth: CGFloat = 300
    var isMenuOpen: Bool = false
    let velocityThreshhold: CGFloat = 500
    
    var redLeadingConstraint: NSLayoutConstraint!
    lazy var blueView: UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var redView: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var darkOverlay: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupSubviews()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let trans = gesture.translation(in: view)
        var x = trans.x
        x = isMenuOpen ? x + menuWidth : x
        x = min(x, menuWidth)
        x = max(0, x)
        redLeadingConstraint.constant = x
        darkOverlay.alpha = x / menuWidth
        if gesture.state == .ended {
            handleEnd(gesture: gesture)
        }
    }
    
    fileprivate func openMenu() {
        isMenuOpen = true
        redLeadingConstraint.constant = menuWidth
        performAction()
    }
    
    fileprivate func closeMenu() {
        redLeadingConstraint.constant = 0
        isMenuOpen = false
        performAction()
    }
    
    fileprivate func performAction() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.darkOverlay.alpha = self.isMenuOpen ? 1 : 0
        })
    }
    
    @objc func handleEnd(gesture: UIPanGestureRecognizer) {
        let trans = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        if isMenuOpen {
            if abs(velocity.x) > velocityThreshhold {
                closeMenu()
                return
            }
            if trans.x > menuWidth / 2 {
                openMenu()
            } else {
                closeMenu()
            }
        } else {
            if abs(velocity.x) > velocityThreshhold {
                openMenu()
                return
            }
            if trans.x > menuWidth / 2 {
                openMenu()
            } else {
                closeMenu()
            }
        }
        
        performAction()
    }
    
    fileprivate func setupSubviews() {
        view.addSubview(redView)
        view.addSubview(blueView)
        
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            redView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            blueView.topAnchor.constraint(equalTo: view.topAnchor),
            blueView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blueView.trailingAnchor.constraint(equalTo: redView.safeAreaLayoutGuide.leadingAnchor),
            blueView.widthAnchor.constraint(equalToConstant: menuWidth)
            ])
        redLeadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        redLeadingConstraint.isActive = true
        
        setupViewControllers()
    }
    
    fileprivate func setupViewControllers() {
        let homeVC = HomeViewController()
        let menuVC = MenuViewController()
        
        let homeView = homeVC.view!
        let menuView = menuVC.view!
        
        redView.addSubview(homeView)
        redView.addSubview(darkOverlay)
        blueView.addSubview(menuView)
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: redView.topAnchor),
            homeView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            homeView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
            homeView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            
            menuView.topAnchor.constraint(equalTo: blueView.topAnchor),
            menuView.bottomAnchor.constraint(equalTo: blueView.bottomAnchor),
            menuView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor),
            menuView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
            
            darkOverlay.topAnchor.constraint(equalTo: redView.topAnchor),
            darkOverlay.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            darkOverlay.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            darkOverlay.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
        ])
        
        addChild(homeVC)
        addChild(menuVC)
    }
}
