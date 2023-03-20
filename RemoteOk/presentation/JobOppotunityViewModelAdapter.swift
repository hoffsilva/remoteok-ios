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
    
    private var jobOpportunityViewModel: JobOportunityViewModel
    private let pushNotificationManager: PushNotificationManager
    
    init(jobOpportunityViewModel: JobOportunityViewModel,
         pushNotificationManager: PushNotificationManager) {
        self.jobOpportunityViewModel = jobOpportunityViewModel
        self.pushNotificationManager = pushNotificationManager
        setupBindings()
    }
    
    private func setupBindings() {
        
        jobOpportunityViewModel.didLoadJobs = {
            self.isLoading = false
            self.arrayOfJobs = self.jobOpportunityViewModel.arrayOfOpportunity ?? [JobOportunity]()
        }
        
    }
    
    func requestPushNotificationAuthorization() {
        pushNotificationManager.requestAuthorization()
    }
    
    func getFilteredOpportunities(by searchTerm: String) {
        jobOpportunityViewModel.getFilteredOpportunities(by: searchTerm)
    }
    
    func getOpportunities() {
        jobOpportunityViewModel.getOpportunities()
    }
    
}
