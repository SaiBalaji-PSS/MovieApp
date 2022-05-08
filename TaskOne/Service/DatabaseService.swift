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
    //MARK: - PROPERTIES
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var sharedObj = DatabaseService()
    
    //MARK: - SAVE TO COREDATA
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
    
    //MARK: - READ FROM COREDATA
    func readData(onCompletion:@escaping([Movie]?,Error?)->Void){
        do{
            let movies =  try context.fetch(Movie.fetchRequest())
            onCompletion(movies,nil)
        }
        catch{
            onCompletion(nil,error)
        }
    }
    
    //MARK: - DELETE FROM CORE DATA
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
