//
//  LoginViewController.swift
//  evolutionMVC
//
//  Created by Vajda Kristóf on 2022. 09. 08..
//

import UIKit

class LoginViewController: UIViewController {
    
    private var loginService: LoginService {
        LoginServiceImpl(
            networkService: NetworkServiceImpl(),
            persistencyService: UserDefaultsPersistencyServiceImpl()
        )
    }

    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }

    @objc
    func loginButtonTapped() {
        let email = emailField.text
        let password = passwordField.text
        
        loginService.postLogin(
            email: email ?? "",
            password: password ?? "") { result in
                switch result {
                case .success:
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    DispatchQueue.main.async {
                        let viewController = storyboard.instantiateInitialViewController()!
                        let navC = UINavigationController(rootViewController: viewController)
                        
                        UIApplication.shared.keyWindow?.rootViewController = navC
                    }
                case .failure:
                    let alert = UIAlertController(title: "Wrong credentials", message: "E-mail or password is not correct. If you are not registered, please register", preferredStyle: .alert)
                    alert.addAction(.init(title: "Let's try again", style: .default))
                    alert.addAction(.init(title: "Let's register", style: .default) { [weak self] alert in
                        if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "signUp") as? SignUpViewController {
                            vc.email = email
                            vc.password = password
                            self?.navigationController?.pushViewController(vc, animated: true)
                        }
                    })
                    
                    DispatchQueue.main.async { [weak self] in
                        self?.present(alert, animated: true)
                    }
                }
            }
        
//        let users = UserDefaults.standard.object(forKey: "users") as? [String]
//
//        if users?.contains("\(String(describing: email)):\(String(describing: password))") == true {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let viewController = storyboard.instantiateInitialViewController()!
//            let navC = UINavigationController(rootViewController: viewController)
//
//            UIApplication.shared.keyWindow?.rootViewController = navC
//        } else {
//            let alert = UIAlertController(title: "Wrong credentials", message: "E-mail or password is not correct. If you are not registered, please register", preferredStyle: .alert)
//            alert.addAction(.init(title: "Let's try again", style: .default))
//            alert.addAction(.init(title: "Let's register", style: .default) { [weak self] alert in
//                if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "signUp") as? SignUpViewController {
//                    vc.email = email
//                    vc.password = password
//                    self?.navigationController?.pushViewController(vc, animated: true)
//                }
//            })
//
//            self.present(alert, animated: true)
//        }
    }
}

