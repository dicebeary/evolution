//
//  Trail.swift
//  evolutionMVC
//
//  Created by Vajda Kristóf on 2022. 09. 12..
//

extension NetworkModel {
    struct Trail: Decodable {
        let id: Int
        let name: String
        let city: String
        let zip: Int
        let address: String
        let lat: String
        let lng: String
        let desc: String
        let difficulty: Int
        let surface: String
        let parking: String
        let facilities: String
        let hours: String
        let satImgURL: String
        let largeImgURL: String
        let thumbURL: String
        let attractions: [String]
        let rating: Double
        let ratings: Int
        let favorites: Int
//        let modifiedTime: String
        let reviews: Int
    }
}
