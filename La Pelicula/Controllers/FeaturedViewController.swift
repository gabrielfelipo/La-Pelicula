//
//  ViewController.swift
//  La Pelicula
//
//  Created by gabrielfelipo on 05/07/22.
//

import UIKit

class FeaturedViewController: UIViewController{

    let popularMovies = Movie.popularMovies()
    let nowPlayingMovies = Movie.nowPlayingMovies()
    
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        popularCollectionView.dataSource = self
        nowPlayingCollectionView.dataSource = self
    }
}

