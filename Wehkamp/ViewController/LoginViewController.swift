//
//  LoginViewController.swift
//  Wehkamp
//
//  Created by Garaj on 19/06/2017.
//  Copyright © 2017 isonka. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,LoginViewModelDelegate {
    
    @IBOutlet weak var usernameTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var loginButton : UIButton!
    
    var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loginViewModel.delegate = self
        
        usernameTextField.addTarget(self, action: #selector(textFieldValueChanged(tf:)), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldValueChanged(tf:)), for: UIControlEvents.editingChanged)
    }
    
    //MARK: Observers
    
    @objc private func textFieldValueChanged(tf:UITextField)
    {
        if !(usernameTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)!
        {
            loginButton.isEnabled = true
        }
        else
        {
            loginButton.isEnabled = false
        }
    }
    
    //MARK: Actions
    
    @IBAction func loginTapped(sender:UIButton)
    {
        loginButton.isEnabled = false
        changeButtonTitle(title: "controleren")
        loginViewModel.login(username: usernameTextField.text!, password: passwordTextField.text!)
    }
    
    //MARK: Helper
    
    func changeButtonTitle(title:String)
    {
        ThreadingHelper.scheduleMain {
            self.loginButton.setTitle(title, for: .normal)
            self.loginButton.setTitle(title, for: .disabled)
        }
    }
    
    //MARK: LoginViewDelegate
    
    func loggedIn() {
        guard let listController = self.storyboard?.instantiateViewController(withIdentifier: Constants.tabBarStoryboardIdentifier) else
        {
            fatalError()
        }
        navigationController?.viewControllers[0] = listController
    }
    
    func loginFailed(errorMessage: String) {
        ThreadingHelper.scheduleMain {
            self.loginButton.isEnabled = true
            self.changeButtonTitle(title: "inloggen")
        }
        
        UIAlertHelper.showAlertView(title: nil, message: errorMessage)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
