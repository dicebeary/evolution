//
//  NetworkService.swift
//  evolutionMVC
//
//  Created by Vajda Kristóf on 2022. 09. 12..
//

import Foundation

protocol NetworkService {
    /**
     Establishes basic **GET METHOD** type request.
     
     The completionBlock Result's success part contains JSON response in Data object. The GeneralNetworkError is a formalized solution for passing errors to the Domain and UI layer
     */
    func getRequest(
        _ url: String,
        completionBlock: @escaping (Result<Data, GeneralNetworkError>) -> ()
    )

    /**
     Establishes basic **POST METHOD** type request.
     
     The completionBlock Result's success part contains JSON response in Data object. The GeneralNetworkError is a formalized solution for passing errors to the Domain and UI layer
     */
    func postRequest(
        _ url: String,
        payload: [String: String],
        completionBlock: @escaping (Result<Data, GeneralNetworkError>) -> ()
    )
}
