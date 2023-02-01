//
//  JobsListView.swift
//  RemoteOk
//
//  Created by Hoff Silva on 06/04/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Hero
import SafariServices
import Kingfisher
import UIKit

class JobsListView: UIViewController {
    @IBOutlet var remoteFiltersCollectionView: UICollectionView!
    @IBOutlet var jobsListTableView: UITableView!

    var arrayOfFilters = [RemoteFilter]()

    var jobViewModel = JobOportunityViewModel()
    var jobDataViewModel = JobsDataViewModel()
    var tagsViewModel = TagsViewModel()
    var currentJobIndex = 0

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

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        for destination in segue.destination.childViewControllers {
            if destination.isKind(of: FilterJobsByTagsView.self) {
                (destination as? FilterJobsByTagsView)?.filterJobsDelegate = self
            }
        }
        if segue.identifier == "segueDetailJob" {
            let djvc = segue.destination as! DetailJobViewController
            djvc.job = jobViewModel.getJob()
        }
    }
}

// MARK: - Tableview Delegate and Datasource

extension JobsListView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return jobViewModel.arrayOfOpportunity.count
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        jobViewModel.currentJob = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath) as! JobViewCell
        cell.configCell(jobViewModel: jobViewModel)
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        jobViewModel.currentJob = indexPath.row
        if jobViewModel.getJob().desc == "" {
            guard let url = jobViewModel.getJob().url, let uri = URL(string: url) else {
                return
            }
            let vcs = SFSafariViewController(url: uri)
            present(vcs, animated: true, completion: nil)
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

// MARK: - Collectionview delegate and datasource

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
            RemoteFilter(image: #imageLiteral(resourceName: "crypto"), title: "CURRENCY"),
        ]
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in _: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return arrayOfFilters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "remoteFilterCell", for: indexPath) as! RemoteFilterCell
        if let image = arrayOfFilters[indexPath.row].image, let title = arrayOfFilters[indexPath.row].title {
            cell.filterImageView.image = image
            cell.filterTitle.text = title
        }
        return cell
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pleaseWaiting()

        switch "\(indexPath.row)" {
        case "0":
            title = "All"
//            jobDataViewModel.loadJobsFromAbroadJobsAPI()
            break
        case "1":
            title = "Dev Jobs"
            jobViewModel.filterJobsBy(tags: ["DEV"])
            break
        case "2":
            title = "Support Jobs"
            jobViewModel.filterJobsBy(tags: ["SUPPORT"])
            break
        case "3":
            title = "Marketing Jobs"
            jobViewModel.filterJobsBy(tags: ["MARKETING"])
            break
        case "4":
            title = "Design Jobs"
            jobViewModel.filterJobsBy(tags: ["DESIGN"])
            break
        case "5":
            title = "Non Tech Jobs"
            jobViewModel.filterJobsBy(tags: ["NONTECH"])
            break
        case "6":
            title = "English Teacher Jobs"
            jobViewModel.filterJobsBy(tags: ["ENGLISH"])
            break
        case "7":
            title = "Cryptojob"
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

    func loadJobDataFailed(message _: String) {}
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
        jobsListTableView.refreshControl?.attributedTitle = NSAttributedString(string: "Updating jobs list", attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)])
        jobsListTableView.refreshControl?.addTarget(self, action: #selector(loadJobs), for: .valueChanged)
    }

    @objc func loadJobs() {
        title = "All Jobs"
        pleaseWaiting()
//        jobDataViewModel.loadJobsFromAbroadJobsAPI()
    }
}
