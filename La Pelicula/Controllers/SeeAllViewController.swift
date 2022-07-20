//
//  SeeAllViewController.swift
//  La Pelicula
//
//  Created by gabrielfelipo on 19/07/22.
//

import UIKit

class SeeAllViewController: UIViewController {

    @IBOutlet weak var seeAllTableView: UITableView!
    var seeAllMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        
        seeAllTableView.dataSource = self
        seeAllTableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Passar o filme adiante
        guard let detailsViewControler = segue.destination as? DetailsViewController else {return}
        guard let movie = sender as? Movie else {return}
        detailsViewControler.movie = movie
        }
    

}

extension SeeAllViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return seeAllMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == seeAllTableView{
            let cell = seeAllTableView.dequeueReusableCell(withIdentifier: SeeAllTableViewCell.cellIdentifier, for: indexPath) as! SeeAllTableViewCell
            
            let moviePath = seeAllMovies[indexPath.item]
            
            cell.setup(title: moviePath.title, rating: String(moviePath.voteAverage), image: UIImage(), year: moviePath.releaseDate ?? "")
            
            Task {
                let imageData = await Movie.downloadImageData(withPath: moviePath.posterPath ?? "")
                let poster = UIImage(data: imageData) ?? UIImage()
                
                cell.setup(title: moviePath.title, rating: String(moviePath.voteAverage), image: poster, year: String((moviePath.releaseDate?.prefix(4))!))
            }
            return cell
        }
    return UITableViewCell()
    }
    
    //DELEGATE
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie: Movie
        
        if tableView == seeAllTableView {
            movie = seeAllMovies[indexPath.item]
        } else {
            return
        }
        
        performSegue(withIdentifier: "showDetails", sender: movie)
    }
    
    
    
    
    
    
}
