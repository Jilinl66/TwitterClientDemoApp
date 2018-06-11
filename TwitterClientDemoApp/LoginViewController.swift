//
//  LoginViewController.swift
//  TwitterClientDemoApp
//
//  Created by Jilin Liu on 6/9/18.
//  Copyright © 2018 JilinStudio, Inc. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: CustomInputTextField! {
        didSet {
            usernameTextField.inputAccessoryView = toolbar
            usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
            usernameTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: CustomInputTextField! {
        didSet {
            passwordTextField.inputAccessoryView = toolbar
            passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
            passwordTextField.delegate = self
        }
    }
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.roundCorner()
            loginButton.enable()
        }
    }
    @IBOutlet weak var coverView: UIView!
    
    var toolbar = UIToolbar()
//    lazy var allTextFields = [usernameTextField, passwordTextField]
    
    @objc private func textDidChange() {
        if usernameTextField.hasText() && passwordTextField.hasText() {
            loginButton.enable()
        } else {
            loginButton.disable()
        }
    }
    
    // TextField begin and end editing delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let customInputField = textField as? CustomInputTextField {
            customInputField.setActiveBorder()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let customInputField = textField as? CustomInputTextField {
            customInputField.setInactiveBorder()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureToolbar()
    }
    
    private func configureToolbar() {
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(doneTapped))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
    }
    
    @objc private func doneTapped() {
        view.endEditing(true)
    }
    
    private let searchSegue = "searchSegue"
    private func login() {
        if TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers() {
            self.performSegue(withIdentifier: searchSegue, sender: nil)
        } else {
            TWTRTwitter.sharedInstance().logIn { (session, error) in
                if (session != nil) {
                    self.log("signed in as: \(session?.userName ?? ""))")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                        self.performSegue(withIdentifier: self.searchSegue, sender: self)
                    }
                    
                } else {
                    self.coverView.isHidden = true
                    self.log("error: \(String(describing: error?.localizedDescription))")
                }
            }
        }
    }
    
    @IBAction func showPasswordButtonClicked(_ sender: UIButton) {
        togglePassword()
    }
    
    private func togglePassword() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        if passwordTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
            passwordTextField.layoutIfNeeded()
        }
    }
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        coverView.isHidden = false
        login()
    }
    
    private func log(_ whatToLog: Any) {
        debugPrint("\(LoginViewController.self): \(whatToLog)")
    }
}
