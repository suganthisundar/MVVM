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
    
    func LikeFetch(urlstring: String) {
        self.isLoading = true
        apiService.fetchLikes(urlstring) { [weak self] (success, result, error) in
            self?.isLoading = false
            if let error = error {
            } else {
                
                print(result);
                self!.like = String(result)
                self?.processFetchedLikes()
            }
        }
        
    }
    
    func CommentFetch(urlstring: String) {
        apiService.fetchComments(urlstring) { [weak self] (success, result, error) in
            self?.isLoading = false
            if let error = error {
            } else {
                
                print(result);
                
                self!.comment = String(result)
                self?.processFetchedLikes()
            }
        }
        
    }
   
    
    func processFetchedLikes() -> String {
        
        return self.like
    }
    
    func processFetchedComments() -> String {
        
        return self.comment
    }
}

