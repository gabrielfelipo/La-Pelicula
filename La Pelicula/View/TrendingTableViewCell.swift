//
//  TrendingTableViewCell.swift
//  La Pelicula
//
//  Created by gabrielfelipo on 20/07/22.
//

import UIKit

class TrendingTableViewCell: UITableViewCell {

    static let cellIdentifier = "trendingCell"
    
    @IBOutlet weak var imageTrending: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    func setup (title: String, image: UIImage, year: String) {
        
        titleLabel.text = title
        imageTrending.image = image
        yearLabel.text = year
        self.imageTrending.layer.cornerRadius = 8
        
    }
}
