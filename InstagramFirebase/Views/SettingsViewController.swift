//
//  SettingsViewController.swift
//  InstagramFirebase
//
//  Created by User on 09.05.25.
//

import UIKit
import Firebase
class SettingsViewController: UIViewController {
    
    let logoutButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Logout", for: .normal)
        btn.backgroundColor = .black
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
            make.left.right.equalToSuperview().inset(16)
        }
        view.backgroundColor = .white
        //        setupGradientBackground()
    }
    func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.systemPink.cgColor,
            UIColor.systemPurple.cgColor,
            UIColor.systemBlue.cgColor
        ]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        view.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = view.bounds
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateGradientLayerFrame),
                                               name: UIDevice.orientationDidChangeNotification,
                                               object: nil)
    }
    
    @objc
    func updateGradientLayerFrame() {
        if let gradientLayer = view.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = view.bounds
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func logoutButtonTapped() {
        do {
            try Auth.auth().signOut()
            if let sceneDelegate = UIApplication.shared.connectedScenes
                .first?.delegate as? SceneDelegate {
                let loginVC = LoginViewController()
                let navController = UINavigationController(rootViewController: loginVC)
                sceneDelegate.window?.rootViewController = navController
            }
        } catch {
            makeAlert(inputTitle: "Error", inputMessage: "Çıxış etmək mümkün olmadı")
        }
    }
    
}
