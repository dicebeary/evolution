//
//  SignUpViewController.swift
//  evolutionMVC
//
//  Created by Vajda Kristóf on 2022. 09. 08..
//

import UIKit

class SignUpViewController: UIViewController {
    
    private var loginService: LoginService {
        LoginServiceImpl(
            networkService: NetworkServiceImpl(),
            persistencyService: UserDefaultsPersistencyServiceImpl()
        )
    }
    
    var email: String?
    var password: String?

    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var registerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.text = email
        passwordField.text = password
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            loginService.postRegister(email: email, password: password) { result in
                switch result {
                case .success:
                    DispatchQueue.main.async { [weak self] in
                        self?.navigationController?.popViewController(animated: true)
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
    
}
