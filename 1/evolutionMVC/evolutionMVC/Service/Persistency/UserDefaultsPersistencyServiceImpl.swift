//
//  UserDefaultsPersistencyServiceImpl.swift
//  evolutionMVC
//
//  Created by Vajda Kristóf on 2022. 09. 12..
//

import Foundation

public final class UserDefaultsPersistencyServiceImpl: PersistencyService {
    private let name: String?
    private var storage: UserDefaults
    private let isAnonymous: Bool

    public static let standard = UserDefaultsPersistencyServiceImpl()

    private init() {
        self.name = nil
        self.storage = UserDefaults.standard
        self.isAnonymous = false
    }

    public init(name: String? = nil) {
        if let name = name {
            self.name = name
            self.isAnonymous = false
        } else {
            self.name = UUID().uuidString
            self.isAnonymous = true
        }
        self.storage = UserDefaults(suiteName: self.name) ?? UserDefaults.standard
    }

    deinit {
        guard isAnonymous, let domain = Bundle.main.bundleIdentifier else { return }
        storage.removePersistentDomain(forName: domain)
        storage.synchronize()
    }

    @discardableResult
    public func save<T>(object: T, id: String, encoder: JSONEncoder?) -> Bool where T: Codable {
        let encoder = encoder ?? JSONEncoder()
        guard let data = try? encoder.encode(object) else {
            return false
        }

        storage.set(data, forKey: id)
        return true
    }

    public func get<T>(for key: String, decoder: JSONDecoder?) throws -> T? where T: Codable {
        let decoder = decoder ?? JSONDecoder()
        guard let data = storage.object(forKey: key) as? Data else {
            throw PersistencyError.dataNotFound
        }

        guard let object = try? decoder.decode(T.self, from: data) else {
            throw PersistencyError.dataCorrupted
        }

        return object
    }

    @discardableResult
    public func clearStorage() -> Bool {
        storage = UserDefaults(suiteName: name) ?? UserDefaults.standard
        return true
    }

    @discardableResult
    public func clear(by id: String) -> Bool {
        storage.removeObject(forKey: id)
        return true
    }
}
