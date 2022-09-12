//
//  NetworkServiceImpl.swift
//  evolutionMVC
//
//  Created by Vajda Kristóf on 2022. 09. 12..
//

import Foundation

final class NetworkServiceImpl: NetworkService {
    func getRequest(
        _ url: String,
        completionBlock: @escaping (Result<Data, GeneralNetworkError>) -> ()
    ) {
        guard let url = URL(string: url) else {
            completionBlock(.failure(.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                completionBlock(.success(data))
            } else if let error = error {
                completionBlock(.failure(.unknown(error)))
            }
        }
        
        task.resume()
    }
    
    func postRequest(
        _ url: String,
        payload: [String: String],
        completionBlock: @escaping (Result<Data, GeneralNetworkError>) -> ()
    ) {
        let jsonData = try? JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted)
            
        guard let url = URL(string: url) else {
            completionBlock(.failure(.badURL))
            return
        }
        
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
                
        request.httpMethod = "POST"
        
        let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
            if let data = data {
                completionBlock(.success(data))
            } else if let error = error {
                completionBlock(.failure(.unknown(error)))
            }
        }
        
        task.resume()
    }
}
