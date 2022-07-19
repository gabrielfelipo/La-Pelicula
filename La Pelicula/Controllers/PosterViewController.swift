//
//  PosterViewController.swift
//  La Pelicula
//
//  Created by gabrielfelipo on 19/07/22.
//

import UIKit

class PosterViewController: UIViewController {

    var imagePoster: String = ""
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark
        // Do any additional setup after loading the view.
        posterImageView.image = UIImage(named: imagePoster )
        Task {
            let imageData = await Movie.downloadImageData(withPath: imagePoster)
            let imagem = UIImage(data: imageData)
            posterImageView.image = imagem
        }
    }

}
