//
//  LoginServiceAPI.swift
//  evolutionMVC
//
//  Created by Vajda Kristóf on 2022. 09. 12..
//

enum LoginServiceAPI: NetworkServiceAPI {
    case postRegister(email: String, password: String)
    case postLogin(email: String, password: String)
    
    var servicePath: String { "/loginService/v1" }
    
    var path: String {
        switch self {
        case .postRegister:
            return "/register"
        case .postLogin:
            return "/login/"
        }
    }
    
    var payload: [String : String] {
        switch self {
        case .postRegister(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        case .postLogin(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        }
    }
    
    var urlString: String {
        switch self {
        case .postRegister(let email, let password):
            return NetworkAPI.baseURL +
                self.servicePath +
                LoginServiceAPI.postRegister(email: email, password: password).path
        case .postLogin(let email, let password):
            return NetworkAPI.baseURL +
                self.servicePath +
                LoginServiceAPI.postLogin(email: email, password: password).path
        }
    }

}
