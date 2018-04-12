//
//  JobsListView.swift
//  RemoteOk
//
//  Created by Hoff Silva on 06/04/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit
import SDWebImage

class JobsListView: UIViewController {
    
    @IBOutlet weak var remoteFiltersCollectionView: UICollectionView!
    @IBOutlet weak var jobsListTableView: UITableView!
    
    var arrayOfFilters = [RemoteFilter]()
    
    var jobViewModel = JobOportunityViewModel()
    var jobDataViewModel = JobsDataViewModel()
    var currentJobIndex = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        remoteFiltersCollectionView.delegate = self
        remoteFiltersCollectionView.dataSource = self
        jobsListTableView.delegate = self
        jobsListTableView.dataSource = self
        jobViewModel.delegate = self
        jobDataViewModel.delegate = self
        jobViewModel.getAllOpportunities()
        addRefreshControl()
        configureCollectionView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


// MARK - Tableview Delegate and Datasource

extension JobsListView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobViewModel.arrayOfOpportunity.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170.0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        jobViewModel.currentJob = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath) as! JobViewCell
        cell.job = jobViewModel.getJob()
        cell.tagsCollectioView.delegate = cell
        cell.tagsCollectioView.dataSource = cell
        cell.tagsCollectioView.reloadData()
        cell.companyNameLabel.text = jobViewModel.getJob().company ?? "None"
        cell.positionLabel.text = jobViewModel.getJob().position ?? "None"
        
        cell.logoImageView.sd_addActivityIndicator()
        cell.logoImageView.sd_setShowActivityIndicatorView(true)
        
        if let imageUrl = jobViewModel.getJob().logo {
            cell.logoImageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
        } else {
            cell.logoImageView.image = #imageLiteral(resourceName: "logo.png")
        }
        return cell
    }
    
}


// MARK - Collectionview delegate and datasource

extension JobsListView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func configureCollectionView() {
        arrayOfFilters = [
            RemoteFilter(image: UIImage(named: "remote-jobs"), title: "REMOTE JOBS"),
            RemoteFilter(image: UIImage(named: "dev"), title: "DEV"),
            RemoteFilter(image: UIImage(named: "support"), title: "SUPPORT"),
            RemoteFilter(image: UIImage(named: "marketing"), title: "MARKETING"),
            RemoteFilter(image: UIImage(named: "design"), title: "UI & UX"),
            RemoteFilter(image: UIImage(named: "non-tech"), title: "NON-TECH"),
            RemoteFilter(image: UIImage(named: "english"), title: "EN TEACHER")]
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return arrayOfFilters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "remoteFilterCell", for: indexPath) as! RemoteFilterCell
        
        if let image = arrayOfFilters[indexPath.row].image {
            cell.filterImageView.image = image
        }
        
        if let title = arrayOfFilters[indexPath.row].title {
            cell.filterTitle.text = title
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch "\(indexPath.row)" {
        case "0":
            jobDataViewModel.loadJobsFromRemoteOK(ConstantsUtil.remoteJobsURL())
            break
        case "1":
            jobDataViewModel.loadJobsFromRemoteOK(ConstantsUtil.devJobsURL())
            break
        case "2":
            jobDataViewModel.loadJobsFromRemoteOK(ConstantsUtil.supportJobsURL())
            break
        case "3":
            jobDataViewModel.loadJobsFromRemoteOK(ConstantsUtil.marketingJobsURL())
            break
        case "4":
            jobDataViewModel.loadJobsFromRemoteOK(ConstantsUtil.designJobsURL())
            break
        case "5":
            jobDataViewModel.loadJobsFromRemoteOK(ConstantsUtil.nonTechJobsURL())
            break
        case "6":
            jobDataViewModel.loadJobsFromRemoteOK(ConstantsUtil.englishTeacherJobsURL())
            break
        default:
            break
        }
    }
    
    
}


extension JobsListView: JobOpportunityDelegate {
    func jobOpportunitiesLoaded() {
        jobViewModel.getAllOpportunities()
        jobsListTableView.reloadData()
    }
}

extension JobsListView: JobsDataDelegate {
    func loadJobDataSuccessful() {
        jobViewModel.getAllOpportunities()
        jobsListTableView.reloadData()
    }
    
    func loadJobDataFailed(message: String) {
        
    }
}

extension JobsListView {
    
    func addRefreshControl() {
        jobsListTableView.refreshControl = UIRefreshControl()
        jobsListTableView.refreshControl?.attributedTitle = NSAttributedString(string: "Update jobs list")
        jobsListTableView.refreshControl?.addTarget(self, action: #selector(loadJobs), for: .valueChanged)
    }
    
    @objc func loadJobs() {
        jobViewModel.getAllOpportunities()
    }
    
}
