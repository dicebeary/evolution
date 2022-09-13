//
//  PersistencyService.swift
//  evolutionMVC
//
//  Created by Vajda Kristóf on 2022. 09. 12..
//

import Foundation

public protocol PersistencyService {
    @discardableResult
    func save<T: Codable>(object: T, id: String, encoder: JSONEncoder?) -> Bool

    func get<T: Codable>(for key: String, decoder: JSONDecoder?) throws -> T?

    @discardableResult
    func clearStorage() -> Bool

    @discardableResult
    func clear(by id: String) -> Bool
}

public extension PersistencyService {
    @discardableResult
    func save<T: Codable>(object: T, id: String, encoder: JSONEncoder? = nil) -> Bool {
        save(object: object, id: id, encoder: encoder)
    }

    func get<T: Codable>(for key: String, decoder: JSONDecoder? = nil) throws -> T? {
        try get(for: key, decoder: decoder)
    }
}
