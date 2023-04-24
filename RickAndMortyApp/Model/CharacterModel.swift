//
//  CharacterModel.swift
//  RickAndMortyApp
//
//  Created by Emre Can Şimşek on 24.04.2023.
//

import Foundation

// MARK: - CharacterModel
struct CharacterModel: Codable {
    let id: Int?
    let name, status, species, type: String?
    let gender: String?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let created: String?
}

// MARK: - Location
struct Location: Codable {
    let name: String?
}

typealias CharactersModel = [CharacterModel]

