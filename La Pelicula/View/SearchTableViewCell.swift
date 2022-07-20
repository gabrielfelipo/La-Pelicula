//
//  SearchTableViewCell.swift
//  La Pelicula
//
//  Created by gabrielfelipo on 19/07/22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imagemV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    func setup (title: String, image: UIImage, year: String) {
        
        titleLabel.text = title
        imagemV.image = image
        yearLabel.text = year
        self.imagemV.layer.cornerRadius = 8
        
    }

}
