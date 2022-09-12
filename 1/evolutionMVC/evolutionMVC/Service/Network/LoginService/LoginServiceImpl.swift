//
//  LoginServiceImpl.swift
//  evolutionMVC
//
//  Created by Vajda Kristóf on 2022. 09. 12..
//

import Foundation

final class LoginServiceImpl: LoginService {
    
    private let networkService: NetworkService
    private let persistencyService: PersistencyService
    
    init(
        networkService: NetworkService,
        persistencyService: PersistencyService
    ) {
        self.networkService = networkService
        self.persistencyService = persistencyService
    }

    func postRegister(
        email: String,
        password: String,
        completionBlock: @escaping (Result<Void, LoginServiceError>) -> ()
    ) {
        #if MOCK
        self.saveCredentials(email: email, password: password)

        completionBlock(.success(()))
        #else
        let endpoint = LoginServiceAPI.postRegister(email: email, password: password)

        networkService.postRequest(endpoint.urlString, payload: endpoint.payload) { result in
            switch result {
            case .success:
                completionBlock(.success(()))
            case .failure(let failure):
                completionBlock(.failure(.general(.unknown(failure))))
            }
        }
        #endif
    }
    
    func postLogin(
        email: String,
        password: String,
        completionBlock: @escaping (Result<AccessToken, LoginServiceError>) -> ()
    ) {
        #if MOCK
        if let users: [String] = persistencyService.get(for: "users", decoder: nil),
           users.contains("\(email):\(password)") {
            completionBlock(.success(("accessToken")))
        } else {
            completionBlock(.failure(.wrongCredentials))
        }
        #else
        let endpoint = LoginServiceAPI.postLogin(email: email, password: password)

        networkService.postRequest(endpoint.urlString, payload: endpoint.payload, completionBlock: { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let res = try JSONDecoder().decode(NetworkModel.LoginResponse.self, from: data)
                    let token: AccessToken = res.accessToken
                    completionBlock(.success(token))
                    self?.saveCredentials(email: email, password: password)
                } catch let error {
                    print(error)
                    completionBlock(.failure(.general(.decodingError)))
                }
            case .failure(let failure):
                completionBlock(.failure(.general(failure)))
            }
        })
        #endif
    }

}

private extension LoginServiceImpl {
    func saveCredentials(email: String, password: String) {
        if var users: [String] = try? persistencyService.get(for: "users", decoder: nil) {
            users.append("\(email):\(password)")
            persistencyService.save(object: users, id: "users", encoder: nil)
        } else {
            persistencyService.save(object: ["\(email):\(password)"], id: "users", encoder: nil)
        }
    }
}
