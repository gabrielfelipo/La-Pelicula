//
//  TrendingViewController.swift
//  La Pelicula
//
//  Created by gabrielfelipo on 20/07/22.
//

import UIKit

class TrendingViewController: UIViewController {
    
    var trendingMovies: [Movie] = []
    var trendingDayMovies: [Movie] = []
    var trendingWeekMovies: [Movie] = []

    @IBOutlet weak var trendingSegmentedControl: UISegmentedControl!
    @IBOutlet weak var trendingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trendingTableView.delegate = self
        trendingTableView.dataSource = self
        
        Task {
            self.trendingDayMovies = await Movie.trendingDayMoviesAPI()
            self.trendingWeekMovies = await Movie.trendingWeekMoviesAPI()
            self.trendingMovies = trendingDayMovies
            trendingTableView.reloadData()
            }
        }
    
    @IBAction func touchTrendingSegmentedControl(_ sender: Any) {
        if trendingSegmentedControl.selectedSegmentIndex == 0 {
            trendingMovies = trendingDayMovies
            trendingTableView.reloadData()
        } else {
            trendingMovies = trendingWeekMovies
            trendingTableView.reloadData()
        }
    }
    
}

extension TrendingViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trendingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == trendingTableView{
            let cell = trendingTableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.cellIdentifier, for: indexPath) as! TrendingTableViewCell
            
            let moviePath = trendingMovies[indexPath.item]
            
            cell.setup(title: moviePath.title, image: UIImage(), year: String(moviePath.releaseDate!.prefix(4)))
            
            Task {
                let imageData = await Movie.downloadImageData(withPath: moviePath.posterPath ?? "")
                let poster = UIImage(data: imageData) ?? UIImage()
                
                cell.setup(title: moviePath.title, image: poster, year: String(moviePath.releaseDate!.prefix(4)))
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie: Movie
        movie = trendingMovies[indexPath.item]
        self.performSegue(withIdentifier: "trendingToDetailsSegue", sender: movie)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            //passar o filme adiante para a proxima tela
            if let detailsViewController = segue.destination as? DetailsViewController{
                let movie = sender as? Movie
                detailsViewController.movie = movie
            }
        }
    
    
}
