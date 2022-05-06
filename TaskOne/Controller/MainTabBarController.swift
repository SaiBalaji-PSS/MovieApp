//
//  ViewController.swift
//  TaskOne
//
//  Created by Sai Balaji on 05/05/22.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        configureUI()
    }

    //MARK: - HELPERS
    func configureUI(){
        let SearchViewController = createViewControllersForTabBar(ImageName: "magnifyingglass", RootViewController: SearchViewController(),TabBarTitle: "Search")
        
        let SavedMovieController = createViewControllersForTabBar(ImageName: "square.and.arrow.down", RootViewController: SavedMoviesViewController(),TabBarTitle: "Downloads")

        viewControllers = [SearchViewController,SavedMovieController]
    }
    
    func createViewControllersForTabBar(ImageName: String,RootViewController: UIViewController,TabBarTitle: String) -> UINavigationController{
        let ViewController = UINavigationController(rootViewController: RootViewController)
        ViewController.tabBarItem.image = UIImage(systemName: ImageName)
        ViewController.tabBarItem.title = TabBarTitle
        return ViewController
    }

}

