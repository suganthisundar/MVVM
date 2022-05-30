//
//  ViewController.swift
//  MVVM
//
//  Created by suganthi on 28/05/22.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    lazy var viewModel: TopNewsListViewModel = {
           return TopNewsListViewModel()
       }()
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           // Init the static view
           initView()
           
           // init view model
           initVM()
           
       }
       
       override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = Strings.homeTitle
        
       }
       
       //Mark: Setup View Methods
       func initView() {
           tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableView.automaticDimension
       }
       
       func initVM() {
           

           viewModel.updateLoadingStatus = { [weak self] () in
               DispatchQueue.main.async {
                   let isLoading = self?.viewModel.isLoading ?? false
                   if isLoading {
                       self?.activityIndicator.startAnimating()
                       UIView.animate(withDuration: 0.2, animations: {
                           self?.tableView.alpha = 0.0
                       })
                   }else {
                       self?.activityIndicator.stopAnimating()
                       UIView.animate(withDuration: 0.2, animations: {
                           self?.tableView.alpha = 1.0
                       })
                   }
               }
           }
           
           viewModel.reloadTableViewClosure = { [weak self] () in
               DispatchQueue.main.async {
                   self?.tableView.reloadData()
               }
           }
           
           viewModel.initFetch()
           
       }
              
       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
       }


}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.NewsListCellId, for: indexPath) as? NewsTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        
        cell.descriptionLabel.text = cellVM.titleText
        cell.authorLabel.text = cellVM.authorText
        cell.newsImgView.imageFromServerURL(cellVM.imageUrl,placeHolder: UIImage(named: ImageName.placeholder))
    
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {

        self.viewModel.userPressed(at: indexPath)
        return indexPath

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: IdentifierID.detailview, sender: self)
    }
    
}
extension NewsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DeatilViewController,
            let topStory = viewModel.selectedTopStory {
            vc.url = topStory.url
            
            
        }
    }
}
