//
//  TrailServiceError.swift
//  evolutionMVC
//
//  Created by Vajda Kristóf on 2022. 09. 12..
//

enum TrailServiceError: NetworkError {
    case notFound
    case outDated
    case trackFailed
    case general(GeneralNetworkError)
}
