//
//  NetworkService.swift
//  TaskOne
//
//  Created by Sai Balaji on 05/05/22.
//

import Foundation

class NetworkService{
    //MARK: - PROPERTIES
    static var SharedObject = NetworkService()
    private var session = URLSession(configuration: .default)
    
    //MARK: - GETMOVIE INFO FROM TMDB
    func getMovies(name MovieName: String,onCompletion:@escaping([MovieData]?,Error?)->Void){
        
        guard let FormatedMovieName = MovieName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)  else{return}
        
        if let SEARCH_URL = URL(string:Constants.BASE_URL + FormatedMovieName){
            
            let task = session.dataTask(with: SEARCH_URL) { data, response, error in
                
                if let error = error {
                    print(error.localizedDescription)
                    onCompletion(nil,error)
                }
                
                if let data = data {
                    do{
                        let DecodedData = try JSONDecoder().decode(Movies.self, from: data)
                        onCompletion(DecodedData.results,nil)
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                
                }
                
            }
            
            task.resume()
        }
    }
    
    //MARK: - GET MOVIE TRAILER URL FROM YOUTUBE
    func getMovieInfoFromYoutube(Query: String,onCompletion:@escaping([Item]?,Error?)->Void){
        guard let FormattedQuery = Query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return }
        if let YOUTUBE_URL =
            URL(string:"\(Constants.YOUTUBE_BASE_URL)\(FormattedQuery)&key=\(Constants.YOUTUBE_API_KEY)"){
            
            let task = session.dataTask(with: YOUTUBE_URL) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    onCompletion(nil,error)
                }
                if let data = data {
                    do{
                        let DecodedData = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                        onCompletion(DecodedData.items,nil)
                    }
                    catch{
                        print("ERROR\(error)")
                    }
                }
            }
            task.resume()
        }

    }
}
