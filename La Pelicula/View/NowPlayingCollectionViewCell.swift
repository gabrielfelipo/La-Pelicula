//
//  NowPlayingCollectionViewCell.swift
//  La Pelicula
//
//  Created by gabrielfelipo on 11/07/22.
//

import UIKit

class NowPlayingCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "nowPlayingCell"
    
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var Title: UILabel!
    
    func setup(title:String, year:String ,image: UIImage){
        Title.text = title
        Date.text = year
        Image.image = image
        self.Image.layer.cornerRadius = 8
    }
}
