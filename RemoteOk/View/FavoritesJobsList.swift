//
//  FavoriteJobsList.swift
//  RemoteOk
//
//  Created by Hoff Silva on 17/04/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit

class FavoritesJobsList: UITableViewController {
    
    var jobViewModel = JobOportunityViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jobViewModel.favoriteDelegate = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         jobViewModel.getAllFavoriteOpportunities()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetailFavoriteJob" {
            let djvc = segue.destination as! DetailJobViewController
            djvc.jobFavorite = jobViewModel.getFavoriteJob()
        } 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if jobViewModel.arrayOfFavoriteOpportunity.count == 0 {
            jobsEmptyNotice(show: true)
        } else {
            jobsEmptyNotice(show: false)
        }
        return jobViewModel.arrayOfFavoriteOpportunity.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        jobViewModel.currentJobFavorite = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath) as! JobViewCell
        cell.companyNameLabel.text = jobViewModel.getFavoriteJob().company ?? "None"
        cell.positionLabel.text = jobViewModel.getFavoriteJob().position ?? "None"
        
        cell.logoImageView.sd_addActivityIndicator()
        cell.logoImageView.sd_setShowActivityIndicatorView(true)
        
        cell.postOriginLabel.text = jobViewModel.getFavoriteJob().slug
        
        if let imageUrl = jobViewModel.getFavoriteJob().logo {
            cell.logoImageView.sd_setImage(with: URL(string: imageUrl)) { (image, error, cache, url) in
                if image == nil {
                    cell.logoImageView.stopAnimating()
                    cell.fakeCompanyLogoLabel.isHidden = false
                    if let fakeLogo = self.jobViewModel.getFavoriteJob().company?.first {
                        cell.fakeCompanyLogoLabel.text = String(fakeLogo).uppercased()
                    } else {
                        cell.fakeCompanyLogoLabel.text = "🏢".uppercased()
                    }
                } else {
                    cell.fakeCompanyLogoLabel.isHidden = true
                }
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        jobViewModel.currentJobFavorite = indexPath.row
        if (jobViewModel.getFavoriteJob().desc == "") {
            performSegue(withIdentifier: "segueDetailFavoriteJobWebView", sender: self)
        } else {
          performSegue(withIdentifier: "segueDetailFavoriteJob", sender: self)
        }
        
    }

    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            jobViewModel.currentJobFavorite = indexPath.row
            let currentJob = jobViewModel.getFavoriteJob()
            jobViewModel.removeJobFromFavorite(currentJob)
            jobViewModel.arrayOfFavoriteOpportunity.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }    
    }
    
    func jobsEmptyNotice(show: Bool) {
        let view = UIView(frame: tableView.frame)
        if show {
            view.isHidden = false
        } else {
            view.isHidden = true
        }
        let label = UILabel(frame: view.frame)
        label.text = "You haven't shortlisted any jobs yet."
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .center
        view.addSubview(label)
        view.bringSubview(toFront: label)
        tableView.backgroundView = view
    }

}

extension FavoritesJobsList: JobOppotunityFavoriteDelegate {
    func favoritesJobsLoaded() {
        tableView.reloadData()
    }
}
