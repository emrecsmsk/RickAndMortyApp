//
//  PlacesModel.swift
//  RickAndMortyApp
//
//  Created by Emre Can Şimşek on 24.04.2023.
//

import Foundation

// MARK: - PlacesModel
struct PlacesModel: Codable {
    let info: Info?
    let results: [Result]?
    
    init() {
            info = Info(pages: 0)
            results = []
        }
}

// MARK: - Info
struct Info: Codable {
    let pages: Int
}

// MARK: - Result
struct Result: Codable {
    let name: String
    let residents: [String]
}
