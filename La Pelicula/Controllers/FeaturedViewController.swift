//
//  ViewController.swift
//  La Pelicula
//
//  Created by gabrielfelipo on 05/07/22.
//

import UIKit

class FeaturedViewController: UIViewController{

    var popularMovies: [Movie] = []
    var nowPlayingMovies: [Movie] = []//Movie.nowPlayingMovies()
    var upcomingMovies:[Movie] = []//Movie.upcomingMovies()
    
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    @IBOutlet weak var background: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        popularCollectionView.dataSource = self
        nowPlayingCollectionView.dataSource = self
        upcomingCollectionView.dataSource = self
        
        popularCollectionView.delegate = self
        nowPlayingCollectionView.delegate = self
        upcomingCollectionView.delegate = self
        
        Task {
            self.popularMovies = await Movie.popularMoviesAPI()
            self.popularCollectionView.reloadData()
        }
        
        Task {
            self.nowPlayingMovies = await Movie.nowPlayingMoviesAPI()
            self.nowPlayingCollectionView.reloadData()
        }
        
        Task {
            self.upcomingMovies = await Movie.upcomingMoviesAPI()
            self.upcomingCollectionView.reloadData()
        }
        
        overrideUserInterfaceStyle = .dark
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Passar o filme adiante
        if let destination = segue.destination as? DetailsViewController{
            let movie = sender as? Movie
            destination.movie = movie
        }
    }
}

