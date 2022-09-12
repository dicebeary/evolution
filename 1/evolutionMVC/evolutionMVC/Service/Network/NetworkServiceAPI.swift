//
//  NetworkServiceAPI.swift
//  evolutionMVC
//
//  Created by Vajda Kristóf on 2022. 09. 12..
//

enum NetworkAPI {
    static var baseURL: String {
        #if STAGING
        "http://0.0.0.0:8882"
        #else
        "https://onlyforshowcase.com"
        #endif
    }
}

protocol NetworkServiceAPI {
    var path: String { get }
    var servicePath: String { get }
    var payload: [String: String] { get }
    var urlString: String { get }
}

extension NetworkServiceAPI {
    var payload: [String: String] { [:] }
}
