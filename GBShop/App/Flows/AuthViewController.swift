//
//  AuthViewController.swift
//  GBShop
//
//  Created by Павел Черняев on 07.02.2022.
//

import UIKit
import FirebaseAnalytics

class AuthViewController: UIViewController {
    var loginTextField: UITextField!
    var passwordTextField: UITextField!
    let loginBussinesModel = LoginBussinesModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {

        view.backgroundColor = .systemBackground
        
        let headLabel = setupHeadLabel()
        view.addSubview(headLabel)
        
        let loginLabel = setupLoginLabel()
        view.addSubview(loginLabel)
        
        self.loginTextField = setupLoginTexField()
        view.addSubview(loginTextField)
        
        let passwordLabel = setupPasswordLabel()
        view.addSubview(passwordLabel)
        
        self.passwordTextField = setupPasswordTexField()
        view.addSubview(passwordTextField)
        
        let loginButton = setupLoginButton()
        view.addSubview(loginButton)

        NSLayoutConstraint.activate([
            headLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150),
            headLabel.heightAnchor.constraint(equalToConstant: 40),
            headLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            headLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            
            loginLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 50),
            loginLabel.heightAnchor.constraint(equalToConstant: 40),
            loginLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            loginLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            
            self.loginTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 10),
            self.loginTextField.heightAnchor.constraint(equalToConstant: 30),
            self.loginTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.loginTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            
            passwordLabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordLabel.heightAnchor.constraint(equalToConstant: 40),
            passwordLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            passwordLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            
            self.passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 30),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.passwordTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.heightAnchor.constraint(equalToConstant: 30),
            loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            loginButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            
        ])
    }
    // MARK: - user action
    @objc
    func loginButtonClick() {
        
        //test crash into Crashlytics dashboard
//        let a = loginTextField.text!
//        let b = passwordTextField.text! // b = 0
//        let c = Int(a)! / Int(b)!
        
        loginBussinesModel.send(.login) { response in
            switch response.result {
            case .success(let result):
                Analytics.logEvent(AnalyticsEventLogin, parameters: [
                  "result" : "success"
                  ])
                DispatchQueue.main.async {
                    let productListVC = ProductListViewController()
                    self.present(productListVC, animated: true, completion: nil)
                }
            case .failure(let error):
                Analytics.logEvent(AnalyticsEventLogin, parameters: [
                  "result" : "failure"
                  ])
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - setup views
    private func setupHeadLabel() -> UILabel {
        let headLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        headLabel.translatesAutoresizingMaskIntoConstraints = false
        headLabel.text = "GBShop"
        headLabel.font = .systemFont(ofSize: 40)
        headLabel.textAlignment = .center
        return headLabel
    }
    
    private func setupLoginLabel() -> UILabel {
        let loginLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.text = "Login"
        loginLabel.font = .systemFont(ofSize: 25)
        return loginLabel
    }
    
    private func setupLoginTexField() -> UITextField {
        let loginTextField = UITextField()
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.borderStyle = .line
        loginTextField.font = .systemFont(ofSize: 25)
        loginTextField.autocapitalizationType = .none
        loginTextField.placeholder = "login"
        return loginTextField
    }
    
    private func setupPasswordLabel() -> UILabel {
        let passwordLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.text = "Password"
        passwordLabel.font = .systemFont(ofSize: 25)
        return passwordLabel
    }
    
    private func setupPasswordTexField() -> UITextField {
        let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.borderStyle = .line
        passwordTextField.font = .systemFont(ofSize: 25)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "password"
        return passwordTextField
    }
    
    private func setupLoginButton() -> UIButton {
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.link, for: .normal)
        loginButton.setTitleColor(.systemBackground, for: .highlighted)
        loginButton.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)
        return loginButton
    }
}
