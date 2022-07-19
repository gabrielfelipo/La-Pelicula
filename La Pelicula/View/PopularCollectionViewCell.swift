//
//  PopularCollectionViewCell.swift
//  La Pelicula
//
//  Created by gabrielfelipo on 11/07/22.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "popularCell"
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var Title: UILabel!
    
    func setup(title:String, image: UIImage){
        Title.text = title
        self.image.image = image
        self.image.layer.cornerRadius = 8
    }
    
}
