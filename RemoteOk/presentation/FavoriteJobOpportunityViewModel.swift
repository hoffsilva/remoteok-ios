//
//  FavoriteJobOpportunityViewModel.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-04-23.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

protocol FavoriteJobOpportunityViewModel {
    
    var didLoadJobs: (() -> Void)? { get set }
    var didLoadJobsWithError: ((String) -> Void)? { get set }
    var arrayOfOpportunity: [JobOportunity]? { get set }
    
    func getOpportunities()
}

class FavoriteJobOpportunityViewModelImpl: FavoriteJobOpportunityViewModel {
    
    var arrayOfOpportunity: [JobOportunity]?
    var didLoadJobs: (() -> Void)?
    var didLoadJobsWithError: ((String) -> Void)?
    var getFavoriteJobsUseCase: GetFavoritesJobsUseCase
    
    init(getFavoriteJobsUseCase: GetFavoritesJobsUseCase) {
        self.getFavoriteJobsUseCase = getFavoriteJobsUseCase
        setupBindings()
    }

    func getOpportunities() {
        getFavoriteJobsUseCase.getFavoriteJobs()
    }
    
    func setupBindings() {
        
        getFavoriteJobsUseCase.didGetJobs = { [weak self] jobs in
            if self?.arrayOfOpportunity == nil {
                self?.arrayOfOpportunity = jobs
            } else {
                self?.arrayOfOpportunity! += jobs
            }
            self?.didLoadJobs?()
        }
        
    }

}
