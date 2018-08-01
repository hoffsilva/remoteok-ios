//
//  DetailJobViewController.swift
//  RemoteOk
//
//  Created by Hoff Silva on 16/04/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit

class DetailJobViewController: UIViewController {
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    var currentUrl = ""
    var job: Opportunity?
    var jobFavorite: OportunityFavorite?
    var jobOpportunityViewModel = JobOportunityViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.title = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let position = job?.position {
            title = position
        } else if let position = jobFavorite?.position {
            title = position
        }
        
        if jobFavorite != nil {
            favoriteButton.isEnabled = false
        } else {
            favoriteButton.isEnabled = true
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dataJob" {
            if segue.destination.isKind(of: DetailJobTableViewController.self) {
                let djtbvc = segue.destination as! DetailJobTableViewController
                if let job = self.job {
                    djtbvc.job = job
                } else if let favoriteJob = self.jobFavorite {
                    djtbvc.favoriteJob = favoriteJob
                }
            }
        }
    }
    
    @IBAction func apply() {
        var url: String!
        if let jobURL =  job?.url {
            url = jobURL.replacingOccurrences(of: "remote-jobs/remote-jobs", with: "remote-jobs")
        }
        
        if let favoriteURL = jobFavorite?.url {
            url = favoriteURL
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open( URL(string:url)!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL(string:url)!)
        }
    }
    
    @IBAction func addToFavoritesList(_ sender: Any) {
        jobOpportunityViewModel.markJobAsFavorite(job!) { (result) in
            self.noticeOnlyText(result!)
        }
    }
    
    @IBAction func shareJob() {
        let someText:String = "Hello! I found this job opportunity on remoteok.io and I would like to share it with you."
        var objectsToShare: URL!
        if job == nil {
            objectsToShare = URL(string: jobFavorite!.url!)!
        } else {
            objectsToShare = URL(string: job!.url!)!
        }
        let sharedObjects:[AnyObject] = [objectsToShare as AnyObject,someText as AnyObject]
        let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook,UIActivityType.postToTwitter,UIActivityType.mail]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}
