//
//  DetailsViewController.swift
//  La Pelicula
//
//  Created by gabrielfelipo on 13/07/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var movie: Movie?
    
    var detailMovie: [Movie] = []
    
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var genrerLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            self.detailMovie = await Movie.detailsMoviesAPI(Int(movie?.id ?? 0))
            print(movie?.id)
        }
        //print(movie?.genres)
        
        overrideUserInterfaceStyle = .dark
        // Do any additional setup after loading the view.

        
        guard let movie = movie else {
            return
        }
        self.title = movie.title
        
        Task {
            let imageData = await Movie.downloadImageData(withPath: movie.backdropPath)
            let imagem = UIImage(data: imageData) ?? UIImage()
            backdropImage.image = imagem
        }
        
        Task {
            let imageData = await Movie.downloadImageData(withPath: movie.posterPath)
            let imagem = UIImage(data: imageData) ?? UIImage()
            posterImage.image = imagem
            posterImage.layer.cornerRadius = 8
        }
        
        //backdropImage.image = UIImage(named: movie.backdropPath)
        titleLabel.text = movie.title
        //posterImage.image = UIImage(named: movie.posterPath)
        ratingLabel.text = "Rating: \(movie.voteAverage)/10"
        overviewLabel.text = movie.overview
        print(movie.title)
        print(movie.releaseDate)
        print(movie.genres)
        
        for genrer in movie.genres ?? [] {
        }
        
    }
    
}
