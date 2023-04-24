//
//  HomeViewController.swift
//  RickAndMortyApp
//
//  Created by Emre Can Şimşek on 22.04.2023.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var placesActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var charactersActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var placesCollectionView: UICollectionView!
    @IBOutlet weak var charactersTableView: UITableView!
    
    
    var selectionItem = 0
    let rickAndMortyService = RickAndMortyService()
    var placesModel = PlacesModel()
    var charactersModel = CharactersModel()
    var charactersId = String()
    var characterId = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        placesActivityIndicator.startAnimating()
        charactersActivityIndicator.startAnimating()
        fetchPlaces()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func fetchPlaces(){
        rickAndMortyService.fetchPlaces {placesModel in
            self.placesModel = placesModel
            self.placesCollectionView.reloadData()
            if placesModel.results?[0].residents != [] {
                for character in (placesModel.results?[0].residents)! {
                    self.charactersId = self.charactersId + "\((Int(character.filter { "0123456789".contains($0) })!)),"
                }
                self.placesActivityIndicator.isHidden = true
                self.placesCollectionView.isHidden = false
                self.fetchCharacters()
            }
        }
    }
    func fetchCharacters(){
        
        self.charactersActivityIndicator.isHidden = false
        self.charactersTableView.isHidden = true
        self.rickAndMortyService.fetchCharacters(completion: { charactersModel in
            self.charactersModel = charactersModel
            self.charactersTableView.reloadData()
            self.charactersActivityIndicator.isHidden = true
            self.charactersTableView.isHidden = false
        }, characters: self.charactersId)
        
        
    }
    
    // MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placesModel.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = placesCollectionView.dequeueReusableCell(withReuseIdentifier: "placesCell", for: indexPath) as! PlacesCollectionViewCell
        
        cell.placesLabel.text = placesModel.results?[indexPath.row].name
        
        if indexPath.row == selectionItem {
            cell.backgroundColor = .white
        }else{
            cell.backgroundColor = .systemGray4
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectionItem = indexPath.row
        self.placesCollectionView.reloadData()
        
        
        if placesModel.results?[indexPath.row].residents != [] {
            charactersId = String()
            for character in (placesModel.results?[indexPath.row].residents)! {
                charactersId = charactersId + "\((Int(character.filter { "0123456789".contains($0) })!)),"
            }
            fetchCharacters()
        }else{
            charactersModel = CharactersModel()
            charactersTableView.reloadData()
        }
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        charactersModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = charactersTableView.dequeueReusableCell(withIdentifier: "characterCell") as! CharacterTableViewCell
        
        cell.nameLabel.text = charactersModel[indexPath.row].name
        
        let url = URL(string: charactersModel[indexPath.row].image ?? "https://rickandmortyapi.com/api/character/avatar/1.jpeg")

        cell.characterImage.kf.setImage(with: url)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        characterId = "\((charactersModel[indexPath.row].id)!)"
        performSegue(withIdentifier: "toCharacterDetail", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCharacterDetail"{
            let destinationVC = segue.destination as! CharacterDetailViewController
            destinationVC.characterID = self.characterId
        }
       
    }
}

