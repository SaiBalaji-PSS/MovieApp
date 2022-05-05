//
//  MovieCell.swift
//  TaskOne
//
//  Created by Sai Balaji on 05/05/22.
//

import Foundation
import UIKit

class MovieCell: UITableViewCell{
    //MARK: - PROPERTIES
    
    static let CELL_ID = "MOVIE_CELL"
    
    private var MoviePosterImageView: UIImageView = {
        let ImageView = UIImageView()
        ImageView.backgroundColor = .purple
        return ImageView
    }()
    
    private var MovieTitleLabel: UILabel = {
        let TitleLabel = UILabel(frame: .zero)
        TitleLabel.text = "MOVIE_NAME_HERE"
        TitleLabel.numberOfLines = 0
        return TitleLabel
    }()
    
    //MARK: - INITIALIZERS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: MovieCell.CELL_ID)
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - HELPERS
    func configureUI(){
        addSubview(MoviePosterImageView)
        MoviePosterImageView.translatesAutoresizingMaskIntoConstraints = false
        MoviePosterImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        MoviePosterImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        MoviePosterImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        MoviePosterImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        MoviePosterImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        addSubview(MovieTitleLabel)
        MovieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        MovieTitleLabel.topAnchor.constraint(equalTo: topAnchor,constant: 100).isActive = true
        MovieTitleLabel.leftAnchor.constraint(equalTo: MoviePosterImageView.rightAnchor,constant: 10).isActive = true
        MovieTitleLabel.widthAnchor.constraint(equalToConstant: frame.size.width/1.2).isActive = true
    }
    
    
}
