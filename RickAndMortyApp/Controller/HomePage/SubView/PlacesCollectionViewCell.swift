//
//  PlacesCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Emre Can Şimşek on 24.04.2023.
//

import UIKit

class PlacesCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
    }
    
    @IBOutlet weak var placesLabel: UILabel!
    
}
