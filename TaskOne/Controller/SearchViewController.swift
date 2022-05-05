//
//  SearchViewController.swift
//  TaskOne
//
//  Created by Sai Balaji on 05/05/22.
//

import Foundation
import UIKit

class SearchViewController: UIViewController{
    
    //MARK: - PROPERTIES
    private var SearchBarController: UISearchController = {
       let searchbarcontroller = UISearchController()
        searchbarcontroller.searchBar.placeholder = "Enter a movie name"
        searchbarcontroller.searchBar.searchBarStyle = .minimal
        return searchbarcontroller
    }()
    
    private var MoviesTableView: UITableView = {
        let tableview = UITableView(frame: .zero, style: .plain)
        tableview.register(MovieCell.self, forCellReuseIdentifier:MovieCell.CELL_ID)
        return tableview
    }()
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(MoviesTableView)
        MoviesTableView.delegate = self
        MoviesTableView.dataSource = self
        configureUI()
        
    }
    
    //MARK: - HELPERS
    func configureUI(){
        view.backgroundColor = .systemBackground
        SearchBarController.searchResultsUpdater = self
        navigationItem.title = "Search"
        navigationItem.searchController = SearchBarController
        
        
        MoviesTableView.translatesAutoresizingMaskIntoConstraints = false
        MoviesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        MoviesTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        MoviesTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        MoviesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
}

//MARK: - EXTENSIONS
extension SearchViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        print("Search")
    }
}


extension SearchViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.CELL_ID, for: indexPath) as? MovieCell{
            return cell
        }

        return UITableViewCell()
    }
}
