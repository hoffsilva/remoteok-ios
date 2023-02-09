//
//  JobOportunityViewModel.swift
//  RemoteOk
//
//  Created by Hoff Silva on 29/03/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

protocol JobOportunityViewModel {
    
    var didLoadJobs: (() -> Void)? { get set }
    var didLoadJobsWithError: ((String) -> Void)? { get set }
    var arrayOfOpportunity: [JobOportunity]? { get set }
    
    func getOpportunities()
    func getFilteredOpportunities(by query: String)
}

class JobOportunityViewModelImpl: JobOportunityViewModel {
    
    var arrayOfOpportunity: [JobOportunity]?
    var didLoadJobs: (() -> Void)?
    var didLoadJobsWithError: ((String) -> Void)?
    var getAllJobsUseCase: GetAllJobsUseCase
    var getFilteredJobsUseCase: GetFilteredJobsUseCase
    var currentPage = 1
    
    init(getAllJobsUseCase: GetAllJobsUseCase, getFilteredJobsUseCase: GetFilteredJobsUseCase) {
        self.getAllJobsUseCase = getAllJobsUseCase
        self.getFilteredJobsUseCase = getFilteredJobsUseCase
        setupBindings()
    }

    func getOpportunities() {
        getAllJobsUseCase.getJobsOf(page: currentPage)
    }
    
    func getFilteredOpportunities(by query: String) {
        getFilteredJobsUseCase.searchJobsBy(query: query)
    }
    
    func setupBindings() {
        
        getAllJobsUseCase.didGetJobs = { [weak self] jobs in
            self?.arrayOfOpportunity = jobs
            self?.didLoadJobs?()
        }
        
        getAllJobsUseCase.didGetError = { [weak self] error in
            self?.didLoadJobsWithError?(error.localizedDescription)
        }
        
        getFilteredJobsUseCase.didGetJobs = { [weak self] jobs in
            self?.arrayOfOpportunity = jobs
            self?.didLoadJobs?()
        }
        
        getFilteredJobsUseCase.didGetError = { [weak self] error in
            self?.didLoadJobsWithError?(error.localizedDescription)
        }
        
    }

}
