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
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.CELL_ID) as? MovieCell{
            cell.MoviePosterImageView.backgroundColor = .purple
            cell.MovieTitleLabel.text = "HELLO"
            cell.MovieRatingLabel.text = "0"
            return cell
        }
        return UITableViewCell()
    }
}
