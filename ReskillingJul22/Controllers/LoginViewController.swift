//
//  ViewController.swift
//  ReskillingJul22
//
//  Created by Hugo Dominguez on 14/07/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var textFieldUser: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateSession()
    }
    
    @IBAction func buttonAction() {
        if let username = textFieldUser.text, let password = textFieldPassword.text {
            if username.isEmpty || password.isEmpty {
                showAlertMessage(title: "Error", message: "Usuario y/o contraseña no pueden ir vacíos")
            } else {
                validateLogin(username: username, password: password)
            }
        }
        
    }

}


//MARK: Internal Functions
extension LoginViewController {
    
    private func setupUI() {
        self.view.backgroundColor = RCValues.sharedInstance.color(forKey: .appPrimaryColor)
    }
    
    private func validateLogin(username: String, password: String) {
        Auth.auth().signIn(withEmail: username, password: password) { user, error in
            if let _ = error, user == nil {
                DispatchQueue.main.async {
                    self.showAlertMessage(title: "Error", message: "Usuario y/o contraseña incorrectos")
                }
            } else {
                DispatchQueue.main.async {
                    UserDefaults.standard.set(true, forKey: "IsLoggedIn")
                    self.emptyFields()
                    self.presentAnimals()
                }
            }
        }
    }
    
    private func emptyFields() {
        textFieldUser.text = ""
        textFieldPassword.text = ""
    }
    
    private func showAlertMessage(title: String, message: String) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertView.addAction(okAction)
        present(alertView, animated: true)
    }
    
    private func presentAnimals() {
        let storyboard = UIStoryboard(name: "TableViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "tableViewController")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    private func validateSession() {
        if UserDefaults.standard.bool(forKey: "IsLoggedIn") == true {
            presentAnimals()
        }
    }
}

