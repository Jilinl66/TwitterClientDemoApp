//
//  LoginViewController.swift
//  TwitterClientDemoApp
//
//  Created by Jilin Liu on 6/9/18.
//  Copyright © 2018 JilinStudio, Inc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var coverView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
