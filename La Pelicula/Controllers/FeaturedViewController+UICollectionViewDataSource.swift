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
    
    fileprivate func makePopularCell(_ indexPath: IndexPath) -> PopularCollectionViewCell {
        if let cell = popularCollectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.cellIdentifier, for: indexPath) as? PopularCollectionViewCell {
            
            let movie = popularMovies[indexPath.item]
            
            Task {
                let imageData = await Movie.downloadImageData(withPath: movie.backdropPath ?? "")
                let imagem = UIImage(data: imageData) ?? UIImage()
                cell.setup(title: movie.title, image: imagem)
            }
            
            return cell
        }
        return PopularCollectionViewCell()
    }
    
    fileprivate func makePlayingCell(_ indexPath: IndexPath) -> NowPlayingCollectionViewCell {
        if let cell = nowPlayingCollectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCollectionViewCell.cellIdentifier, for: indexPath) as? NowPlayingCollectionViewCell {
            
            let movie = nowPlayingMovies[indexPath.item]
            
            Task {
                let imageData = await Movie.downloadImageData(withPath: movie.posterPath ?? "")
                let imagem = UIImage(data: imageData) ?? UIImage()
                cell.setup(title: movie.title, year: String(movie.releaseDate?.prefix(4) ?? ""), image: imagem)
            }
            
            return cell
        }
        return NowPlayingCollectionViewCell()
    }
    
    
    fileprivate func makeUpcomingCell(_ indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = upcomingCollectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCollectionViewCell.cellIdentifier, for: indexPath) as? UpcomingCollectionViewCell {
            
            let movie = upcomingMovies[indexPath.item]
            
            let meses = ["Jan","Fev","Mar","Abr","Mai","Jun","Jul","Ago","Set","Out","Nov","Dez"]
            var date = String(movie.releaseDate!.prefix(7))
            let dateInt = Int(date.suffix(2))
            let day = Int(movie.releaseDate!.suffix(2))
            let dateLetra = day?.codingKey.stringValue
            date = meses[dateInt ?? 0] + " " + (dateLetra ?? "")
            
            Task {
                let imageData = await Movie.downloadImageData(withPath: movie.backdropPath ?? "")
                let imagem = UIImage(data: imageData) ?? UIImage()
                cell.setup(title: movie.title, year: date, image: imagem)
            }
            
            return cell
        }
        return UpcomingCollectionViewCell()
    }
    
}
