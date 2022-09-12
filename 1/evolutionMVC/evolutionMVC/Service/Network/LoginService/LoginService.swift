//
//  LoginService.swift
//  evolutionMVC
//
//  Created by Vajda Kristóf on 2022. 09. 12..
//

typealias AccessToken = String

protocol LoginService {
    /**
     Registers the user through network. For providing asynchronous communication, the result signaling back by completionBlock
     - *In case of success*: Emits just an empty object
     - *In case of failure*: Passes the error from response
     */
    func postRegister(
        email: String,
        password: String,
        completionBlock: @escaping (Result<Void, LoginServiceError>) -> ()
    )
    
    /**
     Logs the user in. For providing asynchronous communication, the result signaling back by completionBlock
     - *In case of success*: Gives back the accessToken to use it for secure endpoints
     - *In case of failure*: Passes the error from response
     */
    func postLogin(
        email: String,
        password: String,
        completionBlock: @escaping (Result<AccessToken, LoginServiceError>) -> ()
    )
}
