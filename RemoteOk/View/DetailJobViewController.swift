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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
}

extension DetailJobViewController: DetailJobDelegate {
    func setJob(url: String) {
        currentUrl = url
    }
}
