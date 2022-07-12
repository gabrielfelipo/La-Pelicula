//
//  FeaturedViewController+UICollectionViewDataSource.swift
//  La Pelicula
//
//  Created by gabrielfelipo on 12/07/22.
//

import UIKit

extension FeaturedViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == popularCollectionView {
            return popularMovies.count
        }
        else if collectionView == nowPlayingCollectionView {
            return nowPlayingMovies.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == popularCollectionView {
            if let cell = popularCollectionView.dequeueReusableCell(withReuseIdentifier: "popularCell", for: indexPath) as? PopularCollectionViewCell {
                
                let movie = popularMovies[indexPath.item]
                
                cell.Title.text = movie.title
                cell.image.image = UIImage(named: movie.backdrop)
            
                return cell
            }
        }
        else if collectionView == nowPlayingCollectionView {
            if let cell = nowPlayingCollectionView.dequeueReusableCell(withReuseIdentifier: "nowPlayingCell", for: indexPath) as? NowPlayingCollectionViewCell {
                
                let movie = nowPlayingMovies[indexPath.item]
                
                cell.Title.text = movie.title
                cell.Image.image = UIImage(named: movie.poster)
                cell.Date.text = movie.releaseDate
            
                return cell
            }
        }
        return UICollectionViewCell()
    }
}
