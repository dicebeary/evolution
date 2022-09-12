//
//  GeneralNetworkError.swift
//  evolutionMVC
//
//  Created by Vajda Kristóf on 2022. 09. 12..
//

enum GeneralNetworkError: NetworkError {
    case badURL
    case decodingError
    case timeout
    case unknown(Error)
}
