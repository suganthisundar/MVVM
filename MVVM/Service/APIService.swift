//
//  APIService.swift
//  MVVM
//
//  Created by suganthi on 28/05/22.
//

import Foundation

protocol APIServiceProtocol {
    func fetchTopStories( complete: @escaping ( _ success: Bool, _ topStories: [TopNews], _ error: Error? )->() )
    func fetchLikes(_ urlstring: String, complete: @escaping ( _ success: Bool, _ likes: Int, _ error: Error? )->() )
    func fetchComments(_ urlstring: String, complete: @escaping ( _ success: Bool, _ comments: Int, _ error: Error? )->() )
    
}


private let sessionManager: URLSession = {
    let urlSessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default
    return URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: nil)
}()

class APIService: APIServiceProtocol {
   
    // Simulate a long waiting for fetching
    func fetchTopStories( complete: @escaping ( _ success: Bool, _ results: [TopNews], _ error: Error? )->() ) {
        let url = URL(string: Strings.TopStories)!
        let request = URLRequest(url: url)
        
        sessionManager.dataTask(with: request) { (data, response, error) in
            
            //Handle error case
            guard error == nil else {
                complete( false,[], error )

                return
            }
            
            
            
            let response = try? JSONDecoder().decode(TopNewsResult.self, from: data!)
            
            
            if(response?.status == "ok") {
                
                
                
                complete( true, (response?.articles)!, nil )
            }
            else{
                //Manage the else case
            }
          
          
            }.resume()

    }
    
    
    func fetchLikes(_ urlstring: String, complete: @escaping ( _ success: Bool, _ results: Int, _ error: Error? )->() ) {
        let url = URL(string: urlstring)!
        let request = URLRequest(url: url)
        
        sessionManager.dataTask(with: request) { (data, response, error) in
            
            //Handle error case
            guard error == nil else {
                complete( false, 0 , error )

                return
            }
            
            
            
            let response = try? JSONDecoder().decode(NewsLike.self, from: data!)
            
                
            complete( true, (response?.likes)!, nil )
           
          
          
            }.resume()

    }
    
    func fetchComments(_ urlstring: String, complete: @escaping ( _ success: Bool, _ results: Int, _ error: Error? )->() ) {
        let url = URL(string: urlstring)!
        let request = URLRequest(url: url)
        
        sessionManager.dataTask(with: request) { (data, response, error) in
            
            //Handle error case
            guard error == nil else {
                complete( false, 0 , error )

                return
            }
            
            
            
            let response = try? JSONDecoder().decode(NewsComment.self, from: data!)
            
                
            complete( true, (response?.comments)!, nil )
           
          
          
            }.resume()

    }
    
}
