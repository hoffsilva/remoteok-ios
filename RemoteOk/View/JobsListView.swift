//
//  JobsListView.swift
//  RemoteOk
//
//  Created by Hoff Silva on 06/04/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit
import SDWebImage
import Hero
import SafariServices


class JobsListView: UIViewController {
    
    @IBOutlet weak var remoteFiltersCollectionView: UICollectionView!
    @IBOutlet weak var jobsListTableView: UITableView!
    
    
    var arrayOfFilters = [RemoteFilter]()
    
    var jobViewModel = JobOportunityViewModel()
    var jobDataViewModel = JobsDataViewModel()
    var tagsViewModel = TagsViewModel()
    var currentJobIndex = 0
    var overlayView = UIView()
    var activityIndicator: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        remoteFiltersCollectionView.delegate = self
        remoteFiltersCollectionView.dataSource = self
        jobsListTableView.delegate = self
        jobsListTableView.dataSource = self
        jobDataViewModel.delegate = self
        jobViewModel.delegate = self
        jobViewModel.getAllOpportunities()
        addRefreshControl()
        configureCollectionView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        for destination in segue.destination.childViewControllers {
            if destination.isKind(of: FilterJobsByTagsView.self) {
                (destination as? FilterJobsByTagsView)?.filterJobsDelegate = self
            }
            
        }
        if segue.identifier == "segueDetailJob" {
            let djvc = segue.destination as! DetailJobViewController
            djvc.job = jobViewModel.getJob()
        } else if segue.identifier == "segueDetailJobWebView" {
            let djwvvc = segue.destination as! DetailJobWebViewController
            if let descr = jobViewModel.getJob().url {
                djwvvc.jobURL = descr
            }
        }
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
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        jobViewModel.currentJob = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath) as! JobViewCell
        cell.companyNameLabel.text = jobViewModel.getJob().company ?? "None"
        cell.positionLabel.text = jobViewModel.getJob().position ?? "None"
        
        cell.logoImageView.sd_addActivityIndicator()
        cell.logoImageView.sd_setShowActivityIndicatorView(true)
        
        if let epoch = jobViewModel.getJob().epoch {
            cell.postOriginLabel.text = epoch
        }
        
        
        if let imageUrl = jobViewModel.getJob().logo {
            cell.logoImageView.sd_setImage(with: URL(string: imageUrl)) { (image, error, cache, url) in
                if image == nil {
                    cell.fakeCompanyLogoLabel.isHidden = false
                    if let fakeLogo = self.jobViewModel.getJob().company?.first {
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
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        jobViewModel.currentJob = indexPath.row
        if (jobViewModel.getJob().desc == "") {
            guard let url = jobViewModel.getJob().url, let uri = URL(string: url)  else {
                return
            }
            let vcs = SFSafariViewController(url: uri)
            self.present(vcs, animated: true, completion: nil)
            vcs.delegate = self
        } else {
            performSegue(withIdentifier: "segueDetailJob", sender: self)
        }
        
    }
    
}

extension JobsListView: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}


// MARK - Collectionview delegate and datasource

extension JobsListView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func configureCollectionView() {
        arrayOfFilters = [
            RemoteFilter(image: UIImage(named: "remote-jobs"), title: "All JOBS"),
            RemoteFilter(image: UIImage(named: "dev"), title: "DEV"),
            RemoteFilter(image: UIImage(named: "support"), title: "SUPPORT"),
            RemoteFilter(image: UIImage(named: "marketing"), title: "MARKETING"),
            RemoteFilter(image: UIImage(named: "design"), title: "UI & UX"),
            RemoteFilter(image: UIImage(named: "non-tech"), title: "NON-TECH"),
            RemoteFilter(image: UIImage(named: "english"), title: "EN TEACHER"),
            RemoteFilter(image: #imageLiteral(resourceName: "crypto"), title: "CURRENCY")]
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
        
        loadActivityIndicator()
        switch "\(indexPath.row)" {
        case "0":
            self.title = "All"
            jobDataViewModel.loadJobsFromRemoteOK(ConstantsUtil.getAllJobs())
            break
        case "1":
            self.title = "Dev Jobs"
            jobViewModel.filterJobsBy(tags: ["DEV"])
            break
        case "2":
            self.title = "Support Jobs"
            jobViewModel.filterJobsBy(tags: ["SUPPORT"])
            break
        case "3":
            self.title = "Marketing Jobs"
            jobViewModel.filterJobsBy(tags: ["MARKETING"])
            break
        case "4":
            self.title = "Design Jobs"
            jobViewModel.filterJobsBy(tags: ["DESIGN"])
            break
        case "5":
            self.title = "Non Tech Jobs"
            jobViewModel.filterJobsBy(tags: ["NONTECH"])
            break
        case "6":
            self.title = "English Teacher Jobs"
            jobViewModel.filterJobsBy(tags: ["ENGLISH"])
            break
        case "7":
            self.title = "Cryptojob"
            jobViewModel.filterJobsBy(tags: ["cryptojobslist"])
            break
        default:
            break
        }
    }
    
    
}


extension JobsListView: JobOpportunityDelegate {
    func jobOpportunitiesLoaded() {
        removeActivityIndicator()
        jobViewModel.getAllOpportunities()
        jobsListTableView.reloadData()
    }
}

extension JobsListView: JobsDataDelegate {
    func loadJobDataSuccessful() {
        removeActivityIndicator()
        jobsListTableView.refreshControl?.endRefreshing()
        jobViewModel.getAllOpportunities()
        jobsListTableView.reloadData()
    }
    
    func jobsFiltered() {
        removeActivityIndicator()
        jobsListTableView.reloadData()
    }
    
    func loadJobDataFailed(message: String) {
        
    }
}

extension JobsListView: FilterJobsByTagsDelegate {
    func tagsSelected(selectedTags: [String]) {
        jobViewModel.filterJobsBy(tags: selectedTags)
    }
}

extension JobsListView {
    
    func addRefreshControl() {
        jobsListTableView.refreshControl = UIRefreshControl()
        jobsListTableView.refreshControl?.tintColor = #colorLiteral(red: 0.1450980392, green: 0.1450980392, blue: 0.1450980392, alpha: 1)
        jobsListTableView.refreshControl?.attributedTitle = NSAttributedString(string: "Updating jobs list", attributes: [NSAttributedStringKey.foregroundColor : #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1) ])
        jobsListTableView.refreshControl?.addTarget(self, action: #selector(loadJobs), for: .valueChanged)
    }
    
    @objc func loadJobs() {
        title = "All Jobs"
        jobDataViewModel.loadJobsFromRemoteOK(ConstantsUtil.getAllJobs())
    }
    
    func loadActivityIndicator(){
        self.overlayView = UIView(frame: self.view.bounds)
        self.overlayView.alpha = 0
        self.overlayView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        self.activityIndicator.alpha = 1.0;
        self.activityIndicator.center = self.view.center;
        self.activityIndicator.hidesWhenStopped = true;
        self.overlayView.addSubview(activityIndicator)
        self.view.addSubview(overlayView)
        self.view.bringSubview(toFront: overlayView)
        UIView.animate(withDuration: 0.9, delay: 0.0,  options: .curveEaseIn, animations: {
            self.overlayView.alpha = 0.6
        }, completion: nil)
        self.activityIndicator.startAnimating()
    }
    
    func removeActivityIndicator() {
        UIView.animate(withDuration: 0.5, delay: 0.1,  options: .curveEaseOut, animations: {
            self.overlayView.alpha = 0
        }) { (ok) in
            self.overlayView.removeFromSuperview()
        }
    }
    
}
