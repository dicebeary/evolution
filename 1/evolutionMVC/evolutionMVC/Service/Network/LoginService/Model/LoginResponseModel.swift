//
//  LoginResponseModel.swift
//  evolutionMVC
//
//  Created by Vajda Kristóf on 2022. 09. 12..
//

extension NetworkModel {
    struct LoginResponse: Decodable {
        var accessToken: String
    }
}
