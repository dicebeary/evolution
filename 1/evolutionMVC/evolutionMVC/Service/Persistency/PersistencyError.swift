//
//  PersistencyError.swift
//  evolutionMVC
//
//  Created by Vajda Kristóf on 2022. 09. 12..
//

public enum PersistencyError: Error {
    case dataNotFound
    case dataCorrupted
    case general
}
