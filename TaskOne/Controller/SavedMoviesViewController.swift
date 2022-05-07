//
//  SavedMoviesViewController.swift
//  TaskOne
//
//  Created by Sai Balaji on 05/05/22.
//

import Foundation
import UIKit

class SavedMoviesViewController: UIViewController{
    
    //MARK: - PROPERTIES
    private var MoviesTableView: UITableView = {
        var tableview = UITableView(frame: .zero, style: .plain)
        tableview.register(MovieCell.self, forCellReuseIdentifier: MovieCell.CELL_ID)
        return tableview
    }()
   
    private var SavedMovieArray = [Movie]()
    
    override func viewWillAppear(_ animated: Bool) {
        fetchMovies()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    
    }
    
    //MARK: - HELPERS
    func configureUI(){
        navigationItem.title = "WatchList"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        view.addSubview(MoviesTableView)
        MoviesTableView.delegate = self
        MoviesTableView.dataSource = self
        MoviesTableView.translatesAutoresizingMaskIntoConstraints = false
        MoviesTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        MoviesTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        MoviesTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        MoviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
}


extension SavedMoviesViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SavedMovieArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.CELL_ID) as? MovieCell{
            cell.updateCellWithSavedMovieData(MovieName: SavedMovieArray[indexPath.row].movieName, MoviePosterBinaryData: SavedMovieArray[indexPath.row].imageData,MovieRating: SavedMovieArray[indexPath.row].movieRating)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    //swiple action for tableview cells
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let ShareAction = UITableViewRowAction(style: .normal, title: "Share") { action, indexpath in
            print("Share")
            self.ShowShareSheet(MovieName: self.SavedMovieArray[indexpath.row].movieName, MovieDescription: self.SavedMovieArray[indexpath.row].movieDescription,MovieTrailerURL: self.SavedMovieArray[indexpath.row].youtubeURL)
        }
        let DeleteAction = UITableViewRowAction(style: .destructive, title: "Remove") { action, indexpath in
            print("DELETE")
        }
        ShareAction.backgroundColor = .green
        return [ShareAction,DeleteAction]
    }
    

    
    
}

extension SavedMoviesViewController{
    //Fetch data from CoreData
    func fetchMovies(){
        DatabaseService.sharedObj.readData { movies, error in
            if let error = error {
                self.showAltert(Message: error.localizedDescription)
            }
            if let movies = movies {
                self.SavedMovieArray = movies
                DispatchQueue.main.async {
                    self.MoviesTableView.reloadData()
                }
            }
        }
    }
    
    
    func showAltert(Message: String){
        let avc = UIAlertController(title: "Info", message: Message, preferredStyle: .alert)
        avc.addAction(UIAlertAction(title: "Ok", style: .default))
        present(avc, animated: true)
    }
    
    //Display share sheet to share movie info
    func ShowShareSheet(MovieName: String?,MovieDescription: String?,MovieTrailerURL: String?){
        if let MovieName = MovieName , let MovieDescription = MovieDescription , let MovieTrailerURL = MovieTrailerURL{
            let ActivityViewController = UIActivityViewController(activityItems: [MovieName,MovieDescription,MovieTrailerURL], applicationActivities: nil)
            present(ActivityViewController, animated: true)
        }
        
    }
    
    
}
