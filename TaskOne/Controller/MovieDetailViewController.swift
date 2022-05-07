//
//  MovieDetailViewController.swift
//  TaskOne
//
//  Created by Sai Balaji on 05/05/22.
//

import CoreData
import Foundation
import SDWebImage
import UIKit
import WebKit

let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

class MovieDetailViewController: UIViewController{
    

    var MovieName: String?
    var MovieDescription: String?
    var MoviePosterURL: String?
    var MovieRating: Double?
    var MovieReleaseDate: String?
    private var TrailerPreviewView: WKWebView = WKWebView()
    private var PosterImageView: UIImageView = {
        var ImageView = UIImageView()
       
        ImageView.contentMode = .scaleAspectFit
        return ImageView
    }()
    private var MovieTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "MOVIE_NAME_HERE"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    private var MovieRatingLabel: UILabel = {
        let label = UILabel()
        label.text = "MOVIE_RATING_HERE"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor.darkGray
        return label
    }()
    private var MovieDescriptionTextBox: UITextView = {
        let textview = UITextView(frame: .zero)
        textview.allowsEditingTextAttributes = false
        
        textview.isEditable = false
        textview.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return textview
    }()
    private var MovieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "MOVIE_DESCRIPTION_HERE"
        label.textAlignment = .justified
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }()
    private var MovieReleaseDateLabel: UILabel = {
       let label = UILabel()
        label.text = "RELEASE_DATE_HERE"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        return label
    }()
    private var AddToWatchListButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.systemPink
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.setTitle("Add To WatchList", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getMovieTrailer()
    }
    
    
    func configureUI(){
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        navigationItem.title = "Movie Details"
        view.addSubview(TrailerPreviewView)
        TrailerPreviewView.translatesAutoresizingMaskIntoConstraints = false
        TrailerPreviewView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        TrailerPreviewView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        TrailerPreviewView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        view.addSubview(PosterImageView)
        PosterImageView.translatesAutoresizingMaskIntoConstraints = false
        PosterImageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        PosterImageView.topAnchor.constraint(equalTo: TrailerPreviewView.bottomAnchor,constant: 10).isActive = true
        PosterImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        PosterImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        view.addSubview(MovieTitleLabel)
        MovieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        MovieTitleLabel.topAnchor.constraint(equalTo: TrailerPreviewView.bottomAnchor,constant: 50).isActive = true
        MovieTitleLabel.leftAnchor.constraint(equalTo: PosterImageView.rightAnchor,constant: 5).isActive = true
        MovieTitleLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.8).isActive = true
        
        view.addSubview(MovieRatingLabel)
        MovieRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        MovieRatingLabel.leftAnchor.constraint(equalTo: PosterImageView.rightAnchor,constant: 5).isActive = true
        MovieRatingLabel.topAnchor.constraint(equalTo: MovieTitleLabel.bottomAnchor,constant: 10).isActive = true
        
        view.addSubview(MovieDescriptionTextBox)
        MovieDescriptionTextBox.translatesAutoresizingMaskIntoConstraints = false
        MovieDescriptionTextBox.heightAnchor.constraint(equalToConstant: view.frame.size.height/5).isActive = true
        MovieDescriptionTextBox.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        MovieDescriptionTextBox.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        MovieDescriptionTextBox.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        view.addSubview(MovieReleaseDateLabel)
        MovieReleaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        MovieReleaseDateLabel.topAnchor.constraint(equalTo: MovieRatingLabel.bottomAnchor,constant: 2).isActive = true
        MovieReleaseDateLabel.leftAnchor.constraint(equalTo: PosterImageView.rightAnchor,constant: 5).isActive = true
        
        AddToWatchListButton.addTarget(self, action: #selector(watchListButtonPressed), for: .touchUpInside)
        view.addSubview(AddToWatchListButton)
        AddToWatchListButton.translatesAutoresizingMaskIntoConstraints = false
        AddToWatchListButton.topAnchor.constraint(equalTo: MovieReleaseDateLabel.bottomAnchor,constant: 10).isActive = true
        AddToWatchListButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        AddToWatchListButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        AddToWatchListButton.leftAnchor.constraint(equalTo: PosterImageView.rightAnchor).isActive = true
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
        if let MoviePosterURL = MoviePosterURL , let MovieName = MovieName , let MovieRating = MovieRating , let MovieDescription = MovieDescription , let MovieReleaseDate = MovieReleaseDate {
            self.MovieTitleLabel.text = MovieName
            self.MovieRatingLabel.text = "★\(MovieRating)"
            self.MovieDescriptionTextBox.text = MovieDescription
            self.MovieReleaseDateLabel.text = MovieReleaseDate
            PosterImageView.sd_setImage(with:URL(string:Constants.POSTER_IMAGE_URL+(MoviePosterURL)))
        }
        
    }
    
    
    @objc func watchListButtonPressed(){
        if let MovieName = MovieName , let MovieDescription = MovieDescription , let MovieRating = MovieRating , let JPEGData = PosterImageView.image?.jpegData(compressionQuality: 1.0) {
            let WatchListedMovie = Movie(context: context)
            WatchListedMovie.movieName = MovieName
            WatchListedMovie.movieDescription = MovieDescription
            WatchListedMovie.movieRating = MovieRating
            WatchListedMovie.imageData = JPEGData
            
            do{
                try context.save()
            }
            catch{
                print(error)
            }
            
        }
        
        
    }
}
