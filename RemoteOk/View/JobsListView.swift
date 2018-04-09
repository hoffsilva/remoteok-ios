//
//  JobsListView.swift
//  RemoteOk
//
//  Created by Hoff Silva on 06/04/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit
import SDWebImage

class JobsListView: UITableViewController {
    
    var jobViewModel = JobOportunityViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    var currentJobIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        jobViewModel.delegate = self
        jobViewModel.getAllOpportunities()
        configureSearchBar()
        setTableViewBackground()
        addRefreshControl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobViewModel.arrayOfOpportunity.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170.0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        currentJobIndex = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath) as! JobViewCell
        cell.job = jobViewModel.arrayOfOpportunity[currentJobIndex]
        cell.tagsCollectioView.delegate = cell
        cell.tagsCollectioView.dataSource = cell
        cell.tagsCollectioView.collectionViewLayout.invalidateLayout()
        cell.tagsCollectioView.reloadData()
        cell.companyNameLabel.text = jobViewModel.arrayOfOpportunity[currentJobIndex].company ?? "None"
        cell.positionLabel.text = jobViewModel.arrayOfOpportunity[currentJobIndex].position ?? "None"
        
        cell.logoImageView.sd_addActivityIndicator()
        cell.logoImageView.sd_setShowActivityIndicatorView(true)
        
        if let imageUrl = jobViewModel.arrayOfOpportunity[currentJobIndex].logo {
            cell.logoImageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
        } else {
            cell.logoImageView.image = #imageLiteral(resourceName: "logo.png")
        }
        return cell
    }

    func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Jobs keywords separated by comma."
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
        }
        definesPresentationContext = true
    }
    
}



extension JobsListView: JobOpportunityDelegate {
    func jobOpportunitiesLoaded() {
        tableView.reloadData()
    }
}

extension JobsListView {
    
    func setTableViewBackground() {
        let view = UIImageView(frame: tableView.frame)
        view.image = #imageLiteral(resourceName: "lauchscreen")
        view.contentMode = .scaleAspectFill
        view.alpha = 0.2
        tableView.backgroundView = view
    }
    
    func addRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Update jobs list")
        tableView.refreshControl?.addTarget(self, action: #selector(loadJobs), for: .valueChanged)
    }
    
    @objc func loadJobs() {
        jobViewModel.getAllOpportunities()
    }
    
}

extension JobsListView: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        tableView.reloadData()
    }
}
