//
//  TrailServiceAPI.swift
//  evolutionMVC
//
//  Created by Vajda Kristóf on 2022. 09. 12..
//

import Foundation

enum TrailServiceAPI: NetworkServiceAPI {
    case getTrails
    case getTrail(id: String)
    
    var servicePath: String { "/trailService/v1" }
    
    var path: String {
        switch self {
        case .getTrails:
            return "/trails"
        case .getTrail(let id):
            return "/trails/\(id)"
        }
    }
    
    var urlString: String {
        switch self {
        case .getTrails:
            return NetworkAPI.baseURL + self.servicePath + TrailServiceAPI.getTrails.path
        case .getTrail(let id):
            return NetworkAPI.baseURL + self.servicePath + TrailServiceAPI.getTrail(id: id).path
        }
    }
}
