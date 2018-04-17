//
//  DetailJobViewController.swift
//  RemoteOk
//
//  Created by Hoff Silva on 16/04/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit

class DetailJobViewController: UIViewController {
    
    var currentUrl = ""
    var job: Opportunity!
    var jobOpportunityViewModel = JobOportunityViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationItem.leftBarButtonItem?.title = "dassasas"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        title = job.position!
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dataJob" {
            if segue.destination.isKind(of: DetailJobTableViewController.self) {
                let djtbvc = segue.destination as! DetailJobTableViewController
                djtbvc.job = self.job
            }
        }
    }
    
    @IBAction func apply() {
        guard let url =  job.url else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open( URL(string:url)!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL(string:url)!)
        }
    }
    
    @IBAction func addToFavoritesList(_ sender: Any) {
        jobOpportunityViewModel.markJobAsFavorite(job)
    }
    
    @IBAction func shareJob() {
        let someText:String = "Hello! I found this job opportunity on remoteok.io and I would like to share it with you."
        let objectsToShare:URL = URL(string: job.url!)!
        let sharedObjects:[AnyObject] = [objectsToShare as AnyObject,someText as AnyObject]
        let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook,UIActivityType.postToTwitter,UIActivityType.mail]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}
