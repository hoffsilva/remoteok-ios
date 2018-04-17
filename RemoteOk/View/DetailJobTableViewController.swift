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
    var favoriteJob: OportunityFavorite!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if job != nil {
            
            let position = job.position ?? ""
            let desc = job.desc ?? ""
            let company = job.company ?? ""
            configureJobDetail(position: position , desc: desc, logo: job.logo, company: company)
            
        } else {
            
            let position = favoriteJob.position ?? ""
            let desc = favoriteJob.desc ?? ""
            let company = favoriteJob.company ?? ""
            configureJobDetail(position: position , desc: desc, logo: favoriteJob.logo, company: company)
        }
    }
    
    
    func configureJobDetail(position: String, desc: String, logo: String?, company: String) {
        
        
        jobNameLabel.text = position
        jobDescriptionLabel.text = desc
        
        if let imageUrl = logo {
            companyLogoImageView.sd_setImage(with: URL(string: imageUrl)) { (image, error, cache, url) in
                if image == nil {
                    self.fakeCompanyLogoLabel.isHidden = false
                    if let fakeLogo = company.first {
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
            \(desc)
            </body>
            </html>
            """ , baseURL: nil)
        companyNameLabel.text = company
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

