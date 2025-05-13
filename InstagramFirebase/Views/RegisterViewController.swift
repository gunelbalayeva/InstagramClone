//
//  RegisterViewController.swift
//  InstagramFirebase
//
//  Created by User on 09.05.25.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    let titleLabel = UILabel()
    let usernameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let registerButton = UIButton()
    let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        setupUI()
    }
    
    func setupUI() {
        titleLabel.text = "Instagram"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        usernameTextField.placeholder = "Username"
        usernameTextField.borderStyle = .roundedRect
        view.addSubview(usernameTextField)
        
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        view.addSubview(emailTextField)
        
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        view.addSubview(passwordTextField)
        
        registerButton.setTitle("Sign Up", for: .normal)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.backgroundColor = .black
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 5
        view.addSubview(registerButton)
        
        loginButton.setTitle("Already have an account? Sign in", for: .normal)
        loginButton.setTitleColor(.blue, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.centerX.equalToSuperview()
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    
    @objc
    func registerButtonTapped() {
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard let username = usernameTextField.text, !username.isEmpty else {
            makeAlert(inputTitle: "Xəta", inputMessage: "İstifadəçi adını daxil edin.")
            return
        }
        guard !email.isEmpty, !password.isEmpty else {
            makeAlert(inputTitle: "Xəta", inputMessage: "Email və şifrəni düzgün daxil edin.")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { authData, error in
            if let error = error {
                self.makeAlert(inputTitle: "Xəta", inputMessage: error.localizedDescription)
                return
            }
            guard let user = authData?.user else { return }
            
            let userData: [String: Any] = [
                "username": username,
                "email": email
            ]
            Firestore.firestore().collection("Users").document(user.uid).setData(userData) { error in
                if let error = error {
                    self.makeAlert(inputTitle: "Xəta", inputMessage: "İstifadəçi məlumatları yazıla bilmədi: \(error.localizedDescription)")
                } else {
                    let vc = MainTabBarController()
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.makeAlert(inputTitle: "Uğurlu", inputMessage: "Qeydiyyat tamamlandı")
                }
            }
        }
    }
    
    @objc
    func loginButtonTapped() {
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
