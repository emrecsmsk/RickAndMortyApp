//
//  RickAndMortyService.swift
//  RickAndMortyApp
//
//  Created by Emre Can Şimşek on 24.04.2023.
//

import Foundation
import Alamofire

class RickAndMortyService {    
    
    func fetchPlaces(completion: @escaping (PlacesModel) -> Void){
        
        let url = "https://rickandmortyapi.com/api/location"
        
        let request = AF.request(url, method: .get)
        
        request.responseDecodable(of: PlacesModel.self) { (response) in
            
            guard let placesModel = response.value else {return}
            completion(placesModel)
        }
    }
    
    func fetchCharacters(completion: @escaping (CharactersModel) -> Void, characters: String){
        
        let url = "https://rickandmortyapi.com/api/character/" + characters
        
        let request = AF.request(url, method: .get)
        
        request.responseDecodable(of: CharactersModel.self) { (response) in
            
            guard let charactersModel = response.value else {return}
            completion(charactersModel)
        }
    }
    
    func fetchCharacter(completion: @escaping (CharacterModel) -> Void, character: String){
        
        let url = "https://rickandmortyapi.com/api/character/" + character
        
        let request = AF.request(url, method: .get)
        
        request.responseDecodable(of: CharacterModel.self) { (response) in
            
            guard let characterModel = response.value else {return}
            completion(characterModel)
        }
    }
    
}
