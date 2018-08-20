//
//  DetailJobWebViewController.swift
//  RemoteOk
//
//  Created by Hoff Henry Pereira da Silva on 31/07/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit
import WebKit

class DetailJobWebViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var jobWebView: UIWebView!
    
    var overlayView = UIView()
    var activityIndicator: UIActivityIndicatorView!
    
    var jobURL = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        jobWebView.delegate = self
        loadActivityIndicator()
        jobWebView.loadRequest(URLRequest(url: URL(string: jobURL)!))
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        removeActivityIndicator()
    }
    
    
    func loadActivityIndicator(){
        self.overlayView = UIView(frame: self.view.bounds)
        self.overlayView.alpha = 0
        self.overlayView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let bgview = UIImageView(image: #imageLiteral(resourceName: "bgwebview"))
        bgview.frame = overlayView.frame
        overlayView.addSubview(bgview)
        overlayView.sendSubview(toBack: bgview)
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.activityIndicator.alpha = 1.0;
        self.activityIndicator.center = self.view.center;
        self.activityIndicator.hidesWhenStopped = true;
        self.overlayView.addSubview(activityIndicator)
        self.view.addSubview(overlayView)
        self.view.bringSubview(toFront: overlayView)
        UIView.animate(withDuration: 0.9, delay: 0.1,  options: .curveEaseIn, animations: {
            self.overlayView.alpha = 0.6
        }, completion: nil)
        self.activityIndicator.startAnimating()
    }
    
    func removeActivityIndicator() {
        UIView.animate(withDuration: 0.5, delay: 0.1,  options: .curveEaseIn, animations: {
            self.overlayView.alpha = 0
        }) { (ok) in
            self.overlayView.removeFromSuperview()
        }
    }

}
