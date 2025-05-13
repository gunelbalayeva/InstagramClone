//
//  MainTabBarController.swift
//  InstagramFirebase
//
//  Created by User on 13.05.25.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        let feedVC = FeedViewController()
        feedVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house"), tag: 0)

        let uploadVC = UploadViewController()
        uploadVC.tabBarItem = UITabBarItem(title: "Upload", image: UIImage(systemName: "plus.app"), tag: 1)

        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)

        viewControllers = [
            UINavigationController(rootViewController: feedVC),
            UINavigationController(rootViewController: uploadVC),
            UINavigationController(rootViewController: settingsVC)
        ]
    }
}
