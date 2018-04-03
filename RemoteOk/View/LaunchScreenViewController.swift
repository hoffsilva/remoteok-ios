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
    
    ///chamada do delegate de load do JSON aqui.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadVideo()
        print("")
    }
    
    private func loadVideo() {
        
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

}
