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
        jobsDataViewModel.delegate = self
        playVideo()
        jobsDataViewModel.loadJobsFromAbroadJobsAPI()
    }
    
    private func playVideo() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        } catch { }
        configureVideo()
        self.player?.play()
        repeatVideo()
    }
    
    private func configureVideo() {
        let playerLayer = AVPlayerLayer(player: selectVideoFile())
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer.zPosition = -1
        playerLayer.repeatCount = 3
        self.view.layer.addSublayer(playerLayer)
    }
    
    private func selectVideoFile() -> AVPlayer {
        let path = Bundle.main.path(forResource: "launchscreen", ofType: "mp4")
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        guard let securePlayer = player else { return AVPlayer() }
        return securePlayer
    }
    
    private func repeatVideo() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: .main) { _ in
            self.player?.seek(to: kCMTimeZero)
            self.player?.play()
        }
    }
    
    func showMainStoryboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let str = storyboard.instantiateInitialViewController() else { return }
        Hero.shared.defaultAnimation = HeroDefaultAnimationType.fade
        DispatchQueue.main.async {
            self.hero_replaceViewController(with: str)
        }
    }
}

extension LaunchScreenViewController: JobsDataDelegate {
    func loadJobDataSuccessful() {
        NotificationCenter.default.removeObserver(self)
        showMainStoryboard()
    }
    
    func loadJobDataFailed(message: String) {
        noticeError(message)
    }
    
    
}
