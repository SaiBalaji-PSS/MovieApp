//
//  DatabaseService.swift
//  TaskOne
//
//  Created by Sai Balaji on 07/05/22.
//

import CoreData
import Foundation

class DatabaseService{
    static var sharedObj = DatabaseService()
    
    func saveData(MovieName: String,MovieDescription: String,MovieRating: Double,JPEGData: Data){
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
    
    func readData(onCompletion:@escaping([Movie]?,Error?)->Void){
        do{
            let movies =  try context.fetch(Movie.fetchRequest())
            onCompletion(movies,nil)
        }
        catch{
            onCompletion(nil,error)
        }
    }
}
