//
//  JobOportunityViewModel.swift
//  RemoteOk
//
//  Created by Hoff Silva on 29/03/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

protocol JobOportunityViewModel {
    
    var didLoadJobs: (() -> Void)? { get set }
    var didLoadJobsWithError: ((String) -> Void)? { get set }
    var arrayOfOpportunity: [JobOportunity] { get set }
    
    func getOpportunities()
    func getFilteredOpportunities(by query: String)
}

class JobOportunityViewModelImpl: JobOportunityViewModel {
    var didLoadJobs: (() -> Void)?
    var didLoadJobsWithError: ((String) -> Void)?
    var getAllJobsUseCase: GetAllJobsUseCase
    var getFilteredJobsUseCase: GetFilteredJobsUseCase
    var currentPage = 1

    var managedContext = CoreDataStack().persistentContainer.viewContext
    var arrayOfOpportunity = [JobOportunity]()
    
    init(getAllJobsUseCase: GetAllJobsUseCase, getFilteredJobsUseCase: GetFilteredJobsUseCase) {
        self.getAllJobsUseCase = getAllJobsUseCase
        self.getFilteredJobsUseCase = getFilteredJobsUseCase
        setupBindings()
    }

    func getOpportunities() {
        getAllJobsUseCase.getJobsOf(page: currentPage)
    }
    
    func getFilteredOpportunities(by query: String) {
        
    }
    
    private func setupBindings() {
        
        getAllJobsUseCase.didGetJobs = { [weak self] jobs in
            self?.arrayOfOpportunity = jobs
            self?.didLoadJobs?()
        }
        
        getAllJobsUseCase.didGetError = { [weak self] error in
            self?.didLoadJobsWithError?(error.localizedDescription)
        }
        
    }

}
