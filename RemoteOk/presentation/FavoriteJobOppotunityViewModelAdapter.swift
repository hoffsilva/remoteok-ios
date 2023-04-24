//
//  FavoriteJobOppotunityViewModelAdapter.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-04-23.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

final class FavoriteJobOppotunityViewModelAdapter: ObservableObject {
    
    @Published var arrayOfJobs = [JobOportunity]()
    @Published var viewDidLoad: Bool = false
    @Published var isLoading = true
    
    private var favoriteJobOpportunityViewModel: FavoriteJobOpportunityViewModel
    
    init(favoriteJobOpportunityViewModel: FavoriteJobOpportunityViewModel) {
        self.favoriteJobOpportunityViewModel = favoriteJobOpportunityViewModel
        setupBindings()
    }
    
    private func setupBindings() {
        
        favoriteJobOpportunityViewModel.didLoadJobs = {
            self.isLoading = false
            self.arrayOfJobs = self.favoriteJobOpportunityViewModel.arrayOfOpportunity ?? [JobOportunity]()
        }
        
    }
    
    func getOpportunities() {
        favoriteJobOpportunityViewModel.getOpportunities()
    }
    
}
