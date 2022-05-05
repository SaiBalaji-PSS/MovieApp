//
//  MovieAPIResponse.swift
//  TaskOne
//
//  Created by Sai Balaji on 05/05/22.
//

import Foundation

struct Movies: Codable {
    let results: [MovieData]
}

struct MovieData: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}

