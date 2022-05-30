//
//  DetailViewController.swift
//  MVVM
//
//  Created by suganthi on 28/05/22.
//

import Foundation
import WebKit

class DeatilViewController: UIViewController,WKNavigationDelegate {

    var url : String?
    
    @IBOutlet weak var webview: WKWebView!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    lazy var viewModel: LikeViewModel = {
           return LikeViewModel()
       }()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        loadWebviewUrl()
        initVM()
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async { [self] in
                           let isLoading = self?.viewModel.isLoading ?? false
                           if isLoading {
                               self?.activityIndicator.startAnimating()
                               UIView.animate(withDuration: 0.2, animations: {
                                   self?.webview.alpha = 0.0
                               })
                           }else {
                               self?.activityIndicator.stopAnimating()
                               UIView.animate(withDuration: 0.2, animations: {
                                   self?.webview.alpha = 1.0
                               })
                            self!.likeLabel.text = self?.viewModel.processFetchedLikes() ?? Strings.emptystring
                            self!.commentLabel.text = self?.viewModel.processFetchedComments() ?? Strings.emptystring
                           }
                       }
                   }
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initVM() {
        let urlstr = self.url!.removeString(urlstring: self.url!)
        let finalurl = urlstr.replaceString(target: Strings.slash, withString: Strings.dash)
        let likeurl = finalurl.combainString(urlstring: finalurl, type: Strings.likes)
        let commenturl = finalurl.combainString(urlstring: finalurl, type: Strings.comments)
        viewModel.LikeFetch(urlstring: likeurl, commenturl: commenturl)
       
    }
    // MARK: - Setup Webview
    func loadWebviewUrl()  {
         webview.navigationDelegate = self
        activityIndicator.startAnimating()
        let url = URL(string: self.url!)
        webview.load(URLRequest(url: url!))
    }
    
    // MARK: - WEbview Delegates
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()

    }
}
