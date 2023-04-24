//
//  CharacterDetailViewController.swift
//  RickAndMortyApp
//
//  Created by Emre Can Şimşek on 24.04.2023.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    var characterID = String()
    let rickAndMortyService = RickAndMortyService()
    var characterModel = CharacterModel(id: nil, name: nil, status: nil, species: nil, type: nil, gender: nil, origin: nil, location: nil, image: nil, episode: nil, created: nil)
    var formattedDate = String()
    var episodes = String()
    
    
    @IBOutlet weak var characterActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var characterImage: UIImageView!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var specyLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var episodesLabel: UILabel!
    @IBOutlet weak var creadetAtLabel: UILabel!
    
    @IBOutlet weak var specyDetailLabel: UILabel!
    @IBOutlet weak var genderDetailLabel: UILabel!
    @IBOutlet weak var originDetailLabel: UILabel!
    @IBOutlet weak var locationDetailLabel: UILabel!
    @IBOutlet weak var episodesDetailLabel: UILabel!
    @IBOutlet weak var statusDetailLabel: UILabel!
    @IBOutlet weak var creadetAtDetailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacter()
        
    }
    
    func fetchCharacter(){
        characterActivityIndicator.startAnimating()
        self.rickAndMortyService.fetchCharacter(completion: { characterModel in
            self.characterModel = characterModel
            self.setDate()
            self.setCharacter()
        }, character: self.characterID)
    }
    func setCharacter(){
        
        let url = URL(string: characterModel.image ?? "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        
        characterImage.kf.setImage(with: url)
        
        for episode in (characterModel.episode)! {
            episodes = episodes + "\((Int(episode.filter { "0123456789".contains($0) })!)), "
        }
        episodes.removeLast()
        episodes.removeLast()
           
        
        statusLabel.text = "Status:"
        specyLabel.text = "Specy:"
        genderLabel.text = "Gender:"
        originLabel.text = "Origin:"
        locationLabel.text = "Location:"
        episodesLabel.text = "Episodes:"
        creadetAtLabel.text = "Creadet at (in API):"
        
        navigationItem.title = characterModel.name
        statusDetailLabel.text = characterModel.status
        specyDetailLabel.text = characterModel.species
        genderDetailLabel.text = characterModel.gender
        originDetailLabel.text = characterModel.origin?.name
        locationDetailLabel.text = characterModel.location?.name
        episodesDetailLabel.text = episodes
        creadetAtDetailLabel.text = formattedDate
        
        characterImage.isHidden = false
        
        statusLabel.isHidden = false
        specyLabel.isHidden = false
        genderLabel.isHidden = false
        originLabel.isHidden = false
        locationLabel.isHidden = false
        episodesLabel.isHidden = false
        creadetAtLabel.isHidden = false
        
        statusDetailLabel.isHidden = false
        specyDetailLabel.isHidden = false
        genderDetailLabel.isHidden = false
        originDetailLabel.isHidden = false
        locationDetailLabel.isHidden = false
        episodesDetailLabel.isHidden = false
        creadetAtDetailLabel.isHidden = false
        
        self.characterActivityIndicator.isHidden = true
    }
    
    func setDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = dateFormatter.date(from: characterModel.created ?? "2017-11-04T18:50:21.651Z") {
            dateFormatter.dateFormat = "dd MMM yyyy, HH:mm:ss"
            self.formattedDate = dateFormatter.string(from: date)
        }
        
        
        
        
    }
}
