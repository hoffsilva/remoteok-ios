//
//  FavoriteJobsListViewUI.swift
//  RemoteOk
//
//  Created by Hoff Silva on 2023-04-23.
//  Copyright © 2023 Hoff Henry Pereira da Silva. All rights reserved.
//

import SwiftUI
import Moya

struct FavoriteJobsListViewUI: View {
    
    @ObservedObject var favoriteJobsViewModel: FavoriteJobOppotunityViewModelAdapter
    
    @State var isDetailingJob = false
    
    var jobsViewModel: JobOppotunityViewModelAdapter
    
    init(favoriteJobsViewModel: FavoriteJobOppotunityViewModelAdapter, jobsViewModel: JobOppotunityViewModelAdapter) {
        self.favoriteJobsViewModel = favoriteJobsViewModel
        self.jobsViewModel = jobsViewModel
    }
    
    var body: some View {
        
        LoadingView(isShowing: .constant(favoriteJobsViewModel.isLoading)) {
            ScrollView {
                LazyVStack {
                    ForEach(favoriteJobsViewModel.arrayOfJobs) { job in
                        JobItemView(job: job, isDetailingJob: self.isDetailingJob, jobsViewModel: jobsViewModel)
                    }
                }
            }
            .navigationTitle("Abroad Jobs")
            .onAppear {
                if !favoriteJobsViewModel.viewDidLoad {
                    self.favoriteJobsViewModel.getOpportunities()
                    favoriteJobsViewModel.viewDidLoad = true
                }
            }
        }
        
    }
    
}

