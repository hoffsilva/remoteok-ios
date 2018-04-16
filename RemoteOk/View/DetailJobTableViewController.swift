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
    
    var job: Opportunity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jobNameLabel.text = job.position ?? "asasas"
        jobDescriptionLabel.text = job.desc ?? ""
        jobDescriptionWebView.loadHTMLString(job.desc ?? "" , baseURL: nil)
        companyNameLabel.text = job.company ?? ""
        companyLogoImageView.sd_setImage(with: URL(string: job.logo ?? ""), completed: nil)
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

