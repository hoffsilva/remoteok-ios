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
    
    private var jobOpportunityViewModel: JobOportunityViewModel
    
    init(jobOpportunityViewModel: JobOportunityViewModel) {
        self.jobOpportunityViewModel = jobOpportunityViewModel
        setupBindings()
    }
    
    private func setupBindings() {
        
        jobOpportunityViewModel.didLoadJobs = {
            self.arrayOfJobs = self.jobOpportunityViewModel.arrayOfOpportunity ?? [JobOportunity]()
        }

    }
    
    func getFilteredOpportunities(by searchTerm: String) {
        jobOpportunityViewModel.getFilteredOpportunities(by: searchTerm)
    }
    
    func getOpportunities() {
        jobOpportunityViewModel.getOpportunities()
    }
    
}
