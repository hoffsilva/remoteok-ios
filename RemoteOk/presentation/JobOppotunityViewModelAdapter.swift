//
//  JobOppotunityViewModelAdapter.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-02-08.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation


final class JobOppotunityViewModelAdapter: ObservableObject {
    
    @Published var arrayOfJobs = [JobOportunity]()
    @Published var viewDidLoad: Bool = false
    @Published var isLoading = true
    @Published var favoriteJobAlertMessage = ""
    @Published var isFavorite = false
    
    private var jobOpportunityViewModel: JobOportunityViewModel
    
    init(jobOpportunityViewModel: JobOportunityViewModel) {
        self.jobOpportunityViewModel = jobOpportunityViewModel
        setupBindings()
    }
    
    private func setupBindings() {
        
        jobOpportunityViewModel.didLoadJobs = {
            self.isLoading = false
            self.arrayOfJobs = self.jobOpportunityViewModel.arrayOfOpportunity ?? [JobOportunity]()
        }
        
        jobOpportunityViewModel.didSetAsFavorite = { [weak self] isSuccess in
            self?.favoriteJobAlertMessage = "Ola!"
            self?.isFavorite = true
        }
        
    }
    
    func getFilteredOpportunities(by searchTerm: String) {
        jobOpportunityViewModel.getFilteredOpportunities(by: searchTerm)
    }
    
    func getOpportunities() {
        jobOpportunityViewModel.getOpportunities()
    }
    
    func setOpportunityAsFavorite(job: JobOportunity) {
        jobOpportunityViewModel.setOpportunityAsFavorite(opportunity: job)
    }
    
}
