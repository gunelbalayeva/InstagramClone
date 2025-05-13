//
//  ViewController.swift
//  InstagramFirebase
//
//  Created by User on 08.05.25.

// nazlibalayeva@gmail.com
// nazli12345

// muzaffarbalayev@gmail.com
// muzaffar12345

// password: 12345678
// email: gunelbalayeva@gmail.com

// gultacrustamova@gmail.com
// gultac12345

import UIKit
import SnapKit
import Firebase
class LoginViewController: UIViewController {
    let titleLabel = UILabel()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    let registerButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        navigationItem.hidesBackButton = true
    }
    
    func setupUI() {
        titleLabel.text = "Instagram"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        emailTextField.placeholder = "Email"
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
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        
        registerButton.setTitle("Don't have an account? Sign up", for: .normal)
        registerButton.setTitleColor(.blue, for: .normal)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
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
    
    @objc
    func loginButtonTapped() {
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        guard !email.isEmpty, !password.isEmpty else {
            makeAlert(inputTitle: "Error", inputMessage: "Username/Password?")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authdata, error in
            if error != nil {
                self.makeAlert(inputTitle: "Error...", inputMessage: error?.localizedDescription ?? "Error")
                return
            }
            let vc = MainTabBarController()
            self.navigationController?.pushViewController(vc, animated: true)
            self.makeAlert(inputTitle: "Successfull", inputMessage: authdata?.user.uid ?? "")
        }
    }
    
    
    @objc
    func registerButtonTapped() {
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

