//
//  SeeAllTableViewCell.swift
//  La Pelicula
//
//  Created by gabrielfelipo on 19/07/22.
//

import UIKit

class SeeAllTableViewCell: UITableViewCell {

    static let cellIdentifier = "tableCell"
    
    @IBOutlet weak var imagePoste: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func setup (title: String, rating: String, image: UIImage, year: String) {
        
        titleLabel.text = title
        imagePoste.image = image
        yearLabel.text = year
        ratingLabel.text = rating
        self.imagePoste.layer.cornerRadius = 8
        
    }

}
