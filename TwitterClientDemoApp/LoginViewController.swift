//
//  LoginViewController.swift
//  TwitterClientDemoApp
//
//  Created by Jilin Liu on 6/9/18.
//  Copyright © 2018 JilinStudio, Inc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField! {
        didSet {
            usernameTextField.inputAccessoryView = toolbar
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.inputAccessoryView = toolbar
        }
    }
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.roundCorner()
        }
    }
    
    @IBOutlet weak var coverView: UIView!
    
    var toolbar = UIToolbar()
    
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
    
    private func login() {
        // TODO
    }
    
    @IBAction func showPasswordButtonClicked(_ sender: UIButton) {
        togglePassword()
    }
    
    private func togglePassword() {
        //TODO
        print("Toggle password")
    }
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        coverView.isHidden = false
        login()
    }
}
