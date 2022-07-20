//
//  SearchViewController.swift
//  La Pelicula
//
//  Created by gabrielfelipo on 19/07/22.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate {
    
    var searchMovie: [Movie] = []
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let title = searchController.searchBar.text else {
            return
        }
        Task {
            self.searchMovie = await Movie.searchMoviesAPI(title)
            tableViewSearch.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableViewSearch{
            let cell = tableViewSearch.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath) as! SearchTableViewCell
            
            let moviePath = searchMovie[indexPath.item]
            
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
    

    
    @IBOutlet weak var tableViewSearch: UITableView!
    
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        // Do any additional setup after loading the view.
        
        tableViewSearch.dataSource = self
        tableViewSearch.delegate = self
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie: Movie
        
        if tableView == tableViewSearch {
            movie = searchMovie[indexPath.item]
            self.performSegue(withIdentifier: "searchDetailSegue", sender: movie)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchDetailSegue"{
            if let destination = segue.destination as? DetailsViewController{
                let movie = sender as? Movie
                destination.movie = movie
            }
        }else{return}
    }
}

