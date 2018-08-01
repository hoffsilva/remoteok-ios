//
//  DetailJobWebViewController.swift
//  RemoteOk
//
//  Created by Hoff Henry Pereira da Silva on 31/07/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit
import WebKit

class DetailJobWebViewController: UIViewController {
    
    @IBOutlet weak var jobWebView: UIWebView!
    
    var jobURL = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        jobWebView.loadRequest(URLRequest(url: URL(string: jobURL)!))
    }
    

}
