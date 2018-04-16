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
    
    var job: Opportunity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jobNameLabel.text = job.position ?? "asasas"
        jobDescriptionWebView.loadHTMLString(job.desc ?? "", baseURL: nil)
        companyNameLabel.text = job.company ?? ""
        companyLogoImageView.sd_setImage(with: URL(string: job.logo ?? ""), completed: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

