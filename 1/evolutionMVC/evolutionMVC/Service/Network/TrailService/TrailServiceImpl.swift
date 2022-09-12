//
//  TrailServiceImpl.swift
//  evolutionMVC
//
//  Created by Vajda Kristóf on 2022. 09. 12..
//

import Foundation

final class TrailServiceImpl: TrailService {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getTrails(
        completionBlock: @escaping (Result<[NetworkModel.Trail], TrailServiceError>) -> ()
    ) {
        let urlString = TrailServiceAPI.getTrails.urlString
        #if MOCK
        if let path = Bundle.main.path(forResource: "trails", ofType: "json") {
            do {
                let fileURL = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileURL)
                let res = try JSONDecoder().decode([NetworkModel.Trail].self, from: data)
                completionBlock(.success(res))
            } catch let error {
                print(error)
                completionBlock(.failure(.general(.decodingError)))
            }
        } else {
            completionBlock(.failure(.general(.decodingError)))
        }
        #else
        networkService.getRequest(urlString) { result in
            switch result {
                case .success(let data):
                do {
                    let res = try JSONDecoder().decode([NetworkModel.Trail].self, from: data)
                    completionBlock(.success(res))
                } catch let error {
                    print(error)
                    completionBlock(.failure(.general(.decodingError)))
                }
            case .failure(let error):
                print(error)
                completionBlock(.failure(.general(.unknown(error))))
            }
        }
        #endif
    }
    
    func getTrail(
        by id: String,
        completionBlock: @escaping (Result<NetworkModel.Trail, TrailServiceError>) -> ()
    ) {
        let urlString = TrailServiceAPI.getTrail(id: id).urlString
        
        networkService.getRequest(urlString) { result in
            switch result {
                case .success(let data):
                do {
                    let res = try JSONDecoder().decode(NetworkModel.Trail.self, from: data)
                    completionBlock(.success(res))
                } catch let error {
                    print(error)
                    completionBlock(.failure(.general(.decodingError)))
                }
            case .failure(let error):
                print(error)
                completionBlock(.failure(.general(.unknown(error))))
            }
        }
    }
}
