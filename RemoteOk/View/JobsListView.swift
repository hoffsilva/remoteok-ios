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
        cell.tagsCollectioView.delegate = self
        cell.tagsCollectioView.dataSource = self
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


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
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

extension JobsListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
       return UICollectionViewFlowLayoutAutomaticSize
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobViewModel.arrayOfOpportunity[currentJobIndex].tags?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as! TagViewCell
        if let tag = jobViewModel.arrayOfOpportunity[currentJobIndex].tags?[indexPath.row] {
            cell.tagLabel.text =  tag.uppercased()
        } else {
            cell.tagLabel.text = "none"
        }
        return cell
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
