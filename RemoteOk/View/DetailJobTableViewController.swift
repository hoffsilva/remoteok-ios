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
    @IBOutlet weak var jobDescWebView: UIWebView!
    @IBOutlet weak var jobDescriptionLabel: UILabel!
    @IBOutlet weak var fakeCompanyLogoLabel: UILabel!
    @IBOutlet weak var jobDescriptionTextView: UITextView!
    @IBOutlet weak var jobDescriptionWebView: UIWebView!
    
    var job: Opportunity!
    var favoriteJob: OportunityFavorite!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if let job = self.job {
            
            let position = job.position ?? ""
            let desc = job.desc ?? ""
            let company = job.company ?? ""
            configureJobDetail(position: position , desc: desc, logo: job.logo, company: company)
            
        } else if let favoriteJob = self.favoriteJob {
            
            let position = favoriteJob.position ?? ""
            let desc = favoriteJob.desc ?? ""
            let company = favoriteJob.company ?? ""
            configureJobDetail(position: position , desc: desc, logo: favoriteJob.logo, company: company)
        }
    }
    
    
    func configureJobDetail(position: String, desc: String, logo: String?, company: String) {
        jobNameLabel.text = position
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
        companyNameLabel.text = company
        print(desc.contains("\n"))
        let newDesc = desc.replacingOccurrences(of: "\\n", with: "\n")
        jobDescriptionLabel.text = newDesc
        jobDescriptionTextView.text = newDesc
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

