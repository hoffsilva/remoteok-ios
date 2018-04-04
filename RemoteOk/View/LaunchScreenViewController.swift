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
import Hero


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
        Hero.shared.defaultAnimation = HeroDefaultAnimationType.fade
        DispatchQueue.main.async {
            self.hero_replaceViewController(with: str)
        }
    }
}

extension LaunchScreenViewController: JobsDataDelegate {
    func loadJobDataSuccessful() {
        callMainStoryboard()
    }
    
    func loadJobDataFailed(message: String) {
        //print
    }
    
    
}
