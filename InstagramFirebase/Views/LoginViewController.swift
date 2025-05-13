//
//  ViewController.swift
//  InstagramFirebase
//
//  Created by User on 08.05.25.
//

import UIKit
import SnapKit
class ViewController: UIViewController {

    let titleLabel = UILabel()
       let emailTextField = UITextField()
       let passwordTextField = UITextField()
       let loginButton = UIButton()
       let registerButton = UIButton()

       override func viewDidLoad() {
           super.viewDidLoad()
           view.backgroundColor = .white
           setupUI()
       }
       func setupUI() {
           titleLabel.text = "Instagram"
           titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
           titleLabel.textAlignment = .center
           view.addSubview(titleLabel)

           emailTextField.placeholder = "Email and phone"
           emailTextField.borderStyle = .roundedRect
           view.addSubview(emailTextField)

           passwordTextField.placeholder = "Password"
           passwordTextField.isSecureTextEntry = true
           passwordTextField.borderStyle = .roundedRect
           view.addSubview(passwordTextField)

           loginButton.setTitle("Sign In", for: .normal)
           loginButton.backgroundColor = .black
           loginButton.setTitleColor(.white, for: .normal)
           loginButton.layer.cornerRadius = 5
           view.addSubview(loginButton)

           registerButton.setTitle("Don't have an account? Sign up", for: .normal)
           registerButton.setTitleColor(.blue, for: .normal)
           view.addSubview(registerButton)
           setupConstraints()
       }

       func setupConstraints() {
           titleLabel.snp.makeConstraints { make in
               make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
               make.centerX.equalToSuperview()
           }

           emailTextField.snp.makeConstraints { make in
               make.top.equalTo(titleLabel.snp.bottom).offset(40)
               make.left.right.equalToSuperview().inset(16)
               make.height.equalTo(44)
           }

           passwordTextField.snp.makeConstraints { make in
               make.top.equalTo(emailTextField.snp.bottom).offset(20)
               make.left.right.equalToSuperview().inset(16)
               make.height.equalTo(44)
           }

           loginButton.snp.makeConstraints { make in
               make.top.equalTo(passwordTextField.snp.bottom).offset(20)
               make.left.right.equalToSuperview().inset(16)
               make.height.equalTo(44)
           }

           registerButton.snp.makeConstraints { make in
               make.top.equalTo(loginButton.snp.bottom).offset(20)
               make.centerX.equalToSuperview()
           }
       }

}

