//
//  DatabaseService.swift
//  TaskOne
//
//  Created by Sai Balaji on 07/05/22.
//

import CoreData
import Foundation
import UIKit

class DatabaseService{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var sharedObj = DatabaseService()
    
    func saveData(MovieName: String,MovieDescription: String,MovieRating: Double,JPEGData: Data,YouTubeURL: String){
        let WatchListedMovie = Movie(context: context)
        WatchListedMovie.movieName = MovieName
        WatchListedMovie.movieDescription = MovieDescription
        WatchListedMovie.movieRating = MovieRating
        WatchListedMovie.imageData = JPEGData
        WatchListedMovie.youtubeURL = YouTubeURL
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
    
    func deleteData(MovieToBeDeleted: Movie,onCompletion:@escaping(Error?)->Void){
        context.delete(MovieToBeDeleted)
        do{
            try context.save()
            onCompletion(nil)
        }
        catch{
            print(error)
            onCompletion(error)
        }
    }
}
