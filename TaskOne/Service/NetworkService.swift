//
//  NetworkService.swift
//  TaskOne
//
//  Created by Sai Balaji on 05/05/22.
//

import Foundation

class NetworkService{
    static var SharedObject = NetworkService()
    private var session = URLSession(configuration: .default)
    
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
    
}
