//
//  FeaturedViewController+UICollectionViewDataSource.swift
//  La Pelicula
//
//  Created by gabrielfelipo on 12/07/22.
//

import UIKit

extension FeaturedViewController: UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == popularCollectionView {
            return popularMovies.count
        }
        else if collectionView == nowPlayingCollectionView {
            return nowPlayingMovies.count
        }
        else if collectionView == upcomingCollectionView{
            return upcomingMovies.count
        }
        else {
            return 0
        }
    }
    
    fileprivate func makePopularCell(_ indexPath: IndexPath) -> PopularCollectionViewCell {
        if let cell = popularCollectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.cellIdentifier, for: indexPath) as? PopularCollectionViewCell {
            
            let movie = popularMovies[indexPath.item]
            
            cell.Title.text = movie.title
            cell.image.image = UIImage(named: movie.backdrop)
            
            return cell
        }
        return PopularCollectionViewCell()
    }
    
    fileprivate func makePlayingCell(_ indexPath: IndexPath) -> NowPlayingCollectionViewCell {
        if let cell = nowPlayingCollectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCollectionViewCell.cellIdentifier, for: indexPath) as? NowPlayingCollectionViewCell {
            
            let movie = nowPlayingMovies[indexPath.item]
            
            cell.Title.text = movie.title
            cell.Image.image = UIImage(named: movie.poster)
            cell.Date.text = String(movie.releaseDate.prefix(4))
            return cell
        }
        return NowPlayingCollectionViewCell()
    }
    
    
    fileprivate func makeUpcomingCell(_ indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = upcomingCollectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCollectionViewCell.cellIdentifier, for: indexPath) as? UpcomingCollectionViewCell {
            
            let movie = upcomingMovies[indexPath.item]
            
            cell.titleLabel.text = movie.title
            cell.imageView.image = UIImage(named: movie.poster)
            
            let meses = ["Jan","Fev","Mar","Abr","Mai","Jun","Jul","Ago","Set","Out","Nov","Dez"]
            var date = String(movie.releaseDate.prefix(7))
            let dateInt = Int(date.suffix(2))
            let day = Int(movie.releaseDate.suffix(2))
            let dateLetra = day?.codingKey.stringValue
            date = meses[dateInt ?? 0] + " " + (dateLetra ?? "")
            
            cell.dateLabel.text = date
            
            return cell
        }
        return PopularCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == popularCollectionView {
            return makePopularCell(indexPath)
        }
        else if collectionView == nowPlayingCollectionView {
            return makePlayingCell(indexPath)
        }
        else if collectionView == upcomingCollectionView {
            return makeUpcomingCell(indexPath)
        }
        return UICollectionViewCell()
    }
}
