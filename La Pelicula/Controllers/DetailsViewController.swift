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
    
    @IBAction func posterButton(_ sender: Any) {
        self.performSegue(withIdentifier: "posterSegue", sender: movie)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            let data = await Movie.detailsMoviesAPI(Int(movie?.id ?? 0))

            timeLabel.text = "\(String(data.runtime/60))h \(String(data.runtime%60))min"
            
            let genreStr = data.genres.map {genre in
                return genre.name
            }
            var aux = ""
            for i in 0...genreStr.count - 1 {
                if i == genreStr.count - 1 {
                    aux += genreStr[i]
                } else {
                    aux += genreStr[i] + ", \n"
                }
            }
            genrerLabel.text = aux
        }
        
        overrideUserInterfaceStyle = .dark
        // Do any additional setup after loading the view.

        
        guard let movie = movie else {
            return
        }
        self.title = String(movie.title)
        
        Task {
            let imageData = await Movie.downloadImageData(withPath: movie.backdropPath ?? "")
            let imagem = UIImage(data: imageData) ?? UIImage()
            backdropImage.image = imagem
        }
        
        Task {
            let imageData = await Movie.downloadImageData(withPath: movie.posterPath ?? "")
            let imagem = UIImage(data: imageData) ?? UIImage()
            posterImage.image = imagem
            posterImage.layer.cornerRadius = 8
        }
        
        titleLabel.text = movie.title
        ratingLabel.text = "Rating: \(round(movie.voteAverage*10)/10)/10"
        overviewLabel.text = movie.overview
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Passar o filme adiante
        if let destination = segue.destination as? PosterViewController{
            destination.imagePoster = movie?.posterPath ?? ""
        }
    }
    
}
