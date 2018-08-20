//
//  FilterJobsByTagsView.swift
//  RemoteOk
//
//  Created by Hoff Silva on 13/04/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit

protocol FilterJobsByTagsDelegate: class {
    func tagsSelected(selectedTags: [String])
}

class FilterJobsByTagsView: UITableViewController {
    
    var filterJobsDelegate: FilterJobsByTagsDelegate?
    
    var tagViewModel = TagsViewModel()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        tagViewModel.tagDelegate = self
        configureSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tagViewModel.getTagsFromJobs()
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
        if tagViewModel.tags[indexPath.row].isSelected {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        cell.tagLabel.text = tagViewModel.tags[indexPath.row].name ?? ""
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TagViewCell
        let accessoryType = cell.accessoryType
        var index = 0
        if accessoryType == UITableViewCellAccessoryType.none {
            cell.accessoryType = .checkmark
            tagViewModel.updateTag(tag: tagViewModel.tags[indexPath.row])
            tagViewModel.selectedTags.append(cell.tagLabel.text!)
            self.noticeOnlyText("\(cell.tagLabel.text!) added to job search")
        } else {
            cell.accessoryType = .none
            tagViewModel.updateTag(tag: tagViewModel.tags[indexPath.row])
            for tag in tagViewModel.selectedTags {
                if tag == cell.tagLabel.text {
                    tagViewModel.selectedTags.remove(at: index)
                    self.noticeOnlyText("\(cell.tagLabel.text!) removed from job search")
                }
                index += 1
            }
        }
    }
    
    func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search tags..."
        searchController.searchBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        searchController.searchBar.barTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        searchController.searchBar.barStyle = .blackOpaque
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
        filterJobsDelegate?.tagsSelected(selectedTags: tagViewModel.selectedTags)
    }
    
    
    
}

extension FilterJobsByTagsView: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if !searchController.isActive {
            tagViewModel.getTags()
        } else {
            guard let term = searchController.searchBar.text else {
                return
            }
            if !term.isEmpty {
                tagViewModel.serchTag(string: term.uppercased())
            }
        }
        tableView.reloadData()
    }
    
    
}

extension FilterJobsByTagsView: TagDelegate {
    func tagsLoaded() {
        tableView.reloadData()
    }
}
