//
//  UpcomingCollectionViewCell.swift
//  La Pelicula
//
//  Created by gabrielfelipo on 13/07/22.
//

import UIKit

class UpcomingCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "upcomingCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func setup(title:String, year:String ,image: UIImage) {
        imageView.image = image
        titleLabel.text = title
        dateLabel.text = year
        self.imageView.layer.cornerRadius = 8
    }
}
