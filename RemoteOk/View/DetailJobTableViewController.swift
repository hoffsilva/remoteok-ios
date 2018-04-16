//
//  DetailJobTableViewController.swift
//  RemoteOk
//
//  Created by Hoff Silva on 16/04/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit
import SDWebImage
import WebKit

protocol DetailJobDelegate: class {
    func setJob(url: String)
}

class DetailJobTableViewController: UITableViewController {
    
    @IBOutlet weak var jobNameLabel: UILabel!
    @IBOutlet weak var companyLogoImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var jobDescriptionWebView: WKWebView!
    @IBOutlet weak var jobDescriptionLabel: UILabel!
    @IBOutlet weak var fakeCompanyLogoLabel: UILabel!
    
    var job: Opportunity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jobNameLabel.text = job.position ?? "asasas"
        jobDescriptionLabel.text = job.desc ?? ""
        
        if let imageUrl = job.logo {
            companyLogoImageView.sd_setImage(with: URL(string: imageUrl)) { (image, error, cache, url) in
                if image == nil {
                    self.fakeCompanyLogoLabel.isHidden = false
                    if let fakeLogo = self.job.company?.first {
                        self.fakeCompanyLogoLabel.text = String(fakeLogo).uppercased()
                    } else {
                        self.fakeCompanyLogoLabel.text = "🏢".uppercased()
                    }
                } else {
                    self.fakeCompanyLogoLabel.isHidden = true
                }
            }
        }
        jobDescriptionWebView.loadHTMLString("""
                                             <html>
                                                <head>
                                                    <style type='text/css'>
                                                        body {
                                                            font-family: "Nunito","Helvetica",Arial,sans-serif;
                                                            padding: 0;
                                                            font-size: 30pt;
                                                            text-align: justify;
                                                        }
                                                    </style>
                                                </head>
                                                <body>
                                                \(job.desc!)
                                                </body>
                                                </html>
                                             """ , baseURL: nil)
        companyNameLabel.text = job.company ?? ""
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
            print("sasa")
        })
       
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        self.jobDescriptionWebView.evaluateJavaScript("document.documentElement.outerHTML.toString()") { (html, error) in
//            print(html)
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

