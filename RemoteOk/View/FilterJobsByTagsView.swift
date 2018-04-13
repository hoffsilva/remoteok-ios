//
//  FilterJobsByTagsView.swift
//  RemoteOk
//
//  Created by Hoff Silva on 13/04/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit

protocol FilterJobsByTagsDelegate: class {
    func tagsSelected()
}

class FilterJobsByTagsView: UITableViewController {
    
    var tagViewModel = TagsViewModel()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        tagViewModel.tagDelegate = self
        configureSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tagViewModel.getTags()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagViewModel.tags.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tagsCell") as! TagViewCell
        cell.tagLabel.text = tagViewModel.tags[indexPath.row]
        return cell
    }
    
    func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search tags."
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
        }
        definesPresentationContext = true
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}

extension FilterJobsByTagsView: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        //jobsController.arrayOfJobs.removeAll()
        tableView.reloadData()
       // jobsController.getJobsBySearch(parameter: searchController.searchBar.text!)
    }
}

extension FilterJobsByTagsView: TagDelegate {
    func tagsLoaded() {
        tableView.reloadData()
    }
}
