//
//  LaunchScreenViewController.swift
//  RemoteOk
//
//  Created by Hoff Henry Pereira da Silva on 02/04/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class LaunchScreenViewController: UIViewController {
    
    var player: AVPlayer?
    var jobsDataViewModel =  JobsDataViewModel()
    var jobsOpportunityViewModel = JobOportunityViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadVideo()
        jobsDataViewModel.delegate = self
        jobsDataViewModel.loadJobsFromRemoteOK()
        print("")
    }
    
    func loadVideo() {
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        } catch { }
        
        
        let path = Bundle.main.path(forResource: "launchscreen", ofType: "mp4")
        
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        
        let playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer.zPosition = -1
        
        self.view.layer.addSublayer(playerLayer)
        
        player?.seek(to: kCMTimeZero)
        player?.play()
    }
    
    func callMainStoryboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let str = storyboard.instantiateInitialViewController() else {
            return
        }
        present(str, animated: true, completion: nil)
    }
}

extension LaunchScreenViewController: JobsDataDelegate {
    func loadJobDataSuccessful(array: Array<Any>) {
        jobsOpportunityViewModel.deleteAllOpportunities()
        for job in array{
            let currentJob = JobOportunity()
            let jobDictionary = job as! [String:Any]
            currentJob.position = jobDictionary["position"] as? String
            currentJob.slug = jobDictionary["slug"] as? String
            currentJob.id = jobDictionary["id"] as? String
            currentJob.epoch = jobDictionary["epoch"] as? String
            currentJob.descriptionValue = jobDictionary["description"] as? String
            currentJob.date = jobDictionary["date"] as? String
            currentJob.logo = jobDictionary["logo"] as? String
            currentJob.tags = jobDictionary["tags"] as? [String]
            currentJob.company = jobDictionary["company"] as? String
            currentJob.url = jobDictionary["url"] as? String
            jobsOpportunityViewModel.saveJobFromJSON(currentJob)
        }
        callMainStoryboard()
    }
    
    func loadJobDataFailed(message: String) {
        //print
    }
    
    
}
