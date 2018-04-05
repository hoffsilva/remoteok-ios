//
//  ViewController.swift
//  RemoteOk
//
//  Created by Hoff Henry Pereira da Silva on 28/03/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {
    
    let jobViewModel = JobOportunityViewModel()
    
    var player: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        jobViewModel.delegate = self
        //jobViewModel.loadJobsFromRemoteOK()
       // jobViewModel.getAllOpportunities()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        jobViewModel.filterJobsBy(tags: ["marketing"])
        jobViewModel.getTags()
      //  jobViewModel.filterJobsBy(category: "dev")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: JobOpportunityDelegate {
    
    func jobOpportunitiesLoaded() {
        print(jobViewModel.arrayOfOpportunity)
    }
    
    func tagsLoaded() {
        print(jobViewModel.arrayOfTags)
    }
    
}

