//
//  LikeViewModel.swift
//  MVVM
//
//  Created by suganthi on 29/05/22.
//

import Foundation
import UIKit
class LikeViewModel {
    
    let apiService: APIServiceProtocol
    
    private var likes: [NewsLike] = [NewsLike]()
    private var comments: [NewsComment] = [NewsComment]()
    private var like: String = Strings.emptystring
    private var comment: String = Strings.emptystring
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var updateLoadingStatus: (()->())?
    
    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func LikeFetch(urlstring: String, commenturl: String) {
        self.isLoading = true
            let dispatchGroup = DispatchGroup()
 
            dispatchGroup.enter()
            
        apiService.fetchLikes(urlstring) { [weak self] (success, result, error) in
           
            if let error = error {
            } else {
                
                print(result);
                self!.like = String(result)
                self?.processFetchedLikes()
                dispatchGroup.leave()
            }
        }
            
            dispatchGroup.enter()
            
        apiService.fetchComments(commenturl) { [weak self] (success, result, error) in
            
            if let error = error {
            } else {
                
                print(result);
                
                self!.comment = String(result)
                self?.processFetchedComments()
                dispatchGroup.leave()
            }
        }
            /// `Notify Main thread`
            dispatchGroup.notify(queue: .main) {
                self.isLoading = false
            }
        
    }
    
   
    
    func processFetchedLikes() -> String {
        
        return self.like
    }
    
    func processFetchedComments() -> String {
        
        return self.comment
    }
}

