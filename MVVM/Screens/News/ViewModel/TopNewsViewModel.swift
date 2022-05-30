//
//  TopNewsViewModel.swift
//  MVVM
//
//  Created by suganthi on 28/05/22.
//

import Foundation
import UIKit
class TopNewsListViewModel {
    
    let apiService: APIServiceProtocol
    
    private var topStories: [TopNews] = [TopNews]()
    
    private var cellViewModels: [NewsListCellViewModel] = [NewsListCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    
    var selectedTopStory: DetailViewModel?
    
    var reloadTableViewClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func initFetch() {
        self.isLoading = true
        apiService.fetchTopStories { [weak self] (success, results, error) in
            self?.isLoading = false
            if let error = error {
            } else {
                
                print(results);
                
                self?.processFetchedTopStories(topStories: results)
            }
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> NewsListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel( topStory: TopNews ) -> NewsListCellViewModel {
        
        return NewsListCellViewModel(titleText: topStory.title ?? "", authorText: topStory.author ?? "", imageUrl: topStory.urlToImage ?? "")
    }
    
    private func processFetchedTopStories( topStories: [TopNews] ) {
        self.topStories = topStories // Cache
        var vms = [NewsListCellViewModel]()
        for topStory in topStories {
            vms.append( createCellViewModel(topStory: topStory) )
        }
        self.cellViewModels = vms
    }
    
}

extension TopNewsListViewModel {
    func userPressed( at indexPath: IndexPath ){
        let topStory = self.topStories[indexPath.row]
       
        self.selectedTopStory = DetailViewModel(url: topStory.url!)


    }
}

struct NewsListCellViewModel {
    let titleText: String
    let authorText: String
    let imageUrl: String
}

struct DetailViewModel {
    let url: String
}
