//
//  CharacterTableViewCell.swift
//  RickAndMortyApp
//
//  Created by Emre Can Şimşek on 24.04.2023.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var characterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        characterImage.layer.cornerRadius = 10;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

    }

}
