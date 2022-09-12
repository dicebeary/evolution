//
//  LoginServiceError.swift
//  evolutionMVC
//
//  Created by Vajda Kristóf on 2022. 09. 12..
//

enum LoginServiceError: NetworkError {
    case wrongCredentials
    case registrationFailed
    case weakPassword
    case general(GeneralNetworkError)
}
