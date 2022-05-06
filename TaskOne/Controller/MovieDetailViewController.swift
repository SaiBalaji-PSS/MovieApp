//
//  MovieDetailViewController.swift
//  TaskOne
//
//  Created by Sai Balaji on 05/05/22.
//

import Foundation
import SDWebImage
import UIKit
import WebKit

class MovieDetailViewController: UIViewController{
    

    var MovieName: String?
    var MovieDescription: String?
    var MoviePosterURL: String?
    var MovieRating: Double?
    
    private var TrailerPreviewView: WKWebView = WKWebView()
    private var PosterImageView: UIImageView = {
        var ImageView = UIImageView()
       
        ImageView.contentMode = .scaleAspectFit
        return ImageView
    }()
    private var MovieTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "MOVIE_NAME_HERE"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    private var MovieRatingLabel: UILabel = {
        let label = UILabel()
        label.text = "MOVIE_RATING_HERE"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.darkGray
        return label
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getMovieTrailer()
    }
    
    
    func configureUI(){
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        
        view.addSubview(TrailerPreviewView)
        TrailerPreviewView.translatesAutoresizingMaskIntoConstraints = false
        TrailerPreviewView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        TrailerPreviewView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        TrailerPreviewView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        view.addSubview(PosterImageView)
        PosterImageView.translatesAutoresizingMaskIntoConstraints = false
        PosterImageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        PosterImageView.topAnchor.constraint(equalTo: TrailerPreviewView.bottomAnchor,constant: 10).isActive = true
        PosterImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        PosterImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        view.addSubview(MovieTitleLabel)
        MovieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        MovieTitleLabel.topAnchor.constraint(equalTo: TrailerPreviewView.bottomAnchor,constant: 50).isActive = true
        MovieTitleLabel.leftAnchor.constraint(equalTo: PosterImageView.rightAnchor,constant: 5).isActive = true
        MovieTitleLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        
        
        
    }
    
    func getMovieTrailer(){
        if let MovieName = MovieName {
           print("INSIDE")
            NetworkService.SharedObject.getMovieInfoFromYoutube(Query: MovieName) { [self] VideoData, error in
                DispatchQueue.main.async {
                    if let error = error {
                        print(error)
                    }
                    if let VideoID = VideoData?.first?.id.videoID{
                        self.TrailerPreviewView.load(URLRequest(url: URL(string:"\(Constants.YOUTUBE_EMBED_URL)\(VideoID)")!))
                    }
                }
              
               
            }
        }
        if let MoviePosterURL = MoviePosterURL , let MovieName = MovieName {
            self.MovieTitleLabel.text = MovieName
            PosterImageView.sd_setImage(with:URL(string:"https://image.tmdb.org/t/p/w500/\(MoviePosterURL)"))
        }
    }
}
